#!/bin/bash

# ============================================================
#   NEXUS TERMUX CUSTOMIZER 2026 - Config Manager Module
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

source "$CONFIG_DIR/settings.conf" 2>/dev/null || true

# ============================================================
#   VIEW SETTINGS
# ============================================================

view_settings() {
    echo -e "\n${CYAN}  ╔══════════════════════════════════════╗${NC}"
    echo -e "${CYAN}  ║${NC}  ${WHITE}Current Settings${NC}                      ${CYAN}║${NC}"
    echo -e "${CYAN}  ╚══════════════════════════════════════╝${NC}\n"

    if [ -f "$CONFIG_DIR/settings.conf" ]; then
        echo -e "  ${DARK}┌──────────────────┬─────────────────────┐${NC}"
        echo -e "  ${DARK}│${NC}  ${WHITE}Parametro${NC}       ${DARK}│${NC}  ${WHITE}Valor${NC}               ${DARK}│${NC}"
        echo -e "  ${DARK}├──────────────────┼─────────────────────┤${NC}"
        echo -e "  ${DARK}│${NC}  ${CYAN}Version${NC}         ${DARK}│${NC}  ${WHITE}${NEXUS_VERSION:-N/A}${NC}              ${DARK}│${NC}"
        echo -e "  ${DARK}│${NC}  ${CYAN}Theme${NC}           ${DARK}│${NC}  ${WHITE}${NEXUS_THEME:-N/A}${NC}              ${DARK}│${NC}"
        echo -e "  ${DARK}│${NC}  ${CYAN}Username${NC}        ${DARK}│${NC}  ${WHITE}${NEXUS_USERNAME:-N/A}${NC}              ${DARK}│${NC}"
        echo -e "  ${DARK}│${NC}  ${CYAN}Nickname${NC}        ${DARK}│${NC}  ${WHITE}${NEXUS_NICKNAME:-N/A}${NC}              ${DARK}│${NC}"
        echo -e "  ${DARK}│${NC}  ${CYAN}Banner${NC}          ${DARK}│${NC}  ${WHITE}${NEXUS_BANNER:-N/A}${NC}              ${DARK}│${NC}"
        echo -e "  ${DARK}│${NC}  ${CYAN}Color Primary${NC}   ${DARK}│${NC}  ${WHITE}${NEXUS_COLOR_PRIMARY:-N/A}${NC}              ${DARK}│${NC}"
        echo -e "  ${DARK}│${NC}  ${CYAN}Color Secondary${NC} ${DARK}│${NC}  ${WHITE}${NEXUS_COLOR_SECONDARY:-N/A}${NC}              ${DARK}│${NC}"
        echo -e "  ${DARK}│${NC}  ${CYAN}Welcome Msg${NC}     ${DARK}│${NC}  ${WHITE}${NEXUS_WELCOME_MSG:-N/A}${NC}              ${DARK}│${NC}"
        echo -e "  ${DARK}│${NC}  ${CYAN}Show Banner${NC}     ${DARK}│${NC}  ${WHITE}${NEXUS_SHOW_BANNER:-N/A}${NC}              ${DARK}│${NC}"
        echo -e "  ${DARK}│${NC}  ${CYAN}Show Neofetch${NC}   ${DARK}│${NC}  ${WHITE}${NEXUS_SHOW_NEOFETCH:-N/A}${NC}              ${DARK}│${NC}"
        echo -e "  ${DARK}└──────────────────┴─────────────────────┘${NC}"
    else
        echo -e "  ${RED}[!]${NC} Arquivo de configuracao nao encontrado."
    fi
}

# ============================================================
#   EDIT SETTINGS
# ============================================================

edit_settings() {
    echo -e "\n${CYAN}  ╔══════════════════════════════════════╗${NC}"
    echo -e "${CYAN}  ║${NC}  ${WHITE}Edit Settings${NC}                        ${CYAN}║${NC}"
    echo -e "${CYAN}  ╚══════════════════════════════════════╝${NC}\n"

    echo -e "  ${CYAN}[1]${NC}  ${WHITE}Username${NC}       ${DARK}→ ${WHITE}${NEXUS_USERNAME:-N/A}${NC}"
    echo -e "  ${CYAN}[2]${NC}  ${WHITE}Nickname${NC}       ${DARK}→ ${WHITE}${NEXUS_NICKNAME:-N/A}${NC}"
    echo -e "  ${CYAN}[3]${NC}  ${WHITE}Theme${NC}          ${DARK}→ ${WHITE}${NEXUS_THEME:-N/A}${NC}"
    echo -e "  ${CYAN}[4]${NC}  ${WHITE}Color Primary${NC}  ${DARK}→ ${WHITE}${NEXUS_COLOR_PRIMARY:-N/A}${NC}"
    echo -e "  ${CYAN}[5]${NC}  ${WHITE}Color Secondary${NC}${DARK}→ ${WHITE}${NEXUS_COLOR_SECONDARY:-N/A}${NC}"
    echo -e "  ${CYAN}[6]${NC}  ${WHITE}Show Banner${NC}    ${DARK}→ ${WHITE}${NEXUS_SHOW_BANNER:-N/A}${NC}"
    echo -e "  ${CYAN}[7]${NC}  ${WHITE}Show Neofetch${NC}  ${DARK}→ ${WHITE}${NEXUS_SHOW_NEOFETCH:-N/A}${NC}"
    echo -e "  ${CYAN}[8]${NC}  ${WHITE}Welcome Msg${NC}    ${DARK}→ ${WHITE}${NEXUS_WELCOME_MSG:-N/A}${NC}"
    echo ""
    echo -ne "  ${CYAN}❯${NC} ${WHITE}Qual parametro editar? ${NC}"

    read -r choice

    local param=""
    local current=""

    case "$choice" in
        1) param="NEXUS_USERNAME"; current="$NEXUS_USERNAME" ;;
        2) param="NEXUS_NICKNAME"; current="$NEXUS_NICKNAME" ;;
        3) param="NEXUS_THEME"; current="$NEXUS_THEME" ;;
        4) param="NEXUS_COLOR_PRIMARY"; current="$NEXUS_COLOR_PRIMARY" ;;
        5) param="NEXUS_COLOR_SECONDARY"; current="$NEXUS_COLOR_SECONDARY" ;;
        6) param="NEXUS_SHOW_BANNER"; current="$NEXUS_SHOW_BANNER" ;;
        7) param="NEXUS_SHOW_NEOFETCH"; current="$NEXUS_SHOW_NEOFETCH" ;;
        8) param="NEXUS_WELCOME_MSG"; current="$NEXUS_WELCOME_MSG" ;;
        *)
            echo -e "  ${RED}[!]${NC} Opcao invalida."
            return
            ;;
    esac

    echo -e "\n  ${DARK}Valor atual: ${WHITE}${current:-N/A}${NC}"
    echo -ne "  ${CYAN}❯${NC} ${WHITE}Novo valor: ${NC}"
    read -r new_value

    if [ -n "$new_value" ] && [ -f "$CONFIG_DIR/settings.conf" ]; then
        sed -i "s/^${param}=.*/${param}=\"${new_value}\"/" "$CONFIG_DIR/settings.conf"
        echo -e "\n  ${GREEN}[OK]${NC} ${param} atualizado para: ${WHITE}${new_value}${NC}"
    fi
}

# ============================================================
#   VIEW ALIASES
# ============================================================

view_aliases() {
    echo -e "\n${CYAN}  ╔══════════════════════════════════════╗${NC}"
    echo -e "${CYAN}  ║${NC}  ${WHITE}Current Aliases${NC}                      ${CYAN}║${NC}"
    echo -e "${CYAN}  ╚══════════════════════════════════════╝${NC}\n"

    if [ -f "$CONFIG_DIR/aliases.conf" ]; then
        cat "$CONFIG_DIR/aliases.conf"
    else
        echo -e "  ${RED}[!]${NC} Arquivo de aliases nao encontrado."
    fi
}

# ============================================================
#   ADD ALIAS
# ============================================================

add_alias() {
    echo -e "\n${CYAN}  ╔══════════════════════════════════════╗${NC}"
    echo -e "${CYAN}  ║${NC}  ${WHITE}Add New Alias${NC}                        ${CYAN}║${NC}"
    echo -e "${CYAN}  ╚══════════════════════════════════════╝${NC}\n"

    echo -ne "  ${CYAN}❯${NC} ${WHITE}Nome do alias: ${NC}"
    read -r alias_name

    echo -ne "  ${CYAN}❯${NC} ${WHITE}Comando: ${NC}"
    read -r alias_cmd

    if [ -n "$alias_name" ] && [ -n "$alias_cmd" ]; then
        if [ ! -f "$CONFIG_DIR/aliases.conf" ]; then
            echo "# Nexus Termux Customizer 2026 - Custom Aliases" > "$CONFIG_DIR/aliases.conf"
        fi

        echo "alias ${alias_name}='${alias_cmd}'" >> "$CONFIG_DIR/aliases.conf"
        echo -e "\n  ${GREEN}[OK]${NC} Alias adicionado: ${CYAN}${alias_name}${NC} → ${WHITE}${alias_cmd}${NC}"
    else
        echo -e "\n  ${RED}[!]${NC} Nome e comando sao obrigatorios."
    fi
}

# ============================================================
#   CONFIG MANAGER MENU
# ============================================================

config_manager_menu() {
    while true; do
        printf "\033c"
        echo ""
        echo -e "${CYAN}  ╔═══════════════════════════════════════════════╗${NC}"
        echo -e "${CYAN}  ║${NC}      ${WHITE}C O N F I G   M A N A G E R${NC}               ${CYAN}║${NC}"
        echo -e "${CYAN}  ╚═══════════════════════════════════════════════╝${NC}"
        echo ""
        echo -e "  ${CYAN}[1]${NC}  ${WHITE}Visualizar configuracoes${NC}"
        echo -e "  ${CYAN}[2]${NC}  ${WHITE}Editar configuracoes${NC}"
        echo -e "  ${CYAN}[3]${NC}  ${WHITE}Visualizar aliases${NC}"
        echo -e "  ${CYAN}[4]${NC}  ${WHITE}Adicionar alias${NC}"
        echo -e "  ${DARK}[0]${NC}  ${DARK}Voltar${NC}"
        echo ""
        echo -ne "  ${CYAN}❯${NC} ${WHITE}Selecione: ${NC}"

        read -r choice
        echo ""

        case "$choice" in
            1) view_settings ;;
            2) edit_settings ;;
            3) view_aliases ;;
            4) add_alias ;;
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

config_manager_menu
