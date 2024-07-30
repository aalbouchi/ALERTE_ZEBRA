README.txt

Ce document explique le fonctionnement du script `ALERT_DUMP_ZEBRA.sh` et fournit des instructions pour son utilisation et son enrichissement.

## Contenu du script

Le script `ALERT_DUMP_ZEBRA.sh` a été créé par Adel ALBOUCHI et sa version actuelle date du 2024-07-30. Ce script est utilisé pour vérifier les dumps HDFS et envoyer une alerte par e-mail si un dump n'a pas été reçu pour la date actuelle.

### Fonctionnement technique

1. **Définition du répertoire et suppression des fichiers temporaires** :
   - Le script définit le répertoire de travail et supprime le fichier temporaire `res.txt` s'il existe.

2. **Définition des destinataires de l'e-mail** :
   - Une liste d'adresses e-mail des destinataires de l'alerte est définie.

3. **Récupération des dates** :
   - Le script récupère la date d'aujourd'hui (`aujourdhui`) et la date d'hier (`hier`), toutes deux au format YYYY-MM-DD.

4. **Lecture des chemins HDFS** :
   - Le script lit les chemins HDFS à partir du fichier `repository_hdfs_path`.

5. **Vérification des dates de modification** :
   - Pour chaque chemin HDFS, le script récupère la date de la dernière modification.
   - Si cette date ne correspond pas à la date d'aujourd'hui, une alerte est écrite dans le fichier `res.txt`.

6. **Envoi de l'alerte par e-mail** :
   - Si une alerte a été générée, un e-mail est envoyé aux destinataires spécifiés.

### Fonctionnement fonctionnel

Le script permet de vérifier quotidiennement si les dumps HDFS ont été correctement reçus et mis à jour. En cas d'anomalie (dump non reçu pour la date actuelle), une alerte est automatiquement envoyée par e-mail aux destinataires concernés.

## Instructions pour enrichir le fichier `repository_hdfs_path`

Le fichier `repository_hdfs_path` contient les chemins HDFS à vérifier. Pour ajouter de nouveaux chemins HDFS à vérifier, suivez les étapes ci-dessous :

1. **Ouvrez le fichier `repository_hdfs_path`** :
   - Le fichier se trouve dans le répertoire `/home/app_prod/ScriptsOP/ALERT_DUMP_ZEBRA/`.
   - Utilisez un éditeur de texte pour ouvrir le fichier, par exemple `nano` ou `vim`.

2. **Ajoutez les nouveaux chemins HDFS** :
   - Ajoutez chaque nouveau chemin HDFS sur une nouvelle ligne.
   - Assurez-vous que chaque chemin est correct et accessible.

3. **Enregistrez et fermez le fichier** :
   - Enregistrez les modifications et fermez l'éditeur de texte.

Exemple de contenu du fichier `repository_hdfs_path` :
