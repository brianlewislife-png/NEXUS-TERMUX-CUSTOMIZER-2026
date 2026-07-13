#!/bin/bash

# ============================================================
#   NEXUS TERMUX CUSTOMIZER 2026 - Installation Script
#   Developer: Brian Lewis
#   Instagram: @Brian_lewis_2
# ============================================================

set -e

INSTALL_DIR="$HOME/.nexus-termux"
REPO_URL="https://github.com/ivisconfessor/nexus-termux-customizer"

# Colors
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
WHITE='\033[1;37m'
DARK='\033[2;37m'
NC='\033[0m'

clear_screen() {
    printf "\033c"
}

print_header() {
    echo -e "${CYAN}"
    echo "========================================"
    echo "     NEXUS TERMUX CUSTOMIZER 2026"
    echo "========================================"
    echo -e "${NC}"
    echo -e "${DARK}Desenvolvido por:${NC}"
    echo -e "${WHITE}Brian Lewis${NC}"
    echo ""
    echo -e "${DARK}Instagram:${NC}"
    echo -e "${PURPLE}@Brian_lewis_2${NC}"
    echo ""
    echo -e "${CYAN}========================================${NC}"
}

check_termux() {
    if [ -d "/data/data/com.termux" ]; then
        return 0
    fi
    return 1
}

check_dependencies() {
    echo -e "\n${YELLOW}[*] Verificando dependencias...${NC}\n"

    local deps=("git" "curl" "wget" "bash")
    local missing=()

    for dep in "${deps[@]}"; do
        if command -v "$dep" &> /dev/null; then
            echo -e "  ${GREEN}[OK]${NC} $dep"
        else
            echo -e "  ${RED}[FAIL]${NC} $dep"
            missing+=("$dep")
        fi
    done

    if [ ${#missing[@]} -gt 0 ]; then
        echo -e "\n${YELLOW}[*] Instalando dependencias faltantes...${NC}\n"

        if check_termux; then
            pkg update -y > /dev/null 2>&1
            for dep in "${missing[@]}"; do
                pkg install -y "$dep" > /dev/null 2>&1
                echo -e "  ${GREEN}[OK]${NC} $dep instalado"
            done
        else
            if command -v apt &> /dev/null; then
                sudo apt update -y > /dev/null 2>&1
                for dep in "${missing[@]}"; do
                    sudo apt install -y "$dep" > /dev/null 2>&1
                    echo -e "  ${GREEN}[OK]${NC} $dep instalado"
                done
            elif command -v pacman &> /dev/null; then
                sudo pacman -Sy --noconfirm > /dev/null 2>&1
                for dep in "${missing[@]}"; do
                    sudo pacman -S --noconfirm "$dep" > /dev/null 2>&1
                    echo -e "  ${GREEN}[OK]${NC} $dep instalado"
                done
            fi
        fi
    else
        echo -e "\n${GREEN}[OK] Todas as dependencias estao instaladas.${NC}"
    fi
}

install_packages() {
    echo -e "\n${YELLOW}[*] Instalando pacotes essenciais...${NC}\n"

    local packages=("neofetch" "tree" "htop" "figlet" "lolcat" "fortune" " cowsay")

    if check_termux; then
        pkg update -y > /dev/null 2>&1
        for pkg in "${packages[@]}"; do
            pkg install -y "$pkg" > /dev/null 2>&1 && \
                echo -e "  ${GREEN}[OK]${NC} $pkg" || \
                echo -e "  ${DARK}[SKIP]${NC} $pkg (opcional)"
        done
    else
        for pkg in "${packages[@]}"; do
            if command -v apt &> /dev/null; then
                sudo apt install -y "$pkg" > /dev/null 2>&1 && \
                    echo -e "  ${GREEN}[OK]${NC} $pkg" || \
                    echo -e "  ${DARK}[SKIP]${NC} $pkg (opcional)"
            elif command -v pacman &> /dev/null; then
                sudo pacman -S --noconfirm "$pkg" > /dev/null 2>&1 && \
                    echo -e "  ${GREEN}[OK]${NC} $pkg" || \
                    echo -e "  ${DARK}[SKIP]${NC} $pkg (opcional)"
            fi
        done
    fi
}

clone_project() {
    echo -e "\n${YELLOW}[*] Baixando Nexus Termux Customizer...${NC}\n"

    if [ -d "$INSTALL_DIR" ]; then
        echo -e "  ${DARK}[INFO]${NC} Diretorio ja existe. Atualizando..."
        cd "$INSTALL_DIR" && git pull > /dev/null 2>&1
    else
        git clone "$REPO_URL" "$INSTALL_DIR" > /dev/null 2>&1
    fi

    chmod +x "$INSTALL_DIR/main.sh"
    chmod +x "$INSTALL_DIR/modules/"*.sh

    echo -e "  ${GREEN}[OK]${NC} Projeto instalado em: $INSTALL_DIR"
}

create_command() {
    echo -e "\n${YELLOW}[*] Criando comando 'nexus'...${NC}\n"

    local shell_rc=""

    if [ -f "$HOME/.bashrc" ]; then
        shell_rc="$HOME/.bashrc"
    elif [ -f "$HOME/.zshrc" ]; then
        shell_rc="$HOME/.zshrc"
    fi

    if [ -n "$shell_rc" ]; then
        if grep -q "nexus" "$shell_rc" 2>/dev/null; then
            echo -e "  ${DARK}[INFO]${NC} Comando 'nexus' ja configurado."
        else
            echo "" >> "$shell_rc"
            echo "# Nexus Termux Customizer 2026" >> "$shell_rc"
            echo "alias nexus='bash $INSTALL_DIR/main.sh'" >> "$shell_rc"
            echo -e "  ${GREEN}[OK]${NC} Comando 'nexus' adicionado ao $shell_rc"
        fi
    fi

    if check_termux; then
        ln -sf "$INSTALL_DIR/main.sh" "$PREFIX/bin/nexus" 2>/dev/null || true
    fi

    echo -e "  ${GREEN}[OK]${NC} Agora voce pode executar: ${CYAN}nexus${NC}"
}

create_config() {
    echo -e "\n${YELLOW}[*] Criando configuracoes iniciais...${NC}\n"

    mkdir -p "$INSTALL_DIR/config"
    mkdir -p "$INSTALL_DIR/backups"
    mkdir -p "$INSTALL_DIR/banners"

    if [ ! -f "$INSTALL_DIR/config/settings.conf" ]; then
        cat > "$INSTALL_DIR/config/settings.conf" << 'CONF'
# Nexus Termux Customizer 2026 - Settings
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
CONF
        echo -e "  ${GREEN}[OK]${NC} Arquivo de configuracao criado."
    fi

    if [ ! -f "$INSTALL_DIR/config/aliases.conf" ]; then
        cat > "$INSTALL_DIR/config/aliases.conf" << 'ALIASES'
# Nexus Termux Customizer 2026 - Custom Aliases
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias update='pkg update && pkg upgrade'
alias cls='clear'
alias home='cd ~'
ALIASES
        echo -e "  ${GREEN}[OK]${NC} Aliases padrao criados."
    fi
}

print_complete() {
    echo ""
    echo -e "${CYAN}========================================${NC}"
    echo -e "${GREEN}  INSTALACAO COMPLETA!${NC}"
    echo -e "${CYAN}========================================${NC}"
    echo ""
    echo -e "${WHITE}Para iniciar, execute:${NC}"
    echo ""
    echo -e "  ${CYAN}nexus${NC}"
    echo ""
    echo -e "${DARK}Ou execute diretamente:${NC}"
    echo -e "  ${DARK}bash $INSTALL_DIR/main.sh${NC}"
    echo ""
    echo -e "${PURPLE}Desenvolvido por Brian Lewis${NC}"
    echo -e "${DARK}@Brian_lewis_2${NC}"
    echo -e "${CYAN}========================================${NC}"
    echo ""
}

main() {
    clear_screen
    print_header
    echo ""
    check_dependencies
    install_packages
    clone_project
    create_command
    create_config
    print_complete
}

main "$@"
