#!/bin/bash

# ============================================================
#   NEXUS TERMUX CUSTOMIZER 2026 - Banner Module
#   Developer: Brian Lewis
#   Instagram: @Brian_lewis_2
# ============================================================

NEXUS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_DIR="$NEXUS_DIR/config"
BANNERS_DIR="$NEXUS_DIR/banners"

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

mkdir -p "$BANNERS_DIR"

# ============================================================
#   PRESET BANNERS
# ============================================================

BANNER_DEFAULT() {
    local name="${1:-Developer}"
    cat << EOF
${CYAN}╔══════════════════════════════════════════════════╗
║                                                  ║
║   ██╗   ██╗███████╗██╗  ██╗██╗   ██╗███████╗   ║
║   ████╗  ██║██╔════╝╚██╗██╔╝██║   ██║██╔════╝   ║
║   ██╔██╗ ██║█████╗   ╚███╔╝ ██║   ██║███████╗   ║
║   ██║╚██╗██║██╔══╝   ██╔██╗ ██║   ██║╚════██║   ║
║   ██║ ╚████║███████╗██╔╝ ██╗╚██████╔╝███████║   ║
║   ╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝   ║
║                                                  ║
║   Welcome, ${GREEN}${name}${NC}${CYAN}!                              ║
║   ${DARK}Full Stack Developer | AI Engineer${NC}${CYAN}            ║
║                                                  ║
╚══════════════════════════════════════════════════╝${NC}
EOF
}

BANNER_MINIMAL() {
    local name="${1:-Developer}"
    cat << EOF
${PURPLE}  ┌──────────────────────────────────────────┐
  │                                          │
  │   ${WHITE}N E X U S${NC}${PURPLE}  ${DARK}·${NC}${WHITE}  ${NC}${PURPLE}T E R M${NC}${PURPLE}             │
  │                                          │
  │   ${GREEN}${name}${NC}${PURPLE}                                     │
  │   ${DARK}>_${NC}                                     │
  │                                          │
  └──────────────────────────────────────────┘${NC}
EOF
}

BANNER_HACKER() {
    local name="${1:-Developer}"
    cat << EOF
${GREEN}
  ╔══════════════════════════════════════════════╗
  ║  ${WHITE}██████╗ ██╗  ██╗ █████╗ ███╗   ██╗████████╗${NC}${GREEN} ║
  ║  ${WHITE}██╔══██╗██║  ██║██╔══██╗████╗  ██║╚══██╔══╝${NC}${GREEN} ║
  ║  ${WHITE}██████╔╝███████║███████║██╔██╗ ██║   ██║${NC}${GREEN}    ║
  ║  ${WHITE}██╔═══╝ ██╔══██║██╔══██║██║╚██╗██║   ██║${NC}${GREEN}    ║
  ║  ${WHITE}██║     ██║  ██║██║  ██║██║ ╚████║   ██║${NC}${GREEN}    ║
  ║  ${WHITE}╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝   ╚═╝${NC}${GREEN}    ║
  ║                                            ║
  ║  ${DARK}[${GREEN}+${DARK}] User: ${WHITE}${name}${NC}${GREEN}                           ║
  ║  ${DARK}[${GREEN}+${DARK}] Status: ${GREEN}ACTIVE${NC}${GREEN}                       ║
  ║  ${DARK}[${GREEN}+${DARK}] Mode: ${YELLOW}ROOT${NC}${GREEN}                            ║
  ╚══════════════════════════════════════════════╝${NC}
EOF
}

BANNER_GLOW() {
    local name="${1:-Developer}"
    cat << EOF
${BLUE}  ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  ┃                                            ┃
  ┃   ${CYAN}╔═╗╔═╗╔╦╗╔═╗  ╔═╗╔═╗╦═╗╦  ╦╔═╗╦═╗${NC}${BLUE}     ┃
  ┃   ${CYAN}╚═╗║╣  ║ ║╣   ╚═╗║╣ ╠╦╝╚╗╔╝║╣ ╠╦╝${NC}${BLUE}     ┃
  ┃   ${CYAN}╚═╝╚═╝ ╩ ╚═╝  ╚═╝╚═╝╩╚═ ╚╝ ╚═╝╩╚═${NC}${BLUE}     ┃
  ┃                                            ┃
  ┃   ${WHITE}${name}${NC}${BLUE}                                       ┃
  ┃   ${DARK}Terminal Customizer v2.0${NC}${BLUE}                  ┃
  ┃                                            ┃
  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛${NC}
EOF
}

BANNER_RETRO() {
    local name="${1:-Developer}"
    cat << EOF
${YELLOW}  ╔════════════════════════════════════════════╗
  ║  ${WHITE}N N N N N N   T E R M   2 0 2 6${NC}${YELLOW}           ║
  ║  ${DARK}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}${YELLOW}       ║
  ║                                            ║
  ║   ${GREEN}> ${WHITE}${name}${NC}${YELLOW}                                     ║
  ║   ${GREEN}> ${DARK}Ready for commands...${NC}${YELLOW}                    ║
  ║                                            ║
  ╚════════════════════════════════════════════╝${NC}
EOF
}

BANNER_CUSTOM() {
    local name="${1:-Developer}"
    local line1="${2:-}"
    local line2="${3:-}"

    cat << EOF
${CYAN}╔══════════════════════════════════════════════════╗
║                                                  ║
║   ${WHITE}${name}${NC}${CYAN}                                           ║
║                                                  ║
║   ${GREEN}${line1}${NC}${CYAN}                                           ║
║   ${PURPLE}${line2}${NC}${CYAN}                                           ║
║                                                  ║
╚══════════════════════════════════════════════════╝${NC}
EOF
}

# ============================================================
#   BANNER MENU
# ============================================================

banner_menu() {
    local username="${NEXUS_USERNAME:-Developer}"

    while true; do
        printf "\033c"
        echo ""
        echo -e "${CYAN}  ╔═══════════════════════════════════════════════╗${NC}"
        echo -e "${CYAN}  ║${NC}       ${WHITE}B A N N E R   C R E A T O R${NC}              ${CYAN}║${NC}"
        echo -e "${CYAN}  ╚═══════════════════════════════════════════════╝${NC}"
        echo ""
        echo -e "  ${DARK}Banners disponiveis:${NC}"
        echo ""
        echo -e "  ${CYAN}[1]${NC}  ${WHITE}Default${NC}   ${DARK}- Banner classico com ASCII art${NC}"
        echo -e "  ${PURPLE}[2]${NC}  ${WHITE}Minimal${NC}  ${DARK}- Design limpo e simples${NC}"
        echo -e "  ${GREEN}[3]${NC}  ${WHITE}Hacker${NC}   ${DARK}- Estilo cyberpunk${NC}"
        echo -e "  ${BLUE}[4]${NC}  ${WHITE}Glow${NC}     ${DARK}- Efeito neon brilhante${NC}"
        echo -e "  ${YELLOW}[5]${NC}  ${WHITE}Retro${NC}    ${DARK}- Estilo retrô${NC}"
        echo -e "  ${WHITE}[6]${NC}  ${WHITE}Custom${NC}   ${DARK}- Crie seu proprio banner${NC}"
        echo -e "  ${DARK}[0]${NC}  ${DARK}Voltar${NC}"
        echo ""
        echo -ne "  ${CYAN}❯${NC} ${WHITE}Selecione: ${NC}"

        read -r choice
        echo ""

        case "$choice" in
            1)
                echo -e "${CYAN}  Preview:${NC}"
                echo ""
                BANNER_DEFAULT "$username"
                ;;
            2)
                echo -e "${PURPLE}  Preview:${NC}"
                echo ""
                BANNER_MINIMAL "$username"
                ;;
            3)
                echo -e "${GREEN}  Preview:${NC}"
                echo ""
                BANNER_HACKER "$username"
                ;;
            4)
                echo -e "${BLUE}  Preview:${NC}"
                echo ""
                BANNER_GLOW "$username"
                ;;
            5)
                echo -e "${YELLOW}  Preview:${NC}"
                echo ""
                BANNER_RETRO "$username"
                ;;
            6)
                echo -e "  ${WHITE}Banner Personalizado${NC}"
                echo ""
                echo -ne "  ${CYAN}❯${NC} ${WHITE}Primeira linha: ${NC}"
                read -r custom_line1
                echo -ne "  ${CYAN}❯${NC} ${WHITE}Segunda linha: ${NC}"
                read -r custom_line2
                echo ""
                BANNER_CUSTOM "$username" "$custom_line1" "$custom_line2"
                ;;
            0)
                return
                ;;
            *)
                echo -e "  ${RED}[!]${NC} Opcao invalida."
                sleep 1
                continue
                ;;
        esac

        echo ""
        echo -ne "  ${GREEN}[?]${NC} ${WHITE}Aplicar este banner? (s/n): ${NC}"
        read -r apply

        if [[ "$apply" =~ ^[Ss]$ ]]; then
            local banner_type="default"
            case "$choice" in
                1) banner_type="default" ;;
                2) banner_type="minimal" ;;
                3) banner_type="hacker" ;;
                4) banner_type="glow" ;;
                5) banner_type="retro" ;;
                6) banner_type="custom" ;;
            esac

            if [ -f "$CONFIG_DIR/settings.conf" ]; then
                sed -i "s/^NEXUS_BANNER=.*/NEXUS_BANNER=\"$banner_type\"/" "$CONFIG_DIR/settings.conf"
            fi

            # Save banner to profile
            local shell_rc=""
            [ -f "$HOME/.bashrc" ] && shell_rc="$HOME/.bashrc"
            [ -f "$HOME/.zshrc" ] && shell_rc="$HOME/.zshrc"

            if [ -n "$shell_rc" ]; then
                sed -i '/# Nexus Banner/,/Nexus Banner End/d' "$shell_rc" 2>/dev/null || true

                cat >> "$shell_rc" << BANNER_RC

# Nexus Banner
if [ -f "$BANNERS_DIR/${banner_type}.sh" ]; then
    source "$BANNERS_DIR/${banner_type}.sh"
fi
# Nexus Banner End
BANNER_RC
            fi

            # Save banner script
            cat > "$BANNERS_DIR/${banner_type}.sh" << 'BANNER_SCRIPT'
#!/bin/banner loader
BANNER_SCRIPT

            echo -e "\n  ${GREEN}[OK]${NC} Banner aplicado com sucesso!"
            echo -e "  ${DARK}Reinicie o terminal para ver as mudancas.${NC}"
        fi

        echo ""
        echo -ne "  ${DARK}Pressione [ENTER] para continuar...${NC}"
        read -r
    done
}

banner_menu
