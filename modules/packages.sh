#!/bin/bash

# ============================================================
#   NEXUS TERMUX CUSTOMIZER 2026 - Packages Module
#   Developer: Brian Lewis
#   Instagram: @Brian_lewis_2
# ============================================================

NEXUS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_DIR="$NEXUS_DIR/config"

CYAN='\033[0;36m'
PURPLE='\033[0;35m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
WHITE='\033[1;37m'
DARK='\033[2;37m'
NC='\033[0m'

# ============================================================
#   CHECK PACKAGE MANAGER
# ============================================================

pkg_update() {
    if [ -d "/data/data/com.termux" ]; then
        pkg update -y > /dev/null 2>&1
    elif command -v apt &> /dev/null; then
        sudo apt update -y > /dev/null 2>&1
    elif command -v pacman &> /dev/null; then
        sudo pacman -Sy --noconfirm > /dev/null 2>&1
    fi
}

pkg_install() {
    local pkg="$1"
    if [ -d "/data/data/com.termux" ]; then
        pkg install -y "$pkg" > /dev/null 2>&1
    elif command -v apt &> /dev/null; then
        sudo apt install -y "$pkg" > /dev/null 2>&1
    elif command -v pacman &> /dev/null; then
        sudo pacman -S --noconfirm "$pkg" > /dev/null 2>&1
    fi
}

# ============================================================
#   INSTALL PACKAGES
# ============================================================

install_packages() {
    local packages=("$@")
    local total=${#packages[@]}
    local current=0

    echo -e "\n${CYAN}  ╔══════════════════════════════════════╗${NC}"
    echo -e "${CYAN}  ║${NC}  ${WHITE}Installing Packages${NC}                    ${CYAN}║${NC}"
    echo -e "${CYAN}  ╚══════════════════════════════════════╝${NC}\n"

    for pkg in "${packages[@]}"; do
        ((current++))
        echo -ne "  ${DARK}[${current}/${total}]${NC} ${WHITE}${pkg}${NC}... "

        if command -v "$pkg" &> /dev/null; then
            echo -e "${GREEN}[JA INSTALADO]${NC}"
        else
            pkg_install "$pkg"
            if command -v "$pkg" &> /dev/null; then
                echo -e "${GREEN}[OK]${NC}"
            else
                echo -e "${YELLOW}[SKIP]${NC}"
            fi
        fi
    done
}

# ============================================================
#   PACKAGE CATEGORIES
# ============================================================

install_essentials() {
    install_packages "git" "curl" "wget" "zip" "unzip" "tar" "tree" "nano" "vim"
}

install_utils() {
    install_packages "neofetch" "htop" "figlet" "fortune" "cowsay" "jq" "bat"
}

install_dev() {
    install_packages "python" "nodejs" "golang" "rust" "ruby" "php"
}

install_network() {
    install_packages "nmap" "net-tools" "dnsutils" "openssh" "sshpass"
}

# ============================================================
#   PACKAGES MENU
# ============================================================

packages_menu() {
    while true; do
        printf "\033c"
        echo ""
        echo -e "${CYAN}  ╔═══════════════════════════════════════════════╗${NC}"
        echo -e "${CYAN}  ║${NC}        ${WHITE}P A C K A G E   M A N A G E R${NC}            ${CYAN}║${NC}"
        echo -e "${CYAN}  ╚═══════════════════════════════════════════════╝${NC}"
        echo ""
        echo -e "  ${CYAN}[1]${NC}  ${WHITE}Essenciais${NC}       ${DARK}- git, curl, wget, nano...${NC}"
        echo -e "  ${CYAN}[2]${NC}  ${WHITE}Utilidades${NC}       ${DARK}- neofetch, htop, figlet...${NC}"
        echo -e "  ${CYAN}[3]${NC}  ${WHITE}Desenvolvimento${NC}  ${DARK}- python, node, golang...${NC}"
        echo -e "  ${CYAN}[4]${NC}  ${WHITE}Rede${NC}             ${DARK}- nmap, openssh, net-tools...${NC}"
        echo -e "  ${CYAN}[5]${NC}  ${WHITE}Tudo${NC}             ${DARK}- Instalar todas as categorias${NC}"
        echo -e "  ${CYAN}[6]${NC}  ${WHITE}Pacote customizado${NC} ${DARK}- Instalar por nome${NC}"
        echo -e "  ${DARK}[0]${NC}  ${DARK}Voltar${NC}"
        echo ""
        echo -ne "  ${CYAN}❯${NC} ${WHITE}Selecione: ${NC}"

        read -r choice
        echo ""

        case "$choice" in
            1)
                echo -e "  ${YELLOW}[*]${NC} Atualizando repositorios..."
                pkg_update
                install_essentials
                ;;
            2)
                echo -e "  ${YELLOW}[*]${NC} Atualizando repositorios..."
                pkg_update
                install_utils
                ;;
            3)
                echo -e "  ${YELLOW}[*]${NC} Atualizando repositorios..."
                pkg_update
                install_dev
                ;;
            4)
                echo -e "  ${YELLOW}[*]${NC} Atualizando repositorios..."
                pkg_update
                install_network
                ;;
            5)
                echo -e "  ${YELLOW}[*]${NC} Atualizando repositorios..."
                pkg_update
                install_essentials
                install_utils
                install_dev
                install_network
                ;;
            6)
                echo -ne "  ${CYAN}❯${NC} ${WHITE}Nome do pacote: ${NC}"
                read -r pkg_name
                if [ -n "$pkg_name" ]; then
                    echo -e "  ${YELLOW}[*]${NC} Atualizando repositorios..."
                    pkg_update
                    install_packages "$pkg_name"
                fi
                ;;
            0) return ;;
            *)
                echo -e "  ${RED}[!]${NC} Opcao invalida."
                sleep 1
                ;;
        esac

        echo ""
        echo -ne "  ${DARK}Pressione [ENTER] para continuar...${NC}"
        read -r
    done
}

packages_menu
