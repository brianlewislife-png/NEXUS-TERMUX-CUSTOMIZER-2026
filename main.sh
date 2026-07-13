#!/bin/bash

# ============================================================
#   NEXUS TERMUX CUSTOMIZER 2026 - Main Entry Point
#   Developer: Brian Lewis
#   Instagram: @Brian_lewis_2
# ============================================================

set -e

NEXUS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODULES_DIR="$NEXUS_DIR/modules"
CONFIG_DIR="$NEXUS_DIR/config"

# ============================================================
#   COLORS & STYLES
# ============================================================

CYAN='\033[0;36m'
PURPLE='\033[0;35m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
WHITE='\033[1;37m'
DARK='\033[2;37m'
BOLD='\033[1m'
DIM='\033[2m'
NC='\033[0m'

BG_CYAN='\033[46m'
BG_PURPLE='\033[45m'
BG_BLUE='\033[44m'
FG_BLACK='\033[30m'

# ============================================================
#   UTILITY FUNCTIONS
# ============================================================

clear_screen() {
    printf "\033c"
}

sleep_anim() {
    sleep 0.3
}

spinner() {
    local pid=$1
    local msg=$2
    local spin='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
    local i=0

    while kill -0 "$pid" 2>/dev/null; do
        printf "\r  ${CYAN}${spin:i++%${#spin}:1}${NC} ${msg}"
        sleep 0.1
    done
    printf "\r  ${GREEN}[OK]${NC} ${msg}\n"
}

loading_bar() {
    local duration=$1
    local msg=$2
    local width=30
    local filled=0

    echo -ne "\n  ${CYAN}$msg${NC}\n"
    echo -ne "  ["
    while [ $filled -lt $width ]; do
        printf "█"
        ((filled++))
        sleep $(echo "scale=3; $duration / $width" | bc 2>/dev/null || echo "0.05")
    done
    echo -e "] ${GREEN}100%${NC}\n"
}

load_settings() {
    if [ -f "$CONFIG_DIR/settings.conf" ]; then
        source "$CONFIG_DIR/settings.conf"
    else
        NEXUS_VERSION="2.0.0"
        NEXUS_THEME="cyber"
        NEXUS_USERNAME=""
        NEXUS_NICKNAME=""
        NEXUS_BANNER="default"
        NEXUS_COLOR_PRIMARY="cyan"
        NEXUS_COLOR_SECONDARY="purple"
        NEXUS_WELCOME_MSG="true"
        NEXUS_SHOW_BANNER="true"
        NEXUS_SHOW_NEOFETCH="false"
    fi
}

save_settings() {
    cat > "$CONFIG_DIR/settings.conf" << CONF
# Nexus Termux Customizer 2026 - Settings
NEXUS_VERSION="$NEXUS_VERSION"
NEXUS_THEME="$NEXUS_THEME"
NEXUS_USERNAME="$NEXUS_USERNAME"
NEXUS_NICKNAME="$NEXUS_NICKNAME"
NEXUS_BANNER="$NEXUS_BANNER"
NEXUS_COLOR_PRIMARY="$NEXUS_COLOR_PRIMARY"
NEXUS_COLOR_SECONDARY="$NEXUS_COLOR_SECONDARY"
NEXUS_WELCOME_MSG="$NEXUS_WELCOME_MSG"
NEXUS_SHOW_BANNER="$NEXUS_SHOW_BANNER"
NEXUS_SHOW_NEOFETCH="$NEXUS_SHOW_NEOFETCH"
CONF
}

# ============================================================
#   ASCII ART BANNER
# ============================================================

show_banner() {
    local primary="${CYAN}"
    local secondary="${PURPLE}"

    if [ -f "$CONFIG_DIR/settings.conf" ]; then
        case "$NEXUS_COLOR_PRIMARY" in
            cyan)    primary="${CYAN}" ;;
            purple)  primary="${PURPLE}" ;;
            blue)    primary="${BLUE}" ;;
            green)   primary="${GREEN}" ;;
            yellow)  primary="${YELLOW}" ;;
            red)     primary="${RED}" ;;
            *)       primary="${CYAN}" ;;
        esac
    fi

    clear_screen
    echo ""
    echo -e "${primary}"
    cat << 'BANNER'
    ███╗   ██╗███████╗██╗  ██╗██╗   ██╗███████╗      ███████╗██╗  ██╗███████╗███╗   ██╗████████╗
    ████╗  ██║██╔════╝╚██╗██╔╝██║   ██║██╔════╝      ██╔════╝██║  ██║██╔════╝████╗  ██║╚══██╔══╝
    ██╔██╗ ██║█████╗   ╚███╔╝ ██║   ██║███████╗█████╗███████╗███████║█████╗  ██╔██╗ ██║   ██║
    ██║╚██╗██║██╔══╝   ██╔██╗ ██║   ██║╚════██║╚════╝╚════██║██╔══██║██╔══╝  ██║╚██╗██║   ██║
    ██║ ╚████║███████╗██╔╝ ██╗╚██████╔╝███████║      ███████║██║  ██║███████╗██║ ╚████║   ██║
    ╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝      ╚══════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═══╝   ╚═╝
BANNER
    echo -e "${NC}"
    echo -e "  ${secondary}╔═══════════════════════════════════════════════════════════╗${NC}"
    echo -e "  ${secondary}║${NC}  ${WHITE}T E R M U X   C U S T O M I Z E R   2 0 2 6${NC}              ${secondary}║${NC}"
    echo -e "  ${secondary}╚═══════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "  ${DARK}Desenvolvido por: ${WHITE}Brian Lewis${NC}"
    echo -e "  ${DARK}Instagram: ${PURPLE}@Brian_lewis_2${NC}"
    echo ""
    echo -e "  ${DARK}Version: ${CYAN}$NEXUS_VERSION${NC}  ${DARK}Theme: ${CYAN}$NEXUS_THEME${NC}"
    echo ""
}

# ============================================================
#   WELCOME MESSAGE
# ============================================================

show_welcome() {
    local username="$NEXUS_USERNAME"
    local nickname="$NEXUS_NICKNAME"

    if [ -z "$username" ]; then
        username="Developer"
    fi

    echo -e "  ${CYAN}╔═══════════════════════════════════════════════════════╗${NC}"
    echo -e "  ${CYAN}║${NC}                                                       ${CYAN}║${NC}"

    if [ -n "$nickname" ]; then
        echo -e "  ${CYAN}║${NC}  ${WHITE}Welcome back, ${GREEN}${nickname}${WHITE}!${NC}                               ${CYAN}║${NC}"
    else
        echo -e "  ${CYAN}║${NC}  ${WHITE}Welcome, ${GREEN}${username}${WHITE}!${NC}                                      ${CYAN}║${NC}"
    fi

    echo -e "  ${CYAN}║${NC}                                                       ${CYAN}║${NC}"
    echo -e "  ${CYAN}║${NC}  ${DARK}What would you like to customize today?${NC}              ${CYAN}║${NC}"
    echo -e "  ${CYAN}║${NC}                                                       ${CYAN}║${NC}"
    echo -e "  ${CYAN}╚═══════════════════════════════════════════════════════╝${NC}"
    echo ""
}

# ============================================================
#   MAIN MENU
# ============================================================

show_menu() {
    echo -e "  ${PURPLE}┌─────────────────────────────────────────────────────┐${NC}"
    echo -e "  ${PURPLE}│${NC}                 ${WHITE}M A I N   M E N U${NC}                    ${PURPLE}│${NC}"
    echo -e "  ${PURPLE}├─────────────────────────────────────────────────────┤${NC}"
    echo -e "  ${PURPLE}│${NC}                                                     ${PURPLE}│${NC}"
    echo -e "  ${PURPLE}│${NC}  ${CYAN}[1]${NC}  ${WHITE}Personalizar meu terminal${NC}                  ${PURPLE}│${NC}"
    echo -e "  ${PURPLE}│${NC}  ${CYAN}[2]${NC}  ${WHITE}Escolher tema visual${NC}                       ${PURPLE}│${NC}"
    echo -e "  ${PURPLE}│${NC}  ${CYAN}[3]${NC}  ${WHITE}Criar banner personalizado${NC}                 ${PURPLE}│${NC}"
    echo -e "  ${PURPLE}│${NC}  ${CYAN}[4]${NC}  ${WHITE}Gerenciar configuracoes${NC}                    ${PURPLE}│${NC}"
    echo -e "  ${PURPLE}│${NC}  ${CYAN}[5]${NC}  ${WHITE}Fazer backup${NC}                               ${PURPLE}│${NC}"
    echo -e "  ${PURPLE}│${NC}  ${CYAN}[6]${NC}  ${WHITE}Restaurar configuracao${NC}                     ${PURPLE}│${NC}"
    echo -e "  ${PURPLE}│${NC}  ${CYAN}[7]${NC}  ${WHITE}Atualizar ferramenta${NC}                       ${PURPLE}│${NC}"
    echo -e "  ${PURPLE}│${NC}  ${CYAN}[8]${NC}  ${WHITE}Sobre o projeto${NC}                            ${PURPLE}│${NC}"
    echo -e "  ${PURPLE}│${NC}  ${RED}[0]${NC}  ${DARK}Sair${NC}                                       ${PURPLE}│${NC}"
    echo -e "  ${PURPLE}│${NC}                                                     ${PURPLE}│${NC}"
    echo -e "  ${PURPLE}└─────────────────────────────────────────────────────┘${NC}"
    echo ""
    echo -ne "  ${CYAN}❯${NC} ${WHITE}Selecione uma opcao: ${NC}"
}

# ============================================================
#   ABOUT SCREEN
# ============================================================

show_about() {
    clear_screen
    echo ""
    echo -e "${CYAN}"
    cat << 'ABOUT'
    ███╗   ██╗███████╗██╗  ██╗██╗   ██╗███████╗      ███████╗██╗  ██╗███████╗███╗   ██╗████████╗
    ████╗  ██║██╔════╝╚██╗██╔╝██║   ██║██╔════╝      ██╔════╝██║  ██║██╔════╝████╗  ██║╚══██╔══╝
    ██╔██╗ ██║█████╗   ╚███╔╝ ██║   ██║███████╗█████╗███████╗███████║█████╗  ██╔██╗ ██║   ██║
    ██║╚██╗██║██╔══╝   ██╔██╗ ██║   ██║╚════██║╚════╝╚════██║██╔══██║██╔══╝  ██║╚██╗██║   ██║
    ██║ ╚████║███████╗██╔╝ ██╗╚██████╔╝███████║      ███████║██║  ██║███████╗██║ ╚████║   ██║
    ╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝      ╚══════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═══╝   ╚═╝
ABOUT
    echo -e "${NC}"
    echo -e "  ${PURPLE}╔═══════════════════════════════════════════════════════════╗${NC}"
    echo -e "  ${PURPLE}║${NC}          ${WHITE}T E R M U X   C U S T O M I Z E R${NC}              ${PURPLE}║${NC}"
    echo -e "  ${PURPLE}║${NC}                   ${CYAN}2 0 2 6${NC}                               ${PURPLE}║${NC}"
    echo -e "  ${PURPLE}╚═══════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "  ${WHITE}Ferramenta criada e desenvolvida por:${NC}"
    echo ""
    echo -e "  ${CYAN}  ██████╗ ██╗${NC}   ${CYAN}██╗${NC}"
    echo -e "  ${CYAN}  ██╔══██╗██║${NC}   ${CYAN}██║${NC}"
    echo -e "  ${CYAN}  ██████╔╝██║${NC}   ${CYAN}██║${NC}     ${WHITE}Brian Lewis${NC}"
    echo -e "  ${CYAN}  ██╔══██╗██║${NC}   ${CYAN}██║${NC}"
    echo -e "  ${CYAN}  ██████╔╝╚██████╔╝${NC}     ${PURPLE}@Brian_lewis_2${NC}"
    echo -e "  ${CYAN}  ╚═════╝  ╚═════╝${NC}"
    echo ""
    echo -e "  ${DARK}Instagram: ${PURPLE}@Brian_lewis_2${NC}"
    echo ""
    echo -e "  ${WHITE}Projeto desenvolvido para melhorar a experiencia${NC}"
    echo -e "  ${WHITE}de usuarios Termux e Linux.${NC}"
    echo ""
    echo -e "  ${CYAN}Version: ${WHITE}$NEXUS_VERSION${NC}"
    echo -e "  ${CYAN}License: ${WHITE}MIT${NC}"
    echo -e "  ${CYAN}Platform: ${WHITE}Termux / Linux${NC}"
    echo ""
    echo -e "  ${DARK}GitHub: https://github.com/ivisconfessor/nexus-termux-customizer${NC}"
    echo ""
    echo -ne "\n  ${DARK}Pressione [ENTER] para voltar...${NC}"
    read -r
}

# ============================================================
#   FIRST RUN SETUP
# ============================================================

first_run_setup() {
    if [ -z "$NEXUS_USERNAME" ]; then
        clear_screen
        echo ""
        echo -e "${CYAN}========================================${NC}"
        echo -e "${WHITE}     NEXUS TERMUX CUSTOMIZER 2026${NC}"
        echo -e "${CYAN}========================================${NC}"
        echo ""
        echo -e "${WHITE}Bem-vindo! Vamos configurar seu ambiente.${NC}"
        echo ""
        echo -e "${DARK}Responda apenas 2 perguntas para comecar.${NC}"
        echo ""
        echo -e "${CYAN}----------------------------------------${NC}"
        echo ""

        echo -ne "  ${PURPLE}[1/2]${NC} Qual seu nome? ${CYAN}❯${NC} "
        read -r username

        echo ""
        echo -ne "  ${PURPLE}[2/2]${NC} Qual seu apelido/vulgo? ${CYAN}❯${NC} "
        read -r nickname

        if [ -z "$username" ]; then
            username="Developer"
        fi
        if [ -z "$nickname" ]; then
            nickname="$username"
        fi

        NEXUS_USERNAME="$username"
        NEXUS_NICKNAME="$nickname"
        save_settings

        echo ""
        echo -e "${GREEN}  [OK]${NC} Configuracao salva!"
        echo ""
        echo -e "${CYAN}========================================${NC}"
        echo -e "${WHITE}  Ola, ${GREEN}${nickname}${WHITE}! Ambiente configurado.${NC}"
        echo -e "${CYAN}========================================${NC}"
        echo ""
        echo -ne "  ${DARK}Pressione [ENTER] para continuar...${NC}"
        read -r
    fi
}

# ============================================================
#   MODULE LOADER
# ============================================================

load_module() {
    local module="$1"
    if [ -f "$MODULES_DIR/$module" ]; then
        source "$MODULES_DIR/$module"
    else
        echo -e "\n  ${RED}[ERROR]${NC} Modulo nao encontrado: $module"
        echo -ne "  ${DARK}Pressione [ENTER] para voltar...${NC}"
        read -r
    fi
}

# ============================================================
#   MAIN LOOP
# ============================================================

main() {
    load_settings
    first_run_setup

    while true; do
        show_banner
        show_welcome
        show_menu

        read -r choice
        echo ""

        case "$choice" in
            1)  load_module "setup.sh" ;;
            2)  load_module "theme.sh" ;;
            3)  load_module "banner.sh" ;;
            4)  load_module "config_manager.sh" ;;
            5)  load_module "backup.sh" ;;
            6)  load_module "restore.sh" ;;
            7)  load_module "update.sh" ;;
            8)  show_about ;;
            0)
                clear_screen
                echo ""
                echo -e "${CYAN}========================================${NC}"
                echo -e "${WHITE}  Obrigado por usar o${NC}"
                echo -e "${WHITE}  ${PURPLE}NEXUS TERMUX CUSTOMIZER 2026${NC}"
                echo -e "${CYAN}========================================${NC}"
                echo ""
                echo -e "${DARK}Desenvolvido por:${NC}"
                echo -e "${WHITE}Brian Lewis${NC}"
                echo -e "${PURPLE}@Brian_lewis_2${NC}"
                echo ""
                echo -e "${CYAN}========================================${NC}"
                echo ""
                exit 0
                ;;
            *)
                echo -e "  ${RED}[!]${NC} Opcao invalida. Tente novamente."
                sleep 1
                ;;
        esac
    done
}

main "$@"
