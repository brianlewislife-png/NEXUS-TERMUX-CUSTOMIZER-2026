#!/bin/bash

# ============================================================
#   NEXUS TERMUX CUSTOMIZER 2026 - Restore Module
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

# ============================================================
#   RESTORE FROM BACKUP
# ============================================================

restore_backup() {
    echo -e "\n${CYAN}  ╔══════════════════════════════════════╗${NC}"
    echo -e "${CYAN}  ║${NC}  ${WHITE}Restore from Backup${NC}                   ${CYAN}║${NC}"
    echo -e "${CYAN}  ╚══════════════════════════════════════╝${NC}\n"

    local backups=($(ls "$BACKUP_DIR"/*.tar.gz 2>/dev/null))

    if [ ${#backups[@]} -eq 0 ]; then
        echo -e "  ${DARK}Nenhum backup encontrado.${NC}"
        return
    fi

    echo -e "  ${DARK}Backups disponiveis:${NC}\n"

    local i=1
    for backup in "${backups[@]}"; do
        local name=$(basename "$backup" .tar.gz)
        local size=$(du -h "$backup" 2>/dev/null | cut -f1)
        echo -e "  ${CYAN}[$i]${NC}  ${WHITE}${name}${NC}  ${DARK}(${size})${NC}"
        ((i++))
    done

    echo ""
    echo -ne "  ${CYAN}❯${NC} ${WHITE}Numero do backup (0 para cancelar): ${NC}"
    read -r num

    if [ "$num" = "0" ] || [ -z "$num" ]; then
        return
    fi

    if [ "$num" -ge 1 ] && [ "$num" -le ${#backups[@]} ]; then
        local backup="${backups[$((num-1))]}"
        local restore_dir=$(mktemp -d)

        echo -e "\n  ${YELLOW}[*]${NC} Restaurando backup..."
        tar -xzf "$backup" -C "$restore_dir" 2>/dev/null

        local backup_folder=$(ls "$restore_dir")
        local backup_path="${restore_dir}/${backup_folder}"

        # Restore settings
        if [ -f "$backup_path/settings.conf" ]; then
            cp "$backup_path/settings.conf" "$CONFIG_DIR/"
            echo -e "  ${GREEN}[OK]${NC} settings.conf restaurado"
        fi

        # Restore aliases
        if [ -f "$backup_path/aliases.conf" ]; then
            cp "$backup_path/aliases.conf" "$CONFIG_DIR/"
            echo -e "  ${GREEN}[OK]${NC} aliases.conf restaurado"
        fi

        # Restore shell configs
        local shell_files=(".bashrc" ".zshrc" ".bash_profile" ".profile")
        for file in "${shell_files[@]}"; do
            if [ -f "$backup_path/$file" ]; then
                cp "$backup_path/$file" "$HOME/"
                echo -e "  ${GREEN}[OK]${NC} $file restaurado"
            fi
        done

        rm -rf "$restore_dir"

        echo -e "\n  ${GREEN}[OK]${NC} Backup restaurado com sucesso!"
        echo -e "  ${DARK}Reinicie o terminal para aplicar as mudancas.${NC}"
    else
        echo -e "\n  ${RED}[!]${NC} Numero invalido."
    fi
}

# ============================================================
#   RESET TO DEFAULT
# ============================================================

reset_defaults() {
    echo -e "\n${CYAN}  ╔══════════════════════════════════════╗${NC}"
    echo -e "${CYAN}  ║${NC}  ${WHITE}Reset to Defaults${NC}                     ${CYAN}║${NC}"
    echo -e "${CYAN}  ╚══════════════════════════════════════╝${NC}\n"

    echo -e "  ${YELLOW}[!]${NC} Isso ira resetar todas as configuracoes."
    echo -ne "  ${GREEN}[?]${NC} ${WHITE}Tem certeza? (s/n): ${NC}"
    read -r confirm

    if [[ "$confirm" =~ ^[Ss]$ ]]; then
        cat > "$CONFIG_DIR/settings.conf" << 'CONF'
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

        cat > "$CONFIG_DIR/aliases.conf" << 'ALIASES'
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

        echo -e "\n  ${GREEN}[OK]${NC} Configuracoes resetadas para o padrao!"
        echo -e "  ${DARK}Voce precisara executar o setup novamente.${NC}"
    else
        echo -e "\n  ${DARK}Operacao cancelada.${NC}"
    fi
}

# ============================================================
#   RESTORE MENU
# ============================================================

restore_menu() {
    while true; do
        printf "\033c"
        echo ""
        echo -e "${CYAN}  ╔═══════════════════════════════════════════════╗${NC}"
        echo -e "${CYAN}  ║${NC}      ${WHITE}R E S T O R E   M A N A G E R${NC}             ${CYAN}║${NC}"
        echo -e "${CYAN}  ╚═══════════════════════════════════════════════╝${NC}"
        echo ""
        echo -e "  ${CYAN}[1]${NC}  ${WHITE}Restaurar de backup${NC}"
        echo -e "  ${CYAN}[2]${NC}  ${WHITE}Resetar para padrao${NC}"
        echo -e "  ${DARK}[0]${NC}  ${DARK}Voltar${NC}"
        echo ""
        echo -ne "  ${CYAN}❯${NC} ${WHITE}Selecione: ${NC}"

        read -r choice
        echo ""

        case "$choice" in
            1) restore_backup ;;
            2) reset_defaults ;;
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

restore_menu
