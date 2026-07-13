#!/bin/bash

# ============================================================
#   NEXUS TERMUX CUSTOMIZER 2026 - Setup Module
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
#   INSTALL ESSENTIAL PACKAGES
# ============================================================

install_essential_packages() {
    echo -e "\n${CYAN}  ╔══════════════════════════════════════╗${NC}"
    echo -e "${CYAN}  ║${NC}  ${WHITE}Installing Essential Packages${NC}         ${CYAN}║${NC}"
    echo -e "${CYAN}  ╚══════════════════════════════════════╝${NC}\n"

    local packages=(
        "git" "curl" "wget" "zip" "unzip"
        "neofetch" "tree" "htop" "figlet"
        "nano" "vim" "tar" "gzip"
    )

    for pkg in "${packages[@]}"; do
        if command -v "$pkg" &> /dev/null; then
            echo -e "  ${GREEN}[OK]${NC} $pkg"
        else
            echo -ne "  ${YELLOW}[*]${NC} Installing $pkg... "
            if [ -d "/data/data/com.termux" ]; then
                pkg install -y "$pkg" > /dev/null 2>&1
            elif command -v apt &> /dev/null; then
                sudo apt install -y "$pkg" > /dev/null 2>&1
            elif command -v pacman &> /dev/null; then
                sudo pacman -S --noconfirm "$pkg" > /dev/null 2>&1
            fi
            echo -e "${GREEN}done${NC}"
        fi
    done
}

# ============================================================
#   CONFIGURE SHELL
# ============================================================

configure_shell() {
    echo -e "\n${CYAN}  ╔══════════════════════════════════════╗${NC}"
    echo -e "${CYAN}  ║${NC}  ${WHITE}Configuring Shell Environment${NC}        ${CYAN}║${NC}"
    echo -e "${CYAN}  ╚══════════════════════════════════════╝${NC}\n"

    local shell_rc=""
    [ -f "$HOME/.bashrc" ] && shell_rc="$HOME/.bashrc"
    [ -f "$HOME/.zshrc" ] && shell_rc="$HOME/.zshrc"

    if [ -z "$shell_rc" ]; then
        shell_rc="$HOME/.bashrc"
        touch "$shell_rc"
    fi

    echo -e "  ${DARK}Configuring: ${WHITE}$shell_rc${NC}"

    # Remove old nexus configs
    sed -i '/# Nexus Termux Customizer/,/# Nexus End/d' "$shell_rc" 2>/dev/null || true

    # Build new config
    cat >> "$shell_rc" << 'SHELL_CONFIG'

# ============================================
# Nexus Termux Customizer 2026
# ============================================

# History configuration
HISTSIZE=10000
SAVEHIST=10000
HISTCONTROL=ignoreboth

# Append to history, don't overwrite
shopt -s histappend

# Check window size after each command
shopt -s checkwinsize

# Enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# Colorful man pages
export LESS_TERMCAP_mb=$'\e[1;36m'
export LESS_TERMCAP_md=$'\e[1;36m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;32m'

# ============================================
SHELL_CONFIG

    echo -e "  ${GREEN}[OK]${NC} Shell configurado"
}

# ============================================================
#   SETUP ALIASES
# ============================================================

setup_aliases() {
    echo -e "\n${CYAN}  ╔══════════════════════════════════════╗${NC}"
    echo -e "${CYAN}  ║${NC}  ${WHITE}Setting Up Custom Aliases${NC}             ${CYAN}║${NC}"
    echo -e "${CYAN}  ╚══════════════════════════════════════╝${NC}\n"

    local shell_rc=""
    [ -f "$HOME/.bashrc" ] && shell_rc="$HOME/.bashrc"
    [ -f "$HOME/.zshrc" ] && shell_rc="$HOME/.zshrc"

    if [ -n "$shell_rc" ]; then
        sed -i '/# Nexus Aliases/,/# Nexus Aliases End/d' "$shell_rc" 2>/dev/null || true

        cat >> "$shell_rc" << 'ALIASES_CONFIG'

# Nexus Aliases
alias ll='ls -la --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias cls='clear'
alias home='cd ~'
alias docs='cd ~/Documents'
alias downloads='cd ~/Downloads'
alias update='pkg update && pkg upgrade -y'
alias install='pkg install'
alias search='pkg search'
alias remove='pkg uninstall'
alias ports='netstat -tuln'
alias myip='curl -s ifconfig.me'
alias localip='hostname -I'
alias mem='free -h'
alias disk='df -h'
alias process='ps aux'
alias killall='killall -9'
alias reload='source ~/.bashrc'
alias nexus='bash ~/.nexus-termux/main.sh'
# Nexus Aliases End
ALIASES_CONFIG

        echo -e "  ${GREEN}[OK]${NC} Aliases configurados"
        echo -e "  ${DARK}Comandos disponiveis:${NC}"
        echo -e "  ${DARK}  ll, la, l, .., ..., cls, home${NC}"
        echo -e "  ${DARK}  update, install, search, myip${NC}"
        echo -e "  ${DARK}  mem, disk, process, nexus${NC}"
    fi
}

# ============================================================
#   CUSTOMIZE USERNAME
# ============================================================

customize_username() {
    echo -e "\n${CYAN}  ╔══════════════════════════════════════╗${NC}"
    echo -e "${CYAN}  ║${NC}  ${WHITE}Personalizar Identidade${NC}               ${CYAN}║${NC}"
    echo -e "${CYAN}  ╚══════════════════════════════════════╝${NC}\n"

    echo -e "  ${DARK}Nome atual: ${WHITE}${NEXUS_USERNAME:-Nao definido}${NC}"
    echo -e "  ${DARK}Apelido atual: ${WHITE}${NEXUS_NICKNAME:-Nao definido}${NC}"
    echo ""

    echo -ne "  ${CYAN}❯${NC} ${WHITE}Novo nome (ENTER para manter): ${NC}"
    read -r new_name

    echo -ne "  ${CYAN}❯${NC} ${WHITE}Novo apelido (ENTER para manter): ${NC}"
    read -r new_nickname

    if [ -n "$new_name" ]; then
        NEXUS_USERNAME="$new_name"
    fi
    if [ -n "$new_nickname" ]; then
        NEXUS_NICKNAME="$new_nickname"
    fi

    # Save
    if [ -f "$CONFIG_DIR/settings.conf" ]; then
        sed -i "s/^NEXUS_USERNAME=.*/NEXUS_USERNAME=\"$NEXUS_USERNAME\"/" "$CONFIG_DIR/settings.conf"
        sed -i "s/^NEXUS_NICKNAME=.*/NEXUS_NICKNAME=\"$NEXUS_NICKNAME\"/" "$CONFIG_DIR/settings.conf"
    fi

    echo -e "\n  ${GREEN}[OK]${NC} Identidade atualizada!"
}

# ============================================================
#   CUSTOMIZE PS1
# ============================================================

customize_ps1() {
    echo -e "\n${CYAN}  ╔══════════════════════════════════════╗${NC}"
    echo -e "${CYAN}  ║${NC}  ${WHITE}Personalizar Prompt (PS1)${NC}             ${CYAN}║${NC}"
    echo -e "${CYAN}  ╚══════════════════════════════════════╝${NC}\n"

    local nickname="${NEXUS_NICKNAME:-user}"

    echo -e "  ${DARK}Escolha o estilo do prompt:${NC}"
    echo ""
    echo -e "  ${CYAN}[1]${NC}  ${WHITE}❯ ${nickname}@nexus ~ \$${NC}"
    echo -e "  ${PURPLE}[2]${NC}  ${WHITE}╭─ ${nickname}@nexus ╰─ \$${NC}"
    echo -e "  ${GREEN}[3]${NC}  ${WHITE}[${nickname}@nexus] ~/path >${NC}"
    echo -e "  ${BLUE}[4]${NC}  ${WHITE}★ ${nickname}@nexus ★ ${NC}"
    echo -e "  ${DARK}[5]${NC}  ${WHITE}Custom (digite seu proprio)${NC}"
    echo ""
    echo -ne "  ${CYAN}❯${NC} ${WHITE}Selecione: ${NC}"

    read -r choice

    local ps1_value=""

    case "$choice" in
        1) ps1_value='PS1="\[\033[0;36m\]\u@\h \[\033[1;37m\]\w \[\033[0;36m\]❯ \[\033[0m\]"' ;;
        2) ps1_value='PS1="\[\033[0;35m\]╭─ \[\033[1;37m\]\u@\h \[\033[0;35m\]╰─ \[\033[0;36m\]\$\[\033[0m\] "' ;;
        3) ps1_value='PS1="\[\033[0;32m\][\[\033[1;37m\]\u@\h\[\033[0;32m\]] \[\033[0;34m\]\w \[\033[0;32m\]>\[\033[0m\] "' ;;
        4) ps1_value='PS1="\[\033[1;33m\]★ \[\033[0;36m\]\u@\h \[\033[1;33m\]★ \[\033[1;37m\]\w \[\033[0;36m\]\$\[\033[0m\] "' ;;
        5)
            echo -ne "  ${CYAN}❯${NC} ${WHITE}Digite seu PS1: ${NC}"
            read -r custom_ps1
            ps1_value="PS1=\"$custom_ps1\""
            ;;
        *) echo -e "  ${RED}[!]${NC} Opcao invalida."; return ;;
    esac

    local shell_rc=""
    [ -f "$HOME/.bashrc" ] && shell_rc="$HOME/.bashrc"
    [ -f "$HOME/.zshrc" ] && shell_rc="$HOME/.zshrc"

    if [ -n "$shell_rc" ] && [ -n "$ps1_value" ]; then
        sed -i '/# Nexus PS1/,/# Nexus PS1 End/d' "$shell_rc" 2>/dev/null || true
        echo "" >> "$shell_rc"
        echo "# Nexus PS1" >> "$shell_rc"
        echo "$ps1_value" >> "$shell_rc"
        echo "# Nexus PS1 End" >> "$shell_rc"

        echo -e "\n  ${GREEN}[OK]${NC} Prompt atualizado!"
        echo -e "  ${DARK}Reinicie o terminal para ver as mudancas.${NC}"
    fi
}

# ============================================================
#   SETUP MENU
# ============================================================

setup_menu() {
    while true; do
        printf "\033c"
        echo ""
        echo -e "${CYAN}  ╔═══════════════════════════════════════════════╗${NC}"
        echo -e "${CYAN}  ║${NC}       ${WHITE}T E R M I N A L   S E T U P${NC}              ${CYAN}║${NC}"
        echo -e "${CYAN}  ╚═══════════════════════════════════════════════╝${NC}"
        echo ""
        echo -e "  ${CYAN}[1]${NC}  ${WHITE}Instalar pacotes essenciais${NC}"
        echo -e "  ${CYAN}[2]${NC}  ${WHITE}Configurar shell${NC}"
        echo -e "  ${CYAN}[3]${NC}  ${WHITE}Configurar aliases${NC}"
        echo -e "  ${CYAN}[4]${NC}  ${WHITE}Personalizar identidade${NC}"
        echo -e "  ${CYAN}[5]${NC}  ${WHITE}Personalizar prompt (PS1)${NC}"
        echo -e "  ${CYAN}[6]${NC}  ${WHITE}Configuracao completa (tudo)${NC}"
        echo -e "  ${DARK}[0]${NC}  ${DARK}Voltar${NC}"
        echo ""
        echo -ne "  ${CYAN}❯${NC} ${WHITE}Selecione: ${NC}"

        read -r choice
        echo ""

        case "$choice" in
            1) install_essential_packages ;;
            2) configure_shell ;;
            3) setup_aliases ;;
            4) customize_username ;;
            5) customize_ps1 ;;
            6)
                install_essential_packages
                configure_shell
                setup_aliases
                customize_username
                customize_ps1
                echo -e "\n  ${GREEN}[OK]${NC} Configuracao completa finalizada!"
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

setup_menu
