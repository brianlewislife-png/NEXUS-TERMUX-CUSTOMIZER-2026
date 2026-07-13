#!/bin/bash

# ============================================================
#   NEXUS TERMUX CUSTOMIZER 2026 - Backup Module
#   Developer: Brian Lewis
#   Instagram: @Brian_lewis_2
# ============================================================

NEXUS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_DIR="$NEXUS_DIR/config"
BACKUP_DIR="$NEXUS_DIR/backups"

CYAN='\033[0;36m'
PURPLE='\033[0;35m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
WHITE='\033[1;37m'
DARK='\033[2;37m'
NC='\033[0m'

source "$CONFIG_DIR/settings.conf" 2>/dev/null || true

mkdir -p "$BACKUP_DIR"

# ============================================================
#   CREATE BACKUP
# ============================================================

create_backup() {
    local timestamp=$(date +"%Y%m%d_%H%M%S")
    local backup_name="nexus_backup_${timestamp}"
    local backup_path="${BACKUP_DIR}/${backup_name}"

    echo -e "\n${CYAN}  ╔══════════════════════════════════════╗${NC}"
    echo -e "${CYAN}  ║${NC}  ${WHITE}Creating Backup${NC}                      ${CYAN}║${NC}"
    echo -e "${CYAN}  ╚══════════════════════════════════════╝${NC}\n"

    mkdir -p "$backup_path"

    # Backup settings
    if [ -f "$CONFIG_DIR/settings.conf" ]; then
        cp "$CONFIG_DIR/settings.conf" "$backup_path/"
        echo -e "  ${GREEN}[OK]${NC} settings.conf"
    fi

    # Backup aliases
    if [ -f "$CONFIG_DIR/aliases.conf" ]; then
        cp "$CONFIG_DIR/aliases.conf" "$backup_path/"
        echo -e "  ${GREEN}[OK]${NC} aliases.conf"
    fi

    # Backup shell config
    local shell_files=(".bashrc" ".zshrc" ".bash_profile" ".profile")
    for file in "${shell_files[@]}"; do
        if [ -f "$HOME/$file" ]; then
            cp "$HOME/$file" "$backup_path/"
            echo -e "  ${GREEN}[OK]${NC} $file"
        fi
    done

    # Backup custom banners
    if [ -d "$NEXUS_DIR/banners" ] && [ "$(ls -A "$NEXUS_DIR/banners" 2>/dev/null)" ]; then
        cp -r "$NEXUS_DIR/banners" "$backup_path/"
        echo -e "  ${GREEN}[OK]${NC} banners/"
    fi

    # Create archive
    cd "$BACKUP_DIR"
    tar -czf "${backup_name}.tar.gz" "$backup_name" 2>/dev/null
    rm -rf "$backup_name"

    echo -e "\n  ${GREEN}[OK]${NC} Backup criado com sucesso!"
    echo -e "  ${DARK}Arquivo: ${WHITE}${BACKUP_DIR}/${backup_name}.tar.gz${NC}"
    echo -e "  ${DARK}Tamanho: ${WHITE}$(du -h "${BACKUP_DIR}/${backup_name}.tar.gz" 2>/dev/null | cut -f1)${NC}"
}

# ============================================================
#   LIST BACKUPS
# ============================================================

list_backups() {
    echo -e "\n${CYAN}  ╔══════════════════════════════════════╗${NC}"
    echo -e "${CYAN}  ║${NC}  ${WHITE}Available Backups${NC}                     ${CYAN}║${NC}"
    echo -e "${CYAN}  ╚══════════════════════════════════════╝${NC}\n"

    local backups=($(ls "$BACKUP_DIR"/*.tar.gz 2>/dev/null))

    if [ ${#backups[@]} -eq 0 ]; then
        echo -e "  ${DARK}Nenhum backup encontrado.${NC}"
        return
    fi

    echo -e "  ${DARK}#  |  Arquivo                          |  Tamanho${NC}"
    echo -e "  ${DARK}---|-----------------------------------|----------${NC}"

    local i=1
    for backup in "${backups[@]}"; do
        local name=$(basename "$backup")
        local size=$(du -h "$backup" 2>/dev/null | cut -f1)
        echo -e "  ${CYAN}$i${NC}  |  ${WHITE}${name}${NC}  |  ${DARK}${size}${NC}"
        ((i++))
    done
}

# ============================================================
#   DELETE BACKUP
# ============================================================

delete_backup() {
    list_backups

    local backups=($(ls "$BACKUP_DIR"/*.tar.gz 2>/dev/null))

    if [ ${#backups[@]} -eq 0 ]; then
        return
    fi

    echo ""
    echo -ne "  ${CYAN}❯${NC} ${WHITE}Numero do backup para deletar (0 para cancelar): ${NC}"
    read -r num

    if [ "$num" = "0" ] || [ -z "$num" ]; then
        return
    fi

    if [ "$num" -ge 1 ] && [ "$num" -le ${#backups[@]} ]; then
        local backup="${backups[$((num-1))]}"
        rm -f "$backup"
        echo -e "\n  ${GREEN}[OK]${NC} Backup removido: $(basename "$backup")"
    else
        echo -e "\n  ${RED}[!]${NC} Numero invalido."
    fi
}

# ============================================================
#   BACKUP MENU
# ============================================================

backup_menu() {
    while true; do
        printf "\033c"
        echo ""
        echo -e "${CYAN}  ╔═══════════════════════════════════════════════╗${NC}"
        echo -e "${CYAN}  ║${NC}        ${WHITE}B A C K U P   M A N A G E R${NC}             ${CYAN}║${NC}"
        echo -e "${CYAN}  ╚═══════════════════════════════════════════════╝${NC}"
        echo ""
        echo -e "  ${CYAN}[1]${NC}  ${WHITE}Criar backup${NC}"
        echo -e "  ${CYAN}[2]${NC}  ${WHITE}Listar backups${NC}"
        echo -e "  ${CYAN}[3]${NC}  ${WHITE}Deletar backup${NC}"
        echo -e "  ${DARK}[0]${NC}  ${DARK}Voltar${NC}"
        echo ""
        echo -ne "  ${CYAN}❯${NC} ${WHITE}Selecione: ${NC}"

        read -r choice
        echo ""

        case "$choice" in
            1) create_backup ;;
            2) list_backups ;;
            3) delete_backup ;;
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

backup_menu
