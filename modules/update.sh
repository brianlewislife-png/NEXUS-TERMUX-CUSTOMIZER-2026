#!/bin/bash

# ============================================================
#   NEXUS TERMUX CUSTOMIZER 2026 - Update Module
#   Developer: Brian Lewis
#   Instagram: @Brian_lewis_2
# ============================================================

NEXUS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_DIR="$NEXUS_DIR/config"
REPO_URL="https://github.com/brianlewislife-png/NEXUS-TERMUX-CUSTOMIZER-2026.git"

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
#   CHECK FOR UPDATES
# ============================================================

check_updates() {
    echo -e "\n${CYAN}  ╔══════════════════════════════════════╗${NC}"
    echo -e "${CYAN}  ║${NC}  ${WHITE}Checking for Updates${NC}                  ${CYAN}║${NC}"
    echo -e "${CYAN}  ╚══════════════════════════════════════╝${NC}\n"

    echo -e "  ${DARK}Versao atual: ${WHITE}${NEXUS_VERSION:-2.0.0}${NC}"
    echo ""

    # Check git
    if command -v git &> /dev/null; then
        echo -e "  ${YELLOW}[*]${NC} Verificando repositorio..."
        local remote_version=$(git ls-remote --tags "$REPO_URL" 2>/dev/null | grep -oP 'v\K[0-9.]+$' | tail -1)

        if [ -n "$remote_version" ]; then
            echo -e "  ${DARK}Versao remota: ${WHITE}${remote_version}${NC}"

            if [ "$remote_version" != "$NEXUS_VERSION" ]; then
                echo -e "\n  ${GREEN}[!]${NC} Nova versao disponivel: ${GREEN}${remote_version}${NC}"
                return 0
            else
                echo -e "\n  ${GREEN}[OK]${NC} Voce ja esta na versao mais recente!"
                return 1
            fi
        fi
    fi

    echo -e "  ${YELLOW}[!]${NC} Nao foi possivel verificar atualizacoes."
    return 1
}

# ============================================================
#   UPDATE TOOL
# ============================================================

update_tool() {
    echo -e "\n${CYAN}  ╔══════════════════════════════════════╗${NC}"
    echo -e "${CYAN}  ║${NC}  ${WHITE}Updating Nexus Termux Customizer${NC}      ${CYAN}║${NC}"
    echo -e "${CYAN}  ╚══════════════════════════════════════╝${NC}\n"

    if ! command -v git &> /dev/null; then
        echo -e "  ${RED}[!]${NC} Git nao encontrado. Instale git primeiro."
        return
    fi

    # Backup before update
    echo -e "  ${YELLOW}[*]${NC} Criando backup antes da atualizacao..."

    local timestamp=$(date +"%Y%m%d_%H%M%S")
    local backup_path="$HOME/.nexus-termux/backups/pre_update_${timestamp}"

    mkdir -p "$backup_path"
    cp -r "$CONFIG_DIR" "$backup_path/" 2>/dev/null
    cp "$NEXUS_DIR/main.sh" "$backup_path/" 2>/dev/null
    cp -r "$NEXUS_DIR/modules" "$backup_path/" 2>/dev/null

    echo -e "  ${GREEN}[OK]${NC} Backup criado"

    # Pull latest changes
    echo -e "\n  ${YELLOW}[*]${NC} Baixando atualizacoes..."
    cd "$NEXUS_DIR"

    if git pull origin main 2>/dev/null || git pull origin master 2>/dev/null; then
        echo -e "  ${GREEN}[OK]${NC} Codigo atualizado"

        # Make scripts executable
        chmod +x "$NEXUS_DIR/main.sh"
        chmod +x "$NEXUS_DIR/modules/"*.sh

        # Update version
        if [ -f "$CONFIG_DIR/settings.conf" ]; then
            sed -i "s/^NEXUS_VERSION=.*/NEXUS_VERSION=\"2.0.0\"/" "$CONFIG_DIR/settings.conf"
        fi

        echo -e "\n  ${GREEN}[OK]${NC} Atualizacao concluida!"
        echo -e "  ${DARK}Reinicie o nexus para usar a versao atualizada.${NC}"
    else
        echo -e "\n  ${RED}[!]${NC} Erro ao atualizar. Restaurando backup..."

        cp -r "$backup_path/"* "$NEXUS_DIR/" 2>/dev/null
        echo -e "  ${YELLOW}[!]${NC} Backup restaurado."
    fi
}

# ============================================================
#   UPDATE MENU
# ============================================================

update_menu() {
    while true; do
        printf "\033c"
        echo ""
        echo -e "${CYAN}  ╔═══════════════════════════════════════════════╗${NC}"
        echo -e "${CYAN}  ║${NC}       ${WHITE}U P D A T E   M A N A G E R${NC}              ${CYAN}║${NC}"
        echo -e "${CYAN}  ╚═══════════════════════════════════════════════╝${NC}"
        echo ""
        echo -e "  ${CYAN}[1]${NC}  ${WHITE}Verificar atualizacoes${NC}"
        echo -e "  ${CYAN}[2]${NC}  ${WHITE}Atualizar ferramenta${NC}"
        echo -e "  ${DARK}[0]${NC}  ${DARK}Voltar${NC}"
        echo ""
        echo -ne "  ${CYAN}❯${NC} ${WHITE}Selecione: ${NC}"

        read -r choice
        echo ""

        case "$choice" in
            1) check_updates ;;
            2)
                if check_updates; then
                    echo ""
                    echo -ne "  ${GREEN}[?]${NC} ${WHITE}Deseja atualizar agora? (s/n): ${NC}"
                    read -r confirm
                    if [[ "$confirm" =~ ^[Ss]$ ]]; then
                        update_tool
                    fi
                fi
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

update_menu
