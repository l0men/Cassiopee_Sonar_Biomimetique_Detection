# 🐬 Sonar Biomimétique - Détection par IA

Ce projet fait partie du module **Cassiopée** (TSP). Il vise à développer un modèle de détection basé sur l'intelligence artificielle pour traiter des signaux de sonar biomimétique.

## 🚀 Installation rapide avec `uv`

Ce projet utilise [uv](https://github.com/astral-sh/uv) pour une gestion extrêmement rapide des dépendances.

1.  **Cloner le dépôt :**
    ```bash
    git clone https://github.com/l0men/Cassiopee_Sonar_Biomimetique_Detection.git
    cd Cassiopee_Sonar_Biomimetique_Detection
    ```

2.  **Créer l'environnement virtuel et installer les dépendances :**
    ```bash
    uv venv
    uv pip install -r requirements.txt
    ```

## 📊 Données d'entraînement

Le dataset final est trop volumineux pour être hébergé sur GitHub (215 Mo). Vous avez donc deux options pour obtenir les données :

### Option A : Téléchargement rapide (Recommandé)
1.  **Télécharger les données :** [Cliquez ici pour télécharger le dossier data](https://partage.imt.fr/index.php/apps/files?dir=/Shared/Projets%20Cassiop%C3%A9e%20Biomim%C3%A9tiques/Travaux%20Louis%20Mennrath%20(Mars-Aout%202025)/D%C3%A9tection%20IA/data&fileid=584216096) (215 Mo).
2.  **Extraire :** Placez dossier `data/` à la racine du projet.

### Option B : Génération via MATLAB (Reproductibilité)
Si vous souhaitez générer les données vous-même ou modifier les paramètres de simulation (nécessite l'installation d'addons voir prérequis MATLAB) :
1.  Ouvrez MATLAB.
2.  Naviguez dans le dossier `generate_data/`.
3.  Exécutez le script principal (`data_generation.m`). Ce script utilise les matrices de formes stockées dans `matrices_shapes.mat`.
4.  Placez les fichiers générés dans un dossier nommé `data/` à la racine du projet Python.

## 📁 Structure du projet

    .
    ├── data/                 <-- Dossier des données (à créer/télécharger, ignoré par Git)
    ├── generate_data/        <-- Scripts de simulation acoustique
    │   ├── matrices_shapes.mat
    │   └── data_generation.m <-- Script MATLAB (k-Wave)
    ├── .venv/                <-- Environnement virtuel (géré par uv, ignoré par Git)
    ├── notebook.ipynb        <-- Analyse et entraînement de l'IA
    ├── requirements.txt      <-- Liste des dépendances Python
    ├── .gitignore
    └── README.md

## 📓 Utilisation dans VS Code

1.  Ouvrez le dossier du projet dans **VS Code**.
2.  Ouvrez le fichier `.ipynb`.
3.  En haut à droite, cliquez sur **"Sélectionner le noyau"** (Select Kernel).
4.  Choisissez **"Environnements Python..."** puis sélectionnez l'environnement situé dans `.venv`.
5.  Choisissez le fichier de source pour l'apprentissage dans `data/`

### Prérequis MATLAB
Pour exécuter le script de génération de données, vous aurez besoin de :
* **MATLAB** (version R2021a ou supérieure recommandée)
* **Signal Processing Toolbox** (Module officiel MATLAB)
* **k-Wave Toolbox** (Module open-source). [Télécharger k-Wave ici](http://www.k-wave.org/download.php) et ajoutez le dossier à votre chemin (*Path*) MATLAB.

---
*Projet à destination des étudiants des projets Cassiopée 41 et 109 session 2026 de Télécom SudParis.*