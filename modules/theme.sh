#!/bin/bash

# ============================================================
#   NEXUS TERMUX CUSTOMIZER 2026 - Theme Module
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
#   THEME DEFINITIONS
# ============================================================

THEME_CYBER() {
    echo -e "${CYAN}  ╔══════════════════════════════════════╗${NC}"
    echo -e "${CYAN}  ║${NC}    ${WHITE}C Y B E R${NC}   ${CYAN}T H E M E${NC}            ${CYAN}║${NC}"
    echo -e "${CYAN}  ║${NC}                                     ${CYAN}║${NC}"
    echo -e "${CYAN}  ║${NC}  ${CYAN}███████╗${NC} ${CYAN}██████╗ ${NC} ${CYAN}██╗${NC}   ${CYAN}██╗${NC}       ${CYAN}║${NC}"
    echo -e "${CYAN}  ║${NC}  ${CYAN}██╔════╝${NC} ${CYAN}██╔══██╗${NC}${CYAN}██║${NC}   ${CYAN}██║${NC}       ${CYAN}║${NC}"
    echo -e "${CYAN}  ║${NC}  ${CYAN}█████╗${NC}   ${CYAN}██████╔╝${NC}${CYAN}██║${NC}   ${CYAN}██║${NC}       ${CYAN}║${NC}"
    echo -e "${CYAN}  ║${NC}  ${CYAN}██╔══╝${NC}   ${CYAN}██╔══██╗${NC}${CYAN}╚██╗ ${NC}${CYAN}██╔╝${NC}       ${CYAN}║${NC}"
    echo -e "${CYAN}  ║${NC}  ${CYAN}███████╗${NC} ${CYAN}██║  ${CYAN}██║${NC} ${CYAN}╚████╔╝${NC}        ${CYAN}║${NC}"
    echo -e "${CYAN}  ║${NC}  ${CYAN}╚══════╝${NC} ${CYAN}╚═╝  ${CYAN}╚═╝${NC}  ${CYAN}╚═══╝${NC}          ${CYAN}║${NC}"
    echo -e "${CYAN}  ║${NC}                                     ${CYAN}║${NC}"
    echo -e "${CYAN}  ║${NC}  ${DARK}Cores: ${NC}${CYAN}Cyan${NC} ${DARK}|${NC} ${WHITE}Branco${NC} ${DARK}|${NC} ${DARK}Cinza${NC}      ${CYAN}║${NC}"
    echo -e "${CYAN}  ╚══════════════════════════════════════╝${NC}"
}

THEME_NEON() {
    echo -e "${PURPLE}  ╔══════════════════════════════════════╗${NC}"
    echo -e "${PURPLE}  ║${NC}    ${WHITE}N E O N${NC}   ${PURPLE}T H E M E${NC}              ${PURPLE}║${NC}"
    echo -e "${PURPLE}  ║${NC}                                     ${PURPLE}║${NC}"
    echo -e "${PURPLE}  ║${NC}  ${PURPLE}███╗   ██╗${NC}${PURPLE}██████╗ ${NC}${PURPLE}██╗${NC}   ${PURPLE}██╗${NC}       ${PURPLE}║${NC}"
    echo -e "${PURPLE}  ║${NC}  ${PURPLE}████╗  ██║${NC}${PURPLE}██╔══██╗${NC}${PURPLE}██║${NC}   ${PURPLE}██║${NC}       ${PURPLE}║${NC}"
    echo -e "${PURPLE}  ║${NC}  ${PURPLE}██╔██╗ ██║${NC}${PURPLE}██████╔╝${NC}${PURPLE}██║${NC}   ${PURPLE}██║${NC}       ${PURPLE}║${NC}"
    echo -e "${PURPLE}  ║${NC}  ${PURPLE}██║╚██╗██║${NC}${PURPLE}██╔══██╗${NC}${PURPLE}╚██╗ ${NC}${PURPLE}██╔╝${NC}       ${PURPLE}║${NC}"
    echo -e "${PURPLE}  ║${NC}  ${PURPLE}██║ ╚████║${NC}${PURPLE}██║  ${PURPLE}██║${NC} ${PURPLE}╚████╔╝${NC}        ${PURPLE}║${NC}"
    echo -e "${PURPLE}  ║${NC}  ${PURPLE}╚═╝  ╚═══╝${NC}${PURPLE}╚═╝  ${PURPLE}╚═╝${NC}  ${PURPLE}╚═══╝${NC}          ${PURPLE}║${NC}"
    echo -e "${PURPLE}  ║${NC}                                     ${PURPLE}║${NC}"
    echo -e "${PURPLE}  ║${NC}  ${DARK}Cores: ${NC}${PURPLE}Roxo${NC} ${DARK}|${NC} ${PURPLE}Magenta${NC} ${DARK}|${NC} ${WHITE}Rosa${NC}      ${PURPLE}║${NC}"
    echo -e "${PURPLE}  ╚══════════════════════════════════════╝${NC}"
}

THEME_OCEAN() {
    echo -e "${BLUE}  ╔══════════════════════════════════════╗${NC}"
    echo -e "${BLUE}  ║${NC}    ${WHITE}O C E A N${NC}   ${BLUE}T H E M E${NC}             ${BLUE}║${NC}"
    echo -e "${BLUE}  ║${NC}                                     ${BLUE}║${NC}"
    echo -e "${BLUE}  ║${NC}  ${BLUE}██╗  ██╗${NC}${BLUE}██████╗ ${NC}${BLUE}██╗${NC}   ${BLUE}██╗${NC}       ${BLUE}║${NC}"
    echo -e "${BLUE}  ║${NC}  ${BLUE}██║  ██║${NC}${BLUE}██╔══██╗${NC}${BLUE}██║${NC}   ${BLUE}██║${NC}       ${BLUE}║${NC}"
    echo -e "${BLUE}  ║${NC}  ${BLUE}███████║${NC}${BLUE}██████╔╝${NC}${BLUE}██║${NC}   ${BLUE}██║${NC}       ${BLUE}║${NC}"
    echo -e "${BLUE}  ║${NC}  ${BLUE}██╔══██║${NC}${BLUE}██╔══██╗${NC}${BLUE}╚██╗ ${NC}${BLUE}██╔╝${NC}       ${BLUE}║${NC}"
    echo -e "${BLUE}  ║${NC}  ${BLUE}██║  ██║${NC}${BLUE}██║  ${BLUE}██║${NC} ${BLUE}╚████╔╝${NC}        ${BLUE}║${NC}"
    echo -e "${BLUE}  ║${NC}  ${BLUE}╚═╝  ╚═╝${NC}${BLUE}╚═╝  ${BLUE}╚═╝${NC}  ${BLUE}╚═══╝${NC}          ${BLUE}║${NC}"
    echo -e "${BLUE}  ║${NC}                                     ${BLUE}║${NC}"
    echo -e "${BLUE}  ║${NC}  ${DARK}Cores: ${NC}${BLUE}Azul${NC} ${DARK}|${NC} ${BLUE}Royal Blue${NC} ${DARK}|${NC} ${WHITE}Branco${NC}  ${BLUE}║${NC}"
    echo -e "${BLUE}  ╚══════════════════════════════════════╝${NC}"
}

THEME_MATRIX() {
    echo -e "${GREEN}  ╔══════════════════════════════════════╗${NC}"
    echo -e "${GREEN}  ║${NC}    ${WHITE}M A T R I X${NC}   ${GREEN}T H E M E${NC}          ${GREEN}║${NC}"
    echo -e "${GREEN}  ║${NC}                                     ${GREEN}║${NC}"
    echo -e "${GREEN}  ║${NC}  ${GREEN}███╗   ███╗${NC}${GREEN}█████╗ ${NC}${GREEN}██╗${NC}   ${GREEN}██╗${NC}       ${GREEN}║${NC}"
    echo -e "${GREEN}  ║${NC}  ${GREEN}████╗ ████║${NC}${GREEN}██╔══██╗${NC}${GREEN}██║${NC}   ${GREEN}██║${NC}       ${GREEN}║${NC}"
    echo -e "${GREEN}  ║${NC}  ${GREEN}██╔████╔██║${NC}${GREEN}███████║${NC}${GREEN}██║${NC}   ${GREEN}██║${NC}       ${GREEN}║${NC}"
    echo -e "${GREEN}  ║${NC}  ${GREEN}██║╚██╔╝██║${NC}${GREEN}██╔══██║${NC}${GREEN}╚██╗ ${NC}${GREEN}██╔╝${NC}       ${GREEN}║${NC}"
    echo -e "${GREEN}  ║${NC}  ${GREEN}██║ ╚═╝ ██║${NC}${GREEN}██║  ${GREEN}██║${NC} ${GREEN}╚████╔╝${NC}        ${GREEN}║${NC}"
    echo -e "${GREEN}  ║${NC}  ${GREEN}╚═╝     ╚═╝${NC}${GREEN}╚═╝  ${GREEN}╚═╝${NC}  ${GREEN}╚═══╝${NC}          ${GREEN}║${NC}"
    echo -e "${GREEN}  ║${NC}                                     ${GREEN}║${NC}"
    echo -e "${GREEN}  ║${NC}  ${DARK}Cores: ${NC}${GREEN}Verde${NC} ${DARK}|${NC} ${GREEN}Lime${NC} ${DARK}|${NC} ${DARK}Preto${NC}        ${GREEN}║${NC}"
    echo -e "${GREEN}  ╚══════════════════════════════════════╝${NC}"
}

THEME_SUNSET() {
    echo -e "${RED}  ╔══════════════════════════════════════╗${NC}"
    echo -e "${RED}  ║${NC}    ${WHITE}S U N S E T${NC}   ${RED}T H E M E${NC}           ${RED}║${NC}"
    echo -e "${RED}  ║${NC}                                     ${RED}║${NC}"
    echo -e "${RED}  ║${NC}  ${RED}██████╗${NC} ${RED}██████╗ ${NC}${RED}██╗${NC}   ${RED}██╗${NC}       ${RED}║${NC}"
    echo -e "${RED}  ║${NC}  ${RED}██╔══██╗${NC}${RED}██╔══██╗${NC}${RED}██║${NC}   ${RED}██║${NC}       ${RED}║${NC}"
    echo -e "${RED}  ║${NC}  ${RED}██████╔╝${NC}${RED}██████╔╝${NC}${RED}██║${NC}   ${RED}██║${NC}       ${RED}║${NC}"
    echo -e "${RED}  ║${NC}  ${RED}██╔══██╗${NC}${RED}██╔══██╗${NC}${RED}╚██╗ ${NC}${RED}██╔╝${NC}       ${RED}║${NC}"
    echo -e "${RED}  ║${NC}  ${RED}██████╔╝${NC}${RED}██║  ${RED}██║${NC} ${RED}╚████╔╝${NC}        ${RED}║${NC}"
    echo -e "${RED}  ║${NC}  ${RED}╚═════╝ ${NC}${RED}╚═╝  ${RED}╚═╝${NC}  ${RED}╚═══╝${NC}          ${RED}║${NC}"
    echo -e "${RED}  ║${NC}                                     ${RED}║${NC}"
    echo -e "${RED}  ║${NC}  ${DARK}Cores: ${NC}${RED}Vermelho${NC} ${DARK}|${NC} ${YELLOW}Laranja${NC} ${DARK}|${NC} ${WHITE}Dourado${NC} ${RED}║${NC}"
    echo -e "${RED}  ╚══════════════════════════════════════╝${NC}"
}

# ============================================================
#   APPLY THEME TO SHELL
# ============================================================

apply_theme_to_shell() {
    local theme="$1"
    local ps1=""
    local colors=""

    case "$theme" in
        cyber)
            ps1='PS1="\[\033[0;36m\]\u@\h \[\033[1;37m\]\w \[\033[0;36m\]❯ \[\033[0m\]"'
            colors='export LS_COLORS="di=0;36:ln=0;36:so=0;35:pi=0;35:ex=1;32:bd=0;33:cd=0;33:su=0;31:sg=0;31:tw=0;36:ow=0;36"'
            ;;
        neon)
            ps1='PS1="\[\033[0;35m\]\u@\h \[\033[1;37m\]\w \[\033[0;35m\]❯ \[\033[0m\]"'
            colors='export LS_COLORS="di=0;35:ln=0;35:so=0;31:pi=0;31:ex=1;32:bd=0;33:cd=0;33:su=0;31:sg=0;31:tw=0;35:ow=0;35"'
            ;;
        ocean)
            ps1='PS1="\[\033[0;34m\]\u@\h \[\033[1;37m\]\w \[\033[0;34m\]❯ \[\033[0m\]"'
            colors='export LS_COLORS="di=0;34:ln=0;36:so=0;35:pi=0;35:ex=1;32:bd=0;33:cd=0;33:su=0;31:sg=0;31:tw=0;34:ow=0;34"'
            ;;
        matrix)
            ps1='PS1="\[\033[0;32m\]\u@\h \[\033[1;37m\]\w \[\033[0;32m\]❯ \[\033[0m\]"'
            colors='export LS_COLORS="di=0;32:ln=0;36:so=0;35:pi=0;35:ex=1;32:bd=0;33:cd=0;33:su=0;31:sg=0;31:tw=0;32:ow=0;32"'
            ;;
        sunset)
            ps1='PS1="\[\033[0;31m\]\u@\h \[\033[1;37m\]\w \[\033[0;31m\]❯ \[\033[0m\]"'
            colors='export LS_COLORS="di=0;31:ln=0;33:so=0;35:pi=0;35:ex=1;32:bd=0;33:cd=0;33:su=0;31:sg=0;31:tw=0;31:ow=0;31"'
            ;;
    esac

    local shell_rc=""
    [ -f "$HOME/.bashrc" ] && shell_rc="$HOME/.bashrc"
    [ -f "$HOME/.zshrc" ] && shell_rc="$HOME/.zshrc"

    if [ -n "$shell_rc" ]; then
        sed -i '/# Nexus Theme Config/,/Nexus Theme End/d' "$shell_rc" 2>/dev/null || true

        cat >> "$shell_rc" << THEME_RC

# Nexus Theme Config
$ps1
$colors
# Nexus Theme End
THEME_RC
    fi
}

# ============================================================
#   THEME MENU
# ============================================================

theme_menu() {
    while true; do
        printf "\033c"
        echo ""
        echo -e "${CYAN}  ╔═══════════════════════════════════════════════╗${NC}"
        echo -e "${CYAN}  ║${NC}        ${WHITE}T H E M E   S E L E C T O R${NC}            ${CYAN}║${NC}"
        echo -e "${CYAN}  ╚═══════════════════════════════════════════════╝${NC}"
        echo ""
        echo -e "  ${DARK}Tema atual: ${CYAN}${NEXUS_THEME:-cyber}${NC}"
        echo ""
        echo -e "  ${CYAN}[1]${NC}  ${WHITE}Cyber${NC}   ${DARK}- Azul ciano futurista${NC}"
        echo -e "  ${PURPLE}[2]${NC}  ${WHITE}Neon${NC}    ${DARK}- Roxo neon vibrante${NC}"
        echo -e "  ${BLUE}[3]${NC}  ${WHITE}Ocean${NC}   ${DARK}- Azul profundo do oceano${NC}"
        echo -e "  ${GREEN}[4]${NC}  ${WHITE}Matrix${NC}  ${DARK}- Verde classico matrix${NC}"
        echo -e "  ${RED}[5]${NC}  ${WHITE}Sunset${NC}  ${DARK}- Vermelho e laranja${NC}"
        echo -e "  ${DARK}[0]${NC}  ${DARK}Voltar${NC}"
        echo ""
        echo -ne "  ${CYAN}❯${NC} ${WHITE}Selecione um tema: ${NC}"

        read -r choice
        echo ""

        case "$choice" in
            1)  THEME_CYBER;   NEXUS_THEME="cyber";   apply_theme_to_shell "cyber" ;;
            2)  THEME_NEON;    NEXUS_THEME="neon";    apply_theme_to_shell "neon" ;;
            3)  THEME_OCEAN;   NEXUS_THEME="ocean";   apply_theme_to_shell "ocean" ;;
            4)  THEME_MATRIX;  NEXUS_THEME="matrix";  apply_theme_to_shell "matrix" ;;
            5)  THEME_SUNSET;  NEXUS_THEME="sunset";  apply_theme_to_shell "sunset" ;;
            0)  return ;;
            *)
                echo -e "  ${RED}[!]${NC} Opcao invalida."
                sleep 1
                continue
                ;;
        esac

        # Save theme
        if [ -f "$CONFIG_DIR/settings.conf" ]; then
            sed -i "s/^NEXUS_THEME=.*/NEXUS_THEME=\"$NEXUS_THEME\"/" "$CONFIG_DIR/settings.conf"
        fi

        echo ""
        echo -e "  ${GREEN}[OK]${NC} Tema ${CYAN}${NEXUS_THEME}${NC} aplicado com sucesso!"
        echo -e "  ${DARK}Reinicie o terminal para ver as mudancas.${NC}"
        echo ""
        echo -ne "  ${DARK}Pressione [ENTER] para continuar...${NC}"
        read -r
    done
}

theme_menu
