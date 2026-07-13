#!/bin/bash

# ============================================================
#   NEXUS TERMUX CUSTOMIZER 2026 - PS1 Prompt Module
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
#   PS1 PRESETS
# ============================================================

PS1_CYBER() {
    local nick="${NEXUS_NICKNAME:-user}"
    echo -e "${CYAN}  ╔══════════════════════════════════════╗${NC}"
    echo -e "${CYAN}  ║${NC}  ${WHITE}C Y B E R   P R O M P T${NC}               ${CYAN}║${NC}"
    echo -e "${CYAN}  ║${NC}                                     ${CYAN}║${NC}"
    echo -e "${CYAN}  ║${NC}  ${CYAN}${nick}${NC}@${CYAN}nexus${NC} ~ ${WHITE}❯${NC} _              ${CYAN}║${NC}"
    echo -e "${CYAN}  ║${NC}                                     ${CYAN}║${NC}"
    echo -e "${CYAN}  ║${NC}  ${DARK}Cyan prompt with clean arrow${NC}        ${CYAN}║${NC}"
    echo -e "${CYAN}  ╚══════════════════════════════════════╝${NC}"
}

PS1_NEON() {
    local nick="${NEXUS_NICKNAME:-user}"
    echo -e "${PURPLE}  ╔══════════════════════════════════════╗${NC}"
    echo -e "${PURPLE}  ║${NC}  ${WHITE}N E O N   P R O M P T${NC}                 ${PURPLE}║${NC}"
    echo -e "${PURPLE}  ║${NC}                                     ${PURPLE}║${NC}"
    echo -e "${PURPLE}  ║${NC}  ${PURPLE}╭─${NC} ${WHITE}${nick}${NC}@nexus ${PURPLE}╰─${NC} ${PURPLE}\$${NC} _        ${PURPLE}║${NC}"
    echo -e "${PURPLE}  ║${NC}                                     ${PURPLE}║${NC}"
    echo -e "${PURPLE}  ║${NC}  ${DARK}Rounded box style prompt${NC}            ${PURPLE}║${NC}"
    echo -e "${PURPLE}  ╚══════════════════════════════════════╝${NC}"
}

PS1_HACKER() {
    local nick="${NEXUS_NICKNAME:-user}"
    echo -e "${GREEN}  ╔══════════════════════════════════════╗${NC}"
    echo -e "${GREEN}  ║${NC}  ${WHITE}H A C K E R   P R O M P T${NC}              ${GREEN}║${NC}"
    echo -e "${GREEN}  ║${NC}                                     ${GREEN}║${NC}"
    echo -e "${GREEN}  ║${NC}  ${GREEN}[${NC}${WHITE}${nick}${NC}${GREEN}@${NC}${WHITE}nexus${NC}${GREEN}]${NC} ~ ${GREEN}#${NC} _              ${GREEN}║${NC}"
    echo -e "${GREEN}  ║${NC}                                     ${GREEN}║${NC}"
    echo -e "${GREEN}  ║${NC}  ${DARK}Root-style bracket prompt${NC}           ${GREEN}║${NC}"
    echo -e "${GREEN}  ╚══════════════════════════════════════╝${NC}"
}

PS1_ARROW() {
    local nick="${NEXUS_NICKNAME:-user}"
    echo -e "${BLUE}  ╔══════════════════════════════════════╗${NC}"
    echo -e "${BLUE}  ║${NC}  ${WHITE}A R R O W   P R O M P T${NC}                ${BLUE}║${NC}"
    echo -e "${BLUE}  ║${NC}                                     ${BLUE}║${NC}"
    echo -e "${BLUE}  ║${NC}  ${BLUE}➜${NC}  ${WHITE}~${NC} _                             ${BLUE}║${NC}"
    echo -e "${BLUE}  ║${NC}                                     ${BLUE}║${NC}"
    echo -e "${BLUE}  ║${NC}  ${DARK}Minimal arrow style${NC}                 ${BLUE}║${NC}"
    echo -e "${BLUE}  ╚══════════════════════════════════════╝${NC}"
}

PS1_GIT() {
    local nick="${NEXUS_NICKNAME:-user}"
    echo -e "${YELLOW}  ╔══════════════════════════════════════╗${NC}"
    echo -e "${YELLOW}  ║${NC}  ${WHITE}G I T   P R O M P T${NC}                   ${YELLOW}║${NC}"
    echo -e "${YELLOW}  ║${NC}                                     ${YELLOW}║${NC}"
    echo -e "${YELLOW}  ║${NC}  ${YELLOW}(${NC}${WHITE}main${NC}${YELLOW})${NC} ${WHITE}${nick}${NC}@nexus ~ _          ${YELLOW}║${NC}"
    echo -e "${YELLOW}  ║${NC}                                     ${YELLOW}║${NC}"
    echo -e "${YELLOW}  ║${NC}  ${DARK}Shows git branch in prompt${NC}           ${YELLOW}║${NC}"
    echo -e "${YELLOW}  ╚══════════════════════════════════════╝${NC}"
}

PS1_POWERLINE() {
    local nick="${NEXUS_NICKNAME:-user}"
    echo -e "${CYAN}  ╔══════════════════════════════════════╗${NC}"
    echo -e "${CYAN}  ║${NC}  ${WHITE}P O W E R L I N E   P R O M P T${NC}        ${CYAN}║${NC}"
    echo -e "${CYAN}  ║${NC}                                     ${CYAN}║${NC}"
    echo -e "${CYAN}  ║${NC}  ${CYAN}${nick}${NC}${PURPLE} ➤ ${NC}${WHITE}~${NC}${GREEN} ❯${NC} _                    ${CYAN}║${NC}"
    echo -e "${CYAN}  ║${NC}                                     ${CYAN}║${NC}"
    echo -e "${CYAN}  ║${NC}  ${DARK}Multi-color powerline style${NC}          ${CYAN}║${NC}"
    echo -e "${CYAN}  ╚══════════════════════════════════════╝${NC}"
}

PS1_MINIMAL() {
    local nick="${NEXUS_NICKNAME:-user}"
    echo -e "${WHITE}  ╔══════════════════════════════════════╗${NC}"
    echo -e "${WHITE}  ║${NC}  ${WHITE}M I N I M A L   P R O M P T${NC}             ${WHITE}║${NC}"
    echo -e "${WHITE}  ║${NC}                                     ${WHITE}║${NC}"
    echo -e "${WHITE}  ║${NC}  ${DARK}\$${NC} _                               ${WHITE}║${NC}"
    echo -e "${WHITE}  ║${NC}                                     ${WHITE}║${NC}"
    echo -e "${WHITE}  ║${NC}  ${DARK}Simple dollar sign prompt${NC}            ${WHITE}║${NC}"
    echo -e "${WHITE}  ╚══════════════════════════════════════╝${NC}"
}

PS1_FANCY() {
    local nick="${NEXUS_NICKNAME:-user}"
    echo -e "${PURPLE}  ╔══════════════════════════════════════╗${NC}"
    echo -e "${PURPLE}  ║${NC}  ${WHITE}F A N C Y   P R O M P T${NC}                ${PURPLE}║${NC}"
    echo -e "${PURPLE}  ║${NC}                                     ${PURPLE}║${NC}"
    echo -e "${PURPLE}  ║${NC}  ${PURPLE}┌──${NC}(${CYAN}${nick}@nexus${NC})-${WHITE}~${NC}                  ${PURPLE}║${NC}"
    echo -e "${PURPLE}  ║${NC}  ${PURPLE}└──╼${NC} \$ _                            ${PURPLE}║${NC}"
    echo -e "${PURPLE}  ║${NC}                                     ${PURPLE}║${NC}"
    echo -e "${PURPLE}  ║${NC}  ${DARK}Two-line fancy prompt${NC}               ${PURPLE}║${NC}"
    echo -e "${PURPLE}  ╚══════════════════════════════════════╝${NC}"
}

# ============================================================
#   APPLY PS1
# ============================================================

apply_ps1() {
    local ps1_type="$1"
    local shell_rc=""
    [ -f "$HOME/.bashrc" ] && shell_rc="$HOME/.bashrc"
    [ -f "$HOME/.zshrc" ] && shell_rc="$HOME/.zshrc"

    if [ -z "$shell_rc" ]; then
        shell_rc="$HOME/.bashrc"
        touch "$shell_rc"
    fi

    # Remove old PS1
    sed -i '/# Nexus PS1 Config/,/# Nexus PS1 End/d' "$shell_rc" 2>/dev/null || true

    local ps1_line=""

    case "$ps1_type" in
        cyber)
            ps1_line='PS1="\[\033[0;36m\]\u@\h \[\033[1;37m\]\w \[\033[0;36m\]❯ \[\033[0m\]"'
            ;;
        neon)
            ps1_line='PS1="\[\033[0;35m\]╭─ \[\033[1;37m\]\u@\h \[\033[0;35m\]╰─ \[\033[0;36m\]\$\[\033[0m\] "'
            ;;
        hacker)
            ps1_line='PS1="\[\033[0;32m\][\[\033[1;37m\]\u@\h\[\033[0;32m\]] \[\033[0;32m\]#\[\033[0m\] "'
            ;;
        arrow)
            ps1_line='PS1="\[\033[0;34m\]➜  \[\033[1;37m\]\w \[\033[0m\] "'
            ;;
        git)
            ps1_line='PS1="\[\033[1;33m\](\[\033[0;32m\]$(git branch 2>/dev/null | sed -n "s/* //p")\[\033[1;33m\])\[\033[1;37m\] \u@\h \[\033[0m\]\w "'
            ;;
        powerline)
            ps1_line='PS1="\[\033[0;36m\]\u@\h\[\033[0;35m\] ➤ \[\033[1;37m\]\w\[\033[0;32m\] ❯ \[\033[0m\]"'
            ;;
        minimal)
            ps1_line='PS1="\[\033[2;37m\]\$ \[\033[0m\]"'
            ;;
        fancy)
            ps1_line='PS1="\[\033[0;35m\]┌──\[\033[0;36m\](\u@\h)\[\033[1;37m\]-~\n\[\033[0;35m\]└──╼\[\033[0m\] \$ "'
            ;;
    esac

    if [ -n "$ps1_line" ]; then
        echo "" >> "$shell_rc"
        echo "# Nexus PS1 Config" >> "$shell_rc"
        echo "$ps1_line" >> "$shell_rc"
        echo "# Nexus PS1 End" >> "$shell_rc"

        # Save to config
        if [ -f "$CONFIG_DIR/settings.conf" ]; then
            sed -i "s/^NEXUS_BANNER=.*/NEXUS_BANNER=\"$ps1_type\"/" "$CONFIG_DIR/settings.conf"
        fi
    fi
}

# ============================================================
#   PS1 MENU
# ============================================================

ps1_menu() {
    while true; do
        printf "\033c"
        echo ""
        echo -e "${CYAN}  ╔═══════════════════════════════════════════════╗${NC}"
        echo -e "${CYAN}  ║${NC}       ${WHITE}P R O M P T   S E L E C T O R${NC}             ${CYAN}║${NC}"
        echo -e "${CYAN}  ╚═══════════════════════════════════════════════╝${NC}"
        echo ""
        echo -e "  ${CYAN}[1]${NC}  ${WHITE}Cyber${NC}      ${DARK}- Clean arrow prompt${NC}"
        echo -e "  ${PURPLE}[2]${NC}  ${WHITE}Neon${NC}       ${DARK}- Rounded box style${NC}"
        echo -e "  ${GREEN}[3]${NC}  ${WHITE}Hacker${NC}     ${DARK}- Root-style brackets${NC}"
        echo -e "  ${BLUE}[4]${NC}  ${WHITE}Arrow${NC}      ${DARK}- Minimal arrow${NC}"
        echo -e "  ${YELLOW}[5]${NC}  ${WHITE}Git${NC}        ${DARK}- Shows git branch${NC}"
        echo -e "  ${CYAN}[6]${NC}  ${WHITE}Powerline${NC}  ${DARK}- Multi-color powerline${NC}"
        echo -e "  ${WHITE}[7]${NC}  ${WHITE}Minimal${NC}    ${DARK}- Simple dollar sign${NC}"
        echo -e "  ${PURPLE}[8]${NC}  ${WHITE}Fancy${NC}      ${DARK}- Two-line fancy${NC}"
        echo -e "  ${DARK}[0]${NC}  ${DARK}Voltar${NC}"
        echo ""
        echo -ne "  ${CYAN}❯${NC} ${WHITE}Selecione um prompt: ${NC}"

        read -r choice
        echo ""

        case "$choice" in
            1) PS1_CYBER;    apply_ps1 "cyber" ;;
            2) PS1_NEON;     apply_ps1 "neon" ;;
            3) PS1_HACKER;   apply_ps1 "hacker" ;;
            4) PS1_ARROW;    apply_ps1 "arrow" ;;
            5) PS1_GIT;      apply_ps1 "git" ;;
            6) PS1_POWERLINE; apply_ps1 "powerline" ;;
            7) PS1_MINIMAL;  apply_ps1 "minimal" ;;
            8) PS1_FANCY;    apply_ps1 "fancy" ;;
            0) return ;;
            *)
                echo -e "  ${RED}[!]${NC} Opcao invalida."
                sleep 1
                continue
                ;;
        esac

        echo ""
        echo -e "  ${GREEN}[OK]${NC} Prompt aplicado com sucesso!"
        echo -e "  ${DARK}Reinicie o terminal para ver as mudancas.${NC}"
        echo ""
        echo -ne "  ${DARK}Pressione [ENTER] para continuar...${NC}"
        read -r
    done
}

ps1_menu
