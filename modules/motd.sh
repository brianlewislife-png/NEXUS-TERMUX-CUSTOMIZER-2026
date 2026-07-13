#!/bin/bash

# ============================================================
#   NEXUS TERMUX CUSTOMIZER 2026 - MOTD Module
#   Developer: Brian Lewis
#   Instagram: @Brian_lewis_2
# ============================================================

NEXUS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_DIR="$NEXUS_DIR/config"
MOTD_FILE="$CONFIG_DIR/motd.conf"

CYAN='\033[0;36m'
PURPLE='\033[0;35m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
WHITE='\033[1;37m'
DARK='\033[2;37m'
NC='\033[0m'

source "$CONFIG_DIR/settings.conf" 2>/dev/null || true

# ============================================================
#   VIEW MOTD
# ============================================================

view_motd() {
    echo -e "\n${CYAN}  ╔══════════════════════════════════════╗${NC}"
    echo -e "${CYAN}  ║${NC}  ${WHITE}Current MOTD${NC}                         ${CYAN}║${NC}"
    echo -e "${CYAN}  ╚══════════════════════════════════════╝${NC}\n"

    if [ -f "$MOTD_FILE" ]; then
        cat "$MOTD_FILE"
    else
        echo -e "  ${DARK}Nenhuma mensagem configurada.${NC}"
    fi
}

# ============================================================
#   PRESET MOTDS
# ============================================================

MOTD_WELCOME() {
    local nick="${NEXUS_NICKNAME:-Developer}"
    echo ""
    echo -e "${CYAN}  ╔══════════════════════════════════════╗${NC}"
    echo -e "${CYAN}  ║${NC}                                     ${CYAN}║${NC}"
    echo -e "${CYAN}  ║${NC}  ${WHITE}Welcome back, ${GREEN}${nick}${WHITE}!${NC}                  ${CYAN}║${NC}"
    echo -e "${CYAN}  ║${NC}  ${DARK}Today is $(date +'%A, %d %B %Y')${NC}      ${CYAN}║${NC}"
    echo -e "${CYAN}  ║${NC}  ${DARK}Time: $(date +'%H:%M')${NC}                         ${CYAN}║${NC}"
    echo -e "${CYAN}  ║${NC}                                     ${CYAN}║${NC}"
    echo -e "${CYAN}  ╚══════════════════════════════════════╝${NC}"
    echo ""
}

MOTD_MOTIVATIONAL() {
    echo ""
    echo -e "${PURPLE}  ========================================${NC}"
    echo -e "${WHITE}  $(fortune 2>/dev/null || echo 'Code is poetry.')${NC}"
    echo -e "${PURPLE}  ========================================${NC}"
    echo ""
}

MOTD_SYSTEM() {
    echo ""
    echo -e "${CYAN}  ┌──────────────────────────────────────┐${NC}"
    echo -e "${CYAN}  │${NC}  ${WHITE}System Info${NC}                         ${CYAN}│${NC}"
    echo -e "${CYAN}  ├──────────────────────────────────────┤${NC}"
    echo -e "${CYAN}  │${NC}  ${DARK}User:${NC}   ${WHITE}$(whoami)${NC}                     ${CYAN}│${NC}"
    echo -e "${CYAN}  │${NC}  ${DARK}Device:${NC} ${WHITE}$(getprop ro.product.model 2>/dev/null || echo 'N/A')${NC}       ${CYAN}│${NC}"
    echo -e "${CYAN}  │${NC}  ${DARK}Shell:${NC}  ${WHITE}${SHELL}${NC}                     ${CYAN}│${NC}"
    echo -e "${CYAN}  │${NC}  ${DARK}Date:${NC}   ${WHITE}$(date +'%d/%m/%Y %H:%M')${NC}      ${CYAN}│${NC}"
    echo -e "${CYAN}  └──────────────────────────────────────┘${NC}"
    echo ""
}

MOTD_ASCII() {
    local nick="${NEXUS_NICKNAME:-NEXUS}"
    echo ""
    echo -e "${CYAN}  ██╗  ██╗ █████╗ ███╗   ██╗████████╗${NC}"
    echo -e "${CYAN}  ██║  ██║██╔══██╗████╗  ██║╚══██╔══╝${NC}"
    echo -e "${CYAN}  ███████║███████║██╔██╗ ██║   ██║${NC}"
    echo -e "${CYAN}  ██╔══██║██╔══██║██║╚██╗██║   ██║${NC}"
    echo -e "${CYAN}  ██║  ██║██║  ██║██║ ╚████║   ██║${NC}"
    echo -e "${CYAN}  ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝   ╚═╝${NC}"
    echo -e "  ${DARK}Hello, ${WHITE}${nick}${DARK}!${NC}"
    echo ""
}

# ============================================================
#   SAVE MOTD
# ============================================================

save_motd() {
    local motd_type="$1"
    local shell_rc=""
    [ -f "$HOME/.bashrc" ] && shell_rc="$HOME/.bashrc"
    [ -f "$HOME/.zshrc" ] && shell_rc="$HOME/.zshrc"

    if [ -z "$shell_rc" ]; then
        shell_rc="$HOME/.bashrc"
        touch "$shell_rc"
    fi

    # Remove old MOTD config
    sed -i '/# Nexus MOTD/,/# Nexus MOTD End/d' "$shell_rc" 2>/dev/null || true

    local motd_cmd=""

    case "$motd_type" in
        welcome)    motd_cmd="source $CONFIG_DIR/motd_welcome.sh" ;;
        motivational) motd_cmd="source $CONFIG_DIR/motd_motivational.sh" ;;
        system)     motd_cmd="source $CONFIG_DIR/motd_system.sh" ;;
        ascii)      motd_cmd="source $CONFIG_DIR/motd_ascii.sh" ;;
        custom)     motd_cmd="source $MOTD_FILE" ;;
        off)
            echo -e "\n  ${GREEN}[OK]${NC} MOTD desativado!"
            return
            ;;
    esac

    if [ -n "$motd_cmd" ]; then
        echo "" >> "$shell_rc"
        echo "# Nexus MOTD" >> "$shell_rc"
        echo "$motd_cmd" >> "$shell_rc"
        echo "# Nexus MOTD End" >> "$shell_rc"
    fi
}

# ============================================================
#   MOTD MENU
# ============================================================

motd_menu() {
    while true; do
        printf "\033c"
        echo ""
        echo -e "${CYAN}  ╔═══════════════════════════════════════════════╗${NC}"
        echo -e "${CYAN}  ║${NC}     ${WHITE}M O T D   C O N F I G U R A T O R${NC}          ${CYAN}║${NC}"
        echo -e "${CYAN}  ╚═══════════════════════════════════════════════╝${NC}"
        echo ""
        echo -e "  ${DARK}MOTD = Message of the Day${NC}"
        echo -e "  ${DARK}Mensagem exibida ao abrir o Termux${NC}"
        echo ""
        echo -e "  ${CYAN}[1]${NC}  ${WHITE}Welcome${NC}       ${DARK}- Mensagem de boas-vindas${NC}"
        echo -e "  ${CYAN}[2]${NC}  ${WHITE}Motivational${NC}  ${DARK}- Frase aleatoria (fortune)${NC}"
        echo -e "  ${CYAN}[3]${NC}  ${WHITE}System${NC}        ${DARK}- Info do dispositivo${NC}"
        echo -e "  ${CYAN}[4]${NC}  ${WHITE}ASCII Art${NC}     ${DARK}- Banner ASCII personalizado${NC}"
        echo -e "  ${CYAN}[5]${NC}  ${WHITE}Ver MOTD atual${NC} ${DARK}- Preview da mensagem${NC}"
        echo -e "  ${CYAN}[6]${NC}  ${WHITE}Desativar MOTD${NC} ${DARK}- Remover mensagem${NC}"
        echo -e "  ${DARK}[0]${NC}  ${DARK}Voltar${NC}"
        echo ""
        echo -ne "  ${CYAN}❯${NC} ${WHITE}Selecione: ${NC}"

        read -r choice
        echo ""

        case "$choice" in
            1)
                MOTD_WELCOME
                save_motd "welcome"
                echo -e "  ${GREEN}[OK]${NC} MOTD Welcome aplicado!"
                ;;
            2)
                MOTD_MOTIVATIONAL
                save_motd "motivational"
                echo -e "  ${GREEN}[OK]${NC} MOTD Motivational aplicado!"
                ;;
            3)
                MOTD_SYSTEM
                save_motd "system"
                echo -e "  ${GREEN}[OK]${NC} MOTD System aplicado!"
                ;;
            4)
                MOTD_ASCII
                save_motd "ascii"
                echo -e "  ${GREEN}[OK]${NC} MOTD ASCII aplicado!"
                ;;
            5)
                view_motd
                ;;
            6)
                save_motd "off"
                ;;
            0)
                return
                ;;
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

motd_menu
