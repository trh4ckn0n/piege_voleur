#!/bin/bash

# Fonction pour afficher un message d'accueil
function welcome_message() {
    echo "------------------------------------"
    echo "Bienvenue dans le gestionnaire Git interactif"
    echo "------------------------------------"
}

# Fonction pour vérifier si Git est installé
function check_git_installed() {
    if ! command -v git &> /dev/null
    then
        echo "Erreur : Git n'est pas installé sur ce système. Veuillez l'installer pour continuer."
        exit 1
    fi
}

# Fonction pour configurer l'authentification (token ou clé SSH)
function setup_authentication() {
    if ! git config --get remote.origin.url &> /dev/null
    then
        echo "Aucune URL de dépôt distant trouvée. Vous devez d'abord configurer votre dépôt distant."
        exit 1
    fi
    
    echo "Vérification de l'authentification Git..."

    # Vérification de l'authentification GitHub avec token
    if [[ -z "$(git config --get user.name)" || -z "$(git config --get user.email)" ]]
    then
        echo "Vous devez configurer votre nom et email Git. Utilisez :"
        echo "git config --global user.name 'VotreNom'"
        echo "git config --global user.email 'VotreEmail'"
        exit 1
    fi

    # Demander le token si nécessaire
    if [[ -z "$(git config --get credential.helper)" ]]
    then
        echo "Git n'est pas configuré pour utiliser un token. Voulez-vous entrer votre token GitHub ? (oui/non)"
        read response
        if [[ "$response" == "oui" ]]
        then
            echo -n "Entrez votre token GitHub : "
            read -s token
            echo
            git config --global credential.helper store
            git config --global user.password "$token"
            echo "Token GitHub configuré avec succès."
        fi
    fi
}

# Fonction pour afficher les options de menu
function show_menu() {
    echo "Que souhaitez-vous faire ?"
    echo "1) Pull (récupérer les dernières modifications)"
    echo "2) Commit (faire un commit avec un message)"
    echo "3) Push (pousser les changements vers GitHub)"
    echo "4) Status (voir les modifications non commit)"
    echo "5) Log (voir l'historique des commits)"
    echo "6) Changer de branche"
    echo "7) Quitter"
    echo -n "Choisissez une option (1-7) : "
}

# Fonction pour faire un pull
function git_pull() {
    echo "Récupération des dernières modifications..."
    git pull
}

# Fonction pour faire un commit
function git_commit() {
    echo -n "Entrez votre message de commit : "
    read commit_message
    git add .
    git commit -m "$commit_message"
    echo "Commit effectué avec le message : $commit_message"
}

# Fonction pour faire un push
function git_push() {
    echo "Envoi des changements vers le dépôt distant..."
    git push
}

# Fonction pour afficher le status
function git_status() {
    echo "Affichage de l'état du dépôt..."
    git status
}

# Fonction pour afficher les logs
function git_log() {
    echo "Affichage des derniers commits..."
    git log --oneline --graph --decorate
}

# Fonction pour changer de branche
function git_checkout() {
    echo -n "Entrez le nom de la branche à laquelle vous souhaitez passer : "
    read branch_name
    git checkout "$branch_name"
}

# Fonction pour exécuter le menu interactif
function execute_menu() {
    while true; do
        show_menu
        read choice
        case $choice in
            1)
                git_pull
                ;;
            2)
                git_commit
                ;;
            3)
                git_push
                ;;
            4)
                git_status
                ;;
            5)
                git_log
                ;;
            6)
                git_checkout
                ;;
            7)
                echo "Au revoir !"
                exit 0
                ;;
            *)
                echo "Choix invalide. Veuillez choisir une option entre 1 et 7."
                ;;
        esac
    done
}

# Exécution du script
check_git_installed
welcome_message
setup_authentication
execute_menu
