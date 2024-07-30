#!/bin/bash

# Version du script : 2024-07-30
# Auteur : Adel ALBOUCHI

# Définir le répertoire où les résultats seront stockés
dir="/home/app_prod/ScriptsOP/ALERT_DUMP_ZEBRA"
# Supprimer le fichier temporaire res.txt s'il existe
rm -f "$dir/res.txt"

# Définir la liste des adresses e-mail des destinataires
listmail="adel.albouchi@orange.com"

# Récupérer la date d'aujourd'hui au format YYYY-MM-DD
aujourdhui=$(date '+%Y-%m-%d')

# Récupérer la date d'hier au format YYYY-MM-DD
hier=$(date -d "yesterday" '+%Y-%m-%d')

# Lire les chemins HDFS à partir du fichier repository_hdfs_path
hdfs_paths=$(cat /home/app_prod/ScriptsOP/ALERT_DUMP_ZEBRA/repository_hdfs_path)

# Initialiser une variable pour vérifier si une alerte doit être envoyée
alerte_envoyee=false

# Parcourir chaque chemin HDFS dans le fichier repository_hdfs_path
for path_hdfs in $hdfs_paths; do
  # Récupérer la date de la dernière modification du fichier HDFS
  hdfs_last_modified=$(hdfs dfs -stat "%y" "$path_hdfs" | awk '{print $1}')

  # Comparer la date de la dernière modification avec la date d'aujourd'hui
  if [ "$hdfs_last_modified" != "$aujourdhui" ]; then
    # Extraire le nom du dump à partir du chemin HDFS
    dump_name=$(basename "$path_hdfs")
    # Si les dates ne correspondent pas, écrire une alerte dans le fichier res.txt
    echo "
      - ALERTE_DUMP_$dump_name

      ==> Nous n'avons pas reçu le DUMP ZEBRA pour le dump : ${dump_name}_${hier}
      Veuillez vérifier l'importation.
    " >> "$dir/res.txt"
    alerte_envoyee=true
  fi
done

# Vérifier si une alerte a été envoyée
if [ "$alerte_envoyee" = true ]; then
  # Envoie l'alerte aux destinataires spécifiés
  mailx -s "ALERTE: DUMP IN" "$listmail" < "$dir/res.txt"
  echo "Alerte e-mail envoyée."
else
  # Si les dates correspondent pour tous les chemins, indiquer qu'aucun e-mail d'alerte n'a été envoyé
  echo "Aucun e-mail d'alerte envoyé."
fi
