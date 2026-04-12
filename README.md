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

Le dossier de données (`data/`) est trop volumineux pour être hébergé sur GitHub. Veuillez suivre ces étapes pour configurer le projet :

1.  **Télécharger les données :** [Cliquez ici pour télécharger le dossier data](https://partage.imt.fr/index.php/apps/files?dir=/Shared/Projets%20Cassiop%C3%A9e%20Biomim%C3%A9tiques/Travaux%20Louis%20Mennrath%20(Mars-Aout%202025)/D%C3%A9tection%20IA/data&fileid=584216096) (215 Mo).
2.  **Extraire les données :** Placer le dossier à la racine du projet.
3.  **Structure attendue :** Assurez-vous que le chemin ressemble à ceci :
    ```text
    .
    ├── data/               <-- Le dossier téléchargé
    │   └── (fichiers .mat)
    ├── notebook.ipynb      <-- Votre notebook
    ├── requirements.txt
    └── README.md
    ```

## 📓 Utilisation dans VS Code

1.  Ouvrez le dossier du projet dans **VS Code**.
2.  Ouvrez le fichier `.ipynb`.
3.  En haut à droite, cliquez sur **"Sélectionner le noyau"** (Select Kernel).
4.  Choisissez **"Environnements Python..."** puis sélectionnez l'environnement situé dans `.venv`.

---
*Projet à destination des étudiants des projets Cassiopée 41 et 109 session 2026 de Télécom SudParis.*