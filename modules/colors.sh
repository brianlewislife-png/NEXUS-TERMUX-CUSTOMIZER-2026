#!/bin/bash

# ============================================================
#   NEXUS TERMUX CUSTOMIZER 2026 - Colors Module
#   Developer: Brian Lewis
#   Instagram: @Brian_lewis_2
# ============================================================

NEXUS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_DIR="$NEXUS_DIR/config"

CYAN='\033[0;36m'
PURPLE='\033[0;35m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
WHITE='\033[1;37m'
DARK='\033[2;37m'
NC='\033[0m'

source "$CONFIG_DIR/settings.conf" 2>/dev/null || true

# ============================================================
#   COLOR SCHEMES
# ============================================================

SCHEME_CYBER() {
    echo -e "${CYAN}  ╔══════════════════════════════════════╗${NC}"
    echo -e "${CYAN}  ║${NC}  ${WHITE}C Y B E R   S C H E M E${NC}                ${CYAN}║${NC}"
    echo -e "${CYAN}  ║${NC}                                     ${CYAN}║${NC}"
    echo -e "${CYAN}  ║${NC}  ${CYAN}███${NC} ${CYAN}███${NC} ${CYAN}███${NC} ${WHITE}███${NC} ${DARK}███${NC}              ${CYAN}║${NC}"
    echo -e "${CYAN}  ║${NC}  ${DARK}Primary: ${NC}${CYAN}Cyan${NC}                       ${CYAN}║${NC}"
    echo -e "${CYAN}  ║${NC}  ${DARK}Cyan, White, Dark Gray${NC}              ${CYAN}║${NC}"
    echo -e "${CYAN}  ╚══════════════════════════════════════╝${NC}"
}

SCHEME_NEON() {
    echo -e "${PURPLE}  ╔══════════════════════════════════════╗${NC}"
    echo -e "${PURPLE}  ║${NC}  ${WHITE}N E O N   S C H E M E${NC}                  ${PURPLE}║${NC}"
    echo -e "${PURPLE}  ║${NC}                                     ${PURPLE}║${NC}"
    echo -e "${PURPLE}  ║${NC}  ${PURPLE}███${NC} ${PURPLE}███${NC} ${RED}███${NC} ${WHITE}███${NC} ${DARK}███${NC}              ${PURPLE}║${NC}"
    echo -e "${PURPLE}  ║${NC}  ${DARK}Primary: ${NC}${PURPLE}Purple${NC}                      ${PURPLE}║${NC}"
    echo -e "${PURPLE}  ║${NC}  ${DARK}Purple, Magenta, Red${NC}               ${PURPLE}║${NC}"
    echo -e "${PURPLE}  ╚══════════════════════════════════════╝${NC}"
}

SCHEME_OCEAN() {
    echo -e "${BLUE}  ╔══════════════════════════════════════╗${NC}"
    echo -e "${BLUE}  ║${NC}  ${WHITE}O C E A N   S C H E M E${NC}                 ${BLUE}║${NC}"
    echo -e "${BLUE}  ║${NC}                                     ${BLUE}║${NC}"
    echo -e "${BLUE}  ║${NC}  ${BLUE}███${NC} ${CYAN}███${NC} ${BLUE}███${NC} ${WHITE}███${NC} ${DARK}███${NC}              ${BLUE}║${NC}"
    echo -e "${BLUE}  ║${NC}  ${DARK}Primary: ${NC}${BLUE}Blue${NC}                         ${BLUE}║${NC}"
    echo -e "${BLUE}  ║${NC}  ${DARK}Blue, Cyan, White${NC}                  ${BLUE}║${NC}"
    echo -e "${BLUE}  ╚══════════════════════════════════════╝${NC}"
}

SCHEME_MATRIX() {
    echo -e "${GREEN}  ╔══════════════════════════════════════╗${NC}"
    echo -e "${GREEN}  ║${NC}  ${WHITE}M A T R I X   S C H E M E${NC}               ${GREEN}║${NC}"
    echo -e "${GREEN}  ║${NC}                                     ${GREEN}║${NC}"
    echo -e "${GREEN}  ║${NC}  ${GREEN}███${NC} ${GREEN}███${NC} ${GREEN}███${NC} ${WHITE}███${NC} ${DARK}███${NC}              ${GREEN}║${NC}"
    echo -e "${GREEN}  ║${NC}  ${DARK}Primary: ${NC}${GREEN}Green${NC}                         ${GREEN}║${NC}"
    echo -e "${GREEN}  ║${NC}  ${DARK}Green, Lime, Black${NC}                 ${GREEN}║${NC}"
    echo -e "${GREEN}  ╚══════════════════════════════════════╝${NC}"
}

SCHEME_SUNSET() {
    echo -e "${RED}  ╔══════════════════════════════════════╗${NC}"
    echo -e "${RED}  ║${NC}  ${WHITE}S U N S E T   S C H E M E${NC}               ${RED}║${NC}"
    echo -e "${RED}  ║${NC}                                     ${RED}║${NC}"
    echo -e "${RED}  ║${NC}  ${RED}███${NC} ${YELLOW}███${NC} ${RED}███${NC} ${WHITE}███${NC} ${DARK}███${NC}              ${RED}║${NC}"
    echo -e "${RED}  ║${NC}  ${DARK}Primary: ${NC}${RED}Red${NC}                            ${RED}║${NC}"
    echo -e "${RED}  ║${NC}  ${DARK}Red, Orange, Yellow${NC}                ${RED}║${NC}"
    echo -e "${RED}  ╚══════════════════════════════════════╝${NC}"
}

SCHEME_DRACULA() {
    echo -e "${PURPLE}  ╔══════════════════════════════════════╗${NC}"
    echo -e "${PURPLE}  ║${NC}  ${WHITE}D R A C U L A   S C H E M E${NC}             ${PURPLE}║${NC}"
    echo -e "${PURPLE}  ║${NC}                                     ${PURPLE}║${NC}"
    echo -e "${PURPLE}  ║${NC}  ${PURPLE}███${NC} ${CYAN}███${NC} ${GREEN}███${NC} ${WHITE}███${NC} ${DARK}███${NC}              ${PURPLE}║${NC}"
    echo -e "${PURPLE}  ║${NC}  ${DARK}Primary: ${NC}${PURPLE}Purple${NC}                      ${PURPLE}║${NC}"
    echo -e "${PURPLE}  ║${NC}  ${DARK}Purple, Cyan, Green, Pink${NC}          ${PURPLE}║${NC}"
    echo -e "${PURPLE}  ╚══════════════════════════════════════╝${NC}"
}

# ============================================================
#   APPLY COLOR SCHEME
# ============================================================

apply_colors() {
    local scheme="$1"
    local shell_rc=""
    [ -f "$HOME/.bashrc" ] && shell_rc="$HOME/.bashrc"
    [ -f "$HOME/.zshrc" ] && shell_rc="$HOME/.zshrc"

    if [ -z "$shell_rc" ]; then
        shell_rc="$HOME/.bashrc"
        touch "$shell_rc"
    fi

    sed -i '/# Nexus Color Scheme/,/# Nexus Color Scheme End/d' "$shell_rc" 2>/dev/null || true

    local color_config=""

    case "$scheme" in
        cyber)
            color_config='export LS_COLORS="di=0;36:ln=0;36:so=0;35:pi=0;35:ex=1;32:bd=0;33:cd=0;33:su=0;31:sg=0;31:tw=0;36:ow=0;36"
export TERM=xterm-256color'
            ;;
        neon)
            color_config='export LS_COLORS="di=0;35:ln=0;35:so=0;31:pi=0;31:ex=1;32:bd=0;33:cd=0;33:su=0;31:sg=0;31:tw=0;35:ow=0;35"
export TERM=xterm-256color'
            ;;
        ocean)
            color_config='export LS_COLORS="di=0;34:ln=0;36:so=0;35:pi=0;35:ex=1;32:bd=0;33:cd=0;33:su=0;31:sg=0;31:tw=0;34:ow=0;34"
export TERM=xterm-256color'
            ;;
        matrix)
            color_config='export LS_COLORS="di=0;32:ln=0;36:so=0;35:pi=0;35:ex=1;32:bd=0;33:cd=0;33:su=0;31:sg=0;31:tw=0;32:ow=0;32"
export TERM=xterm-256color'
            ;;
        sunset)
            color_config='export LS_COLORS="di=0;31:ln=0;33:so=0;35:pi=0;35:ex=1;32:bd=0;33:cd=0;33:su=0;31:sg=0;31:tw=0;31:ow=0;31"
export TERM=xterm-256color'
            ;;
        dracula)
            color_config='export LS_COLORS="di=0;35:ln=0;36:so=0;32:pi=0;32:ex=1;32:bd=0;33:cd=0;33:su=0;31:sg=0;31:tw=0;35:ow=0;35"
export TERM=xterm-256color'
            ;;
    esac

    if [ -n "$color_config" ]; then
        echo "" >> "$shell_rc"
        echo "# Nexus Color Scheme" >> "$shell_rc"
        echo "$color_config" >> "$shell_rc"
        echo "# Nexus Color Scheme End" >> "$shell_rc"
    fi

    # Save to config
    if [ -f "$CONFIG_DIR/settings.conf" ]; then
        sed -i "s/^NEXUS_COLOR_PRIMARY=.*/NEXUS_COLOR_PRIMARY=\"$scheme\"/" "$CONFIG_DIR/settings.conf"
    fi
}

# ============================================================
#   COLORS MENU
# ============================================================

colors_menu() {
    while true; do
        printf "\033c"
        echo ""
        echo -e "${CYAN}  ╔═══════════════════════════════════════════════╗${NC}"
        echo -e "${CYAN}  ║${NC}      ${WHITE}C O L O R   S C H E M E S${NC}                 ${CYAN}║${NC}"
        echo -e "${CYAN}  ╚═══════════════════════════════════════════════╝${NC}"
        echo ""
        echo -e "  ${CYAN}[1]${NC}  ${WHITE}Cyber${NC}     ${DARK}- Cyan futuristic${NC}"
        echo -e "  ${PURPLE}[2]${NC}  ${WHITE}Neon${NC}      ${DARK}- Purple neon${NC}"
        echo -e "  ${BLUE}[3]${NC}  ${WHITE}Ocean${NC}     ${DARK}- Deep blue${NC}"
        echo -e "  ${GREEN}[4]${NC}  ${WHITE}Matrix${NC}    ${DARK}- Green classic${NC}"
        echo -e "  ${RED}[5]${NC}  ${WHITE}Sunset${NC}    ${DARK}- Red and orange${NC}"
        echo -e "  ${PURPLE}[6]${NC}  ${WHITE}Dracula${NC}   ${DARK}- Purple and cyan${NC}"
        echo -e "  ${DARK}[0]${NC}  ${DARK}Voltar${NC}"
        echo ""
        echo -ne "  ${CYAN}❯${NC} ${WHITE}Selecione um esquema de cores: ${NC}"

        read -r choice
        echo ""

        case "$choice" in
            1) SCHEME_CYBER;   apply_colors "cyber" ;;
            2) SCHEME_NEON;    apply_colors "neon" ;;
            3) SCHEME_OCEAN;   apply_colors "ocean" ;;
            4) SCHEME_MATRIX;  apply_colors "matrix" ;;
            5) SCHEME_SUNSET;  apply_colors "sunset" ;;
            6) SCHEME_DRACULA; apply_colors "dracula" ;;
            0) return ;;
            *)
                echo -e "  ${RED}[!]${NC} Opcao invalida."
                sleep 1
                continue
                ;;
        esac

        echo ""
        echo -e "  ${GREEN}[OK]${NC} Esquema de cores aplicado!"
        echo -e "  ${DARK}Reinicie o terminal para ver as mudancas.${NC}"
        echo ""
        echo -ne "  ${DARK}Pressione [ENTER] para continuar...${NC}"
        read -r
    done
}

colors_menu
