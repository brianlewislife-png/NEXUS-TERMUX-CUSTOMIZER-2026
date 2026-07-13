#!/bin/bash

# ============================================================
#   NEXUS TERMUX CUSTOMIZER 2026 - Aliases Module
#   Developer: Brian Lewis
#   Instagram: @Brian_lewis_2
# ============================================================

NEXUS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_DIR="$NEXUS_DIR/config"
ALIASES_FILE="$CONFIG_DIR/aliases.conf"

CYAN='\033[0;36m'
PURPLE='\033[0;35m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
WHITE='\033[1;37m'
DARK='\033[2;37m'
NC='\033[0m'

# ============================================================
#   VIEW ALIASES
# ============================================================

view_aliases() {
    echo -e "\n${CYAN}  ╔══════════════════════════════════════╗${NC}"
    echo -e "${CYAN}  ║${NC}  ${WHITE}Your Custom Aliases${NC}                   ${CYAN}║${NC}"
    echo -e "${CYAN}  ╚══════════════════════════════════════╝${NC}\n"

    if [ -f "$ALIASES_FILE" ]; then
        grep "^alias" "$ALIASES_FILE" | while IFS= read -r line; do
            local name=$(echo "$line" | sed 's/alias \([^=]*\)=.*/\1/')
            local cmd=$(echo "$line" | sed "s/alias [^=]*='\(.*\)'/\1/")
            echo -e "  ${CYAN}${name}${NC}  ${DARK}→${NC}  ${WHITE}${cmd}${NC}"
        done
    else
        echo -e "  ${DARK}Nenhum alias encontrado.${NC}"
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
        if [ ! -f "$ALIASES_FILE" ]; then
            echo "# Nexus Termux Customizer 2026 - Aliases" > "$ALIASES_FILE"
        fi

        # Check if alias already exists
        if grep -q "^alias ${alias_name}=" "$ALIASES_FILE" 2>/dev/null; then
            sed -i "s|^alias ${alias_name}=.*|alias ${alias_name}='${alias_cmd}'|" "$ALIASES_FILE"
            echo -e "\n  ${GREEN}[OK]${NC} Alias atualizado: ${CYAN}${alias_name}${NC} → ${WHITE}${alias_cmd}${NC}"
        else
            echo "alias ${alias_name}='${alias_cmd}'" >> "$ALIASES_FILE"
            echo -e "\n  ${GREEN}[OK]${NC} Alias adicionado: ${CYAN}${alias_name}${NC} → ${WHITE}${alias_cmd}${NC}"
        fi
    else
        echo -e "\n  ${RED}[!]${NC} Nome e comando sao obrigatorios."
    fi
}

# ============================================================
#   REMOVE ALIAS
# ============================================================

remove_alias() {
    echo -e "\n${CYAN}  ╔══════════════════════════════════════╗${NC}"
    echo -e "${CYAN}  ║${NC}  ${WHITE}Remove Alias${NC}                         ${CYAN}║${NC}"
    echo -e "${CYAN}  ╚══════════════════════════════════════╝${NC}\n"

    if [ ! -f "$ALIASES_FILE" ]; then
        echo -e "  ${DARK}Nenhum alias encontrado.${NC}"
        return
    fi

    view_aliases

    echo ""
    echo -ne "  ${CYAN}❯${NC} ${WHITE}Nome do alias para remover: ${NC}"
    read -r alias_name

    if [ -n "$alias_name" ]; then
        if grep -q "^alias ${alias_name}=" "$ALIASES_FILE" 2>/dev/null; then
            sed -i "/^alias ${alias_name}=/d" "$ALIASES_FILE"
            echo -e "\n  ${GREEN}[OK]${NC} Alias ${CYAN}${alias_name}${NC} removido!"
        else
            echo -e "\n  ${RED}[!]${NC} Alias nao encontrado."
        fi
    fi
}

# ============================================================
#   PRESET ALIASES
# ============================================================

load_presets() {
    echo -e "\n${CYAN}  ╔══════════════════════════════════════╗${NC}"
    echo -e "${CYAN}  ║${NC}  ${WHITE}Load Preset Aliases${NC}                   ${CYAN}║${NC}"
    echo -e "${CYAN}  ╚══════════════════════════════════════╝${NC}\n"

    echo -e "  ${CYAN}[1]${NC}  ${WHITE}Essential${NC}    ${DARK}- Basic navigation and utils${NC}"
    echo -e "  ${CYAN}[2]${NC}  ${WHITE}Developer${NC}    ${DARK}- Dev tools and shortcuts${NC}"
    echo -e "  ${CYAN}[3]${NC}  ${WHITE}Security${NC}     ${DARK}- Security related aliases${NC}"
    echo -e "  ${CYAN}[4]${NC}  ${WHITE}All presets${NC}  ${DARK}- Load everything${NC}"
    echo -e "  ${DARK}[0]${NC}  ${DARK}Voltar${NC}"
    echo ""
    echo -ne "  ${CYAN}❯${NC} ${WHITE}Selecione: ${NC}"

    read -r choice

    if [ ! -f "$ALIASES_FILE" ]; then
        echo "# Nexus Termux Customizer 2026 - Aliases" > "$ALIASES_FILE"
    fi

    case "$choice" in
        1)
            cat >> "$ALIASES_FILE" << 'ALIASES'
# Essential Aliases
alias ll='ls -la --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias cls='clear'
alias home='cd ~'
alias reload='source ~/.bashrc'
ALIASES
            echo -e "\n  ${GREEN}[OK]${NC} Essential aliases carregados!"
            ;;
        2)
            cat >> "$ALIASES_FILE" << 'ALIASES'
# Developer Aliases
alias docs='cd ~/Documents'
alias downloads='cd ~/Downloads'
alias projects='cd ~/projects'
alias serve='python3 -m http.server 8080'
alias py='python3'
alias node='node'
alias npm='npm'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline'
alias gpsh='git push origin main'
ALIASES
            echo -e "\n  ${GREEN}[OK]${NC} Developer aliases carregados!"
            ;;
        3)
            cat >> "$ALIASES_FILE" << 'ALIASES'
# Security Aliases
alias ports='netstat -tuln'
alias myip='curl -s ifconfig.me'
alias localip='hostname -I'
alias openports='netstat -tlnp'
alias scan='nmap -sV'
alias hash='md5sum'
alias checkperm='ls -la'
ALIASES
            echo -e "\n  ${GREEN}[OK]${NC} Security aliases carregados!"
            ;;
        4)
            cat >> "$ALIASES_FILE" << 'ALIASES'
# Essential Aliases
alias ll='ls -la --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias cls='clear'
alias home='cd ~'
alias reload='source ~/.bashrc'
# Developer Aliases
alias docs='cd ~/Documents'
alias downloads='cd ~/Downloads'
alias projects='cd ~/projects'
alias serve='python3 -m http.server 8080'
alias py='python3'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline'
# Security Aliases
alias ports='netstat -tuln'
alias myip='curl -s ifconfig.me'
alias localip='hostname -I'
ALIASES
            echo -e "\n  ${GREEN}[OK]${NC} Todos os presets carregados!"
            ;;
        0) return ;;
        *) echo -e "  ${RED}[!]${NC} Opcao invalida." ;;
    esac
}

# ============================================================
#   ALIASES MENU
# ============================================================

aliases_menu() {
    while true; do
        printf "\033c"
        echo ""
        echo -e "${CYAN}  ╔═══════════════════════════════════════════════╗${NC}"
        echo -e "${CYAN}  ║${NC}        ${WHITE}A L I A S   M A N A G E R${NC}               ${CYAN}║${NC}"
        echo -e "${CYAN}  ╚═══════════════════════════════════════════════╝${NC}"
        echo ""
        echo -e "  ${CYAN}[1]${NC}  ${WHITE}Visualizar aliases${NC}"
        echo -e "  ${CYAN}[2]${NC}  ${WHITE}Adicionar alias${NC}"
        echo -e "  ${CYAN}[3]${NC}  ${WHITE}Remover alias${NC}"
        echo -e "  ${CYAN}[4]${NC}  ${WHITE}Carregar presets${NC}"
        echo -e "  ${DARK}[0]${NC}  ${DARK}Voltar${NC}"
        echo ""
        echo -ne "  ${CYAN}❯${NC} ${WHITE}Selecione: ${NC}"

        read -r choice
        echo ""

        case "$choice" in
            1) view_aliases ;;
            2) add_alias ;;
            3) remove_alias ;;
            4) load_presets ;;
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

aliases_menu
