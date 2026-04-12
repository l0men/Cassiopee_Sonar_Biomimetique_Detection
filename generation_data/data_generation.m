% =========================================================================
% CLEANING AND IMPORTATION
% =========================================================================

clearvars;
maps = load(".\matrices_shapes.mat");

% =========================================================================
% VISIBLE DOMAIN FUNCTION
% =========================================================================

function visible = computeVisibility(grid, observer, nRays, step)
    % grid : matrice binaire (0 = vide, 1 = obstacle)
    % observer : [i, j] coordonnées du point d'observation (ligne, colonne)
    % nRays : nombre de rayons lancés (ex. 2000)
    % step : taille des pas le long des rayons (1 pour simple, 0.1 pour précis)
    %
    % visible : matrice binaire de même taille que grid
    %           (1 = partie visible de l’objet)

    [rows, cols] = size(grid);
    visible = zeros(rows, cols);

    % Coordonnées de l'observateur
    oi = observer(1);
    oj = observer(2);

    % Boucle sur chaque rayon
    for k = 1:nRays
        % Angle du rayon
        theta = 2*pi * (k-1) / nRays;
        di = cos(theta);
        dj = sin(theta);

        % Position courante (float)
        x = oi;
        y = oj;

        % Avancer le long du rayon
        while true
            x = x + di * step;
            y = y + dj * step;

            % Arrêt si on sort de la grille
            if x < 1 || x > rows || y < 1 || y > cols
                break;
            end

            % Indices entiers
            xi = round(x);
            yj = round(y);

            % Si on rencontre un obstacle
            if grid(xi, yj) == 1
                visible(xi, yj) = 1; % Premier point vu
                break;
            end
        end
    end
end

% =========================================================================
% CREATION OF THE GRID
% =========================================================================

% define the constants
Nx = 150; % [grid points]
Ny = 150; % [grid points]
dx = 1.5e-3; % [m]
dy = 1.5e-3; % [m]

c_water = 1500;
c_object = 3000;

rho_water = 1000;
rho_object = 2000;

% create the computational grid
kgrid = makeGrid(Nx, dx, Ny, dy);

% =========================================================================
% DEFINING THE signal
% =========================================================================

kgrid.makeTime(3000, [], 0.3e-3);

% constants
f = 120e3;   % [Hz]
phi0 = 0;    % [rad]
mag = 10;   % [Pa]

% Tukey window
L = ceil(4/(f * kgrid.dt));  % 4 periods
r = 0.3;    % the taper of the cosine
w_small = tukeywin(L, r);
w = [w_small; zeros(kgrid.Nt - L, 1)];

% define a time varrying source signal
sin_signal = mag * sin(phi0 ...
     + 2 * pi * f * kgrid.t_array);

% sinusoidal burst signal
s1 = sin_signal .* w';

% =========================================================================
% DEFINING THE SOURCE
% =========================================================================

% Defining the position of the source point
source_x_pos = round(Nx * 19/24);
source_y_pos = round(Ny * 1/2);

observer = [source_x_pos, source_y_pos];

source.p_mask = zeros(Nx, Ny);
source.p_mask(source_x_pos,source_y_pos) = 1;

source.p = s1;

% =========================================================================
% DEFINING THE SENSORS
% =========================================================================

% center of the arc (center of the grid)
sensor_center = [Nx, Ny/2];   % in grid units (not meters)
sensor_radius = 40;             % radius in grid points
sensor_nb_points = 41;          % number of sensor points
sensor_arc_angle = pi;          % arc angle in radians (π = half-circle)

% Créer un masque binaire vide
sensor_mask = zeros(Nx, Ny);

% Convertir les coordonnées en indices et arrondir
sensor_indices = round(makeCartCircle(sensor_radius, sensor_nb_points, ...
    sensor_center, sensor_arc_angle));

% S’assurer qu'on reste dans la grille
sensor_indices(1,:) = max(min(sensor_indices(1,:), Nx), 1);
sensor_indices(2,:) = max(min(sensor_indices(2,:), Ny), 1);

% Marquer les positions des capteurs
for i = 1:sensor_nb_points
    sensor_mask(sensor_indices(1,i), sensor_indices(2,i)) = 1;
end

sensor.mask = sensor_mask;  % masque binaire

% =========================================================================
% RUN THE SIMULATION
% =========================================================================

input_args = {'PMLInside', false, 'PMLSize', 20, 'PMLAlpha', 2, ...
    'PlotPML', false, 'PlotSim', false};

Nb_maps = length(fieldnames(maps));

results(Nb_maps) = struct();

for i = 1:Nb_maps
    n = 9+i;

    disp(['Simulation n° ', num2str(i), '/', num2str(Nb_maps)]);

    map_name = ['mat_', num2str(n)];
    map = maps.(map_name);

    medium.sound_speed = c_object * map + (1 - map) * c_water;
    medium.density = rho_object * map + (1 - map) * rho_water;
    medium.sound_speed = double(medium.sound_speed);
    medium.density = double(medium.density);

    sensor_data = kspaceFirstOrder2D(kgrid, medium, ...
    source, sensor, input_args{:});

    results(i).data = reorderSensorData(kgrid, sensor, sensor_data);
    results(i).map = map;
    results(i).visible_section = ...
                              computeVisibility(map, observer, 2000, 0.1);
end

% =========================================================================
% SAVE THE DATA
% =========================================================================

filename = 'moving_ball_IA_simulations_ordered';
save(filename, 'results');

% =========================================================================
% PLOT TO CHECK
% =========================================================================

Sim_num = 131;         % between 1 and 131

% plot the simulated sensor data
figure;
sgtitle(['Map and sensor recorded data for simulation n°', ...
    num2str(Sim_num)]);
subplot(1,3,1)
x = (0:size(results(Sim_num).map,2)-1) * 1.5e-3;  % en mètres
y = (0:size(results(Sim_num).map,1)-1) * 1.5e-3;  % en mètres
imagesc(x, y, results(Sim_num).map);
axis image;  % garde le bon ratio
ylabel('y (m)');
xlabel('x (m)');
title(['mat\_', num2str(Sim_num + 9)]);
subplot(1,3,2)
imagesc(results(Sim_num).visible_section, [-1, 1]);
axis image;
ylabel('y (points)');
xlabel('x (points)');
title('visible\_section')
subplot(1,3,3)
imagesc(results(Sim_num).data, [-1, 1]);
colormap(getColorMap);
ylabel('Sensor Number');
xlabel('Time Step');
colorbar;
title('sensor\_data')
