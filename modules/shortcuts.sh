#!/bin/bash

# ============================================================
#   NEXUS TERMUX CUSTOMIZER 2026 - Shortcuts Module
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
#   VIEW SHORTCUTS
# ============================================================

view_shortcuts() {
    echo -e "\n${CYAN}  ╔══════════════════════════════════════╗${NC}"
    echo -e "${CYAN}  ║${NC}  ${WHITE}Keyboard Shortcuts${NC}                    ${CYAN}║${NC}"
    echo -e "${CYAN}  ╚══════════════════════════════════════╝${NC}\n"

    echo -e "  ${WHITE}Termux Shortcuts:${NC}"
    echo -e "  ${DARK}----------------------------------------${NC}"
    echo -e "  ${CYAN}Ctrl + A${NC}     ${DARK}=>${NC}  ${WHITE}Home (inicio da linha)${NC}"
    echo -e "  ${CYAN}Ctrl + E${NC}     ${DARK}=>${NC}  ${WHITE}End (fim da linha)${NC}"
    echo -e "  ${CYAN}Ctrl + K${NC}     ${DARK}=>${NC}  ${WHITE}Delete ate o fim da linha${NC}"
    echo -e "  ${CYAN}Ctrl + U${NC}     ${DARK}=>${NC}  ${WHITE}Delete ate o inicio da linha${NC}"
    echo -e "  ${CYAN}Ctrl + W${NC}     ${DARK}=>${NC}  ${WHITE}Delete ultima palavra${NC}"
    echo -e "  ${CYAN}Ctrl + L${NC}     ${DARK}=>${NC}  ${WHITE}Limpar tela${NC}"
    echo -e "  ${CYAN}Ctrl + C${NC}     ${DARK}=>${NC}  ${WHITE}Cancelar comando${NC}"
    echo -e "  ${CYAN}Ctrl + Z${NC}     ${DARK}=>${NC}  ${WHITE}Suspender processo${NC}"
    echo -e "  ${CYAN}Ctrl + D${NC}     ${DARK}=>${NC}  ${WHITE}Sair do shell${NC}"
    echo -e "  ${CYAN}Tab${NC}          ${DARK}=>${NC}  ${WHITE}Auto-completar${NC}"
    echo -e "  ${CYAN}Ctrl + R${NC}     ${DARK}=>${NC}  ${WHITE}Buscar no historico${NC}"
    echo -e "  ${CYAN}Up / Down${NC}    ${DARK}=>${NC}  ${WHITE}Navegar no historico${NC}"
    echo ""
    echo -e "  ${WHITE}Termux Volume Buttons:${NC}"
    echo -e "  ${DARK}----------------------------------------${NC}"
    echo -e "  ${CYAN}Vol Up + Q${NC}   ${DARK}=>${NC}  ${WHITE}Teclado${NC}"
    echo -e "  ${CYAN}Vol Up + W${NC}   ${DARK}=>${NC}  ${WHITE}Ctrl${NC}"
    echo -e "  ${CYAN}Vol Up + E${NC}   ${DARK}=>${NC}  ${WHITE}Esc${NC}"
    echo -e "  ${CYAN}Vol Up + A${NC}   ${DARK}=>${NC}  ${WHITE}Tab${NC}"
    echo -e "  ${CYAN}Vol Up + S${NC}   ${DARK}=>${NC}  ${WHITE}Arrow Up${NC}"
    echo -e "  ${CYAN}Vol Up + Z${NC}   ${DARK}=>${NC}  ${WHITE}Arrow Left${NC}"
    echo -e "  ${CYAN}Vol Up + X${NC}   ${DARK}=>${NC}  ${WHITE}Arrow Down${NC}"
    echo -e "  ${CYAN}Vol Up + C${NC}   ${DARK}=>${NC}  ${WHITE}Arrow Right${NC}"
}

# ============================================================
#   SHORTCUTS MENU
# ============================================================

shortcuts_menu() {
    while true; do
        printf "\033c"
        echo ""
        echo -e "${CYAN}  ╔═══════════════════════════════════════════════╗${NC}"
        echo -e "${CYAN}  ║${NC}       ${WHITE}S H O R T C U T S   G U I D E${NC}            ${CYAN}║${NC}"
        echo -e "${CYAN}  ╚═══════════════════════════════════════════════╝${NC}"
        echo ""
        echo -e "  ${CYAN}[1]${NC}  ${WHITE}Ver atalhos de teclado${NC}"
        echo -e "  ${CYAN}[2]${NC}  ${WHITE}Ver atalhos do Termux${NC}"
        echo -e "  ${DARK}[0]${NC}  ${DARK}Voltar${NC}"
        echo ""
        echo -ne "  ${CYAN}❯${NC} ${WHITE}Selecione: ${NC}"

        read -r choice
        echo ""

        case "$choice" in
            1|2) view_shortcuts ;;
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

shortcuts_menu
