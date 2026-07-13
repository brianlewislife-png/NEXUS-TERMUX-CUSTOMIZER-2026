#!/bin/bash

# ============================================================
#   NEXUS TERMUX CUSTOMIZER 2026
#   Developer: Brian Lewis
#   Instagram: @Brian_lewis_2
#   Platform: Termux (Android)
# ============================================================

NEXUS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$NEXUS_DIR/config"
BACKUP_DIR="$NEXUS_DIR/backups"

# ============================================================
#   COLORS
# ============================================================

C='\033[0;36m'    # Cyan
P='\033[0;35m'    # Purple
B='\033[0;34m'    # Blue
G='\033[0;32m'    # Green
Y='\033[1;33m'    # Yellow
R='\033[0;31m'    # Red
W='\033[1;37m'    # White
D='\033[2;37m'    # Dark
NC='\033[0m'      # Reset

# ============================================================
#   LOAD SETTINGS
# ============================================================

load_settings() {
    NEXUS_VERSION="2.0.0"
    NEXUS_THEME="cyber"
    NEXUS_USERNAME=""
    NEXUS_NICKNAME=""
    NEXUS_PS1="cyber"
    NEXUS_MOTD="welcome"

    if [ -f "$CONFIG_DIR/settings.conf" ]; then
        while IFS='=' read -r key value; do
            value="${value%\"}"
            value="${value#\"}"
            case "$key" in
                NEXUS_VERSION)    NEXUS_VERSION="$value" ;;
                NEXUS_THEME)      NEXUS_THEME="$value" ;;
                NEXUS_USERNAME)   NEXUS_USERNAME="$value" ;;
                NEXUS_NICKNAME)   NEXUS_NICKNAME="$value" ;;
                NEXUS_PS1)        NEXUS_PS1="$value" ;;
                NEXUS_MOTD)       NEXUS_MOTD="$value" ;;
            esac
        done < <(grep -v '^#' "$CONFIG_DIR/settings.conf" 2>/dev/null | grep -v '^$')
    fi
}

save_settings() {
    mkdir -p "$CONFIG_DIR"
    cat > "$CONFIG_DIR/settings.conf" << EOF
NEXUS_VERSION="$NEXUS_VERSION"
NEXUS_THEME="$NEXUS_THEME"
NEXUS_USERNAME="$NEXUS_USERNAME"
NEXUS_NICKNAME="$NEXUS_NICKNAME"
NEXUS_PS1="$NEXUS_PS1"
NEXUS_MOTD="$NEXUS_MOTD"
EOF
}

# ============================================================
#   BANNER DISPLAY
# ============================================================

show_banner() {
    printf "\033c"
    echo ""
    echo -e "${C}"
    cat << 'ART'
  ███╗   ██╗███████╗██╗  ██╗██╗   ██╗███████╗
  ████╗  ██║██╔════╝╚██╗██╔╝██║   ██║██╔════╝
  ██╔██╗ ██║█████╗   ╚███╔╝ ██║   ██║███████╗
  ██║╚██╗██║██╔══╝   ██╔██╗ ██║   ██║╚════██║
  ██║ ╚████║███████╗██╔╝ ██╗╚██████╔╝███████║
  ╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝
ART
    echo -e "${NC}"
    echo -e "  ${P}╔═══════════════════════════════════════════════╗${NC}"
    echo -e "  ${P}║${NC}   ${W}T E R M U X   C U S T O M I Z E R   2 0 2 6${NC}   ${P}║${NC}"
    echo -e "  ${P}╚═══════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "  ${D}Desenvolvido por: ${W}Brian Lewis${NC}"
    echo -e "  ${D}Instagram: ${P}@Brian_lewis_2${NC}"
    echo -e "  ${D}Version: ${C}$NEXUS_VERSION${NC}"
    echo ""
}

# ============================================================
#   WELCOME
# ============================================================

show_welcome() {
    local name="${NEXUS_NICKNAME:-$NEXUS_USERNAME}"
    [ -z "$name" ] && name="Developer"

    echo -e "  ${C}╔═══════════════════════════════════════════════╗${NC}"
    echo -e "  ${C}║${NC}                                               ${C}║${NC}"
    echo -e "  ${C}║${NC}  ${W}Welcome back, ${G}${name}${W}!${NC}                          ${C}║${NC}"
    echo -e "  ${C}║${NC}  ${D}What would you like to do today?${NC}             ${C}║${NC}"
    echo -e "  ${C}║${NC}                                               ${C}║${NC}"
    echo -e "  ${C}╚═══════════════════════════════════════════════╝${NC}"
    echo ""
}

# ============================================================
#   MAIN MENU
# ============================================================

show_menu() {
    echo -e "  ${P}╔═══════════════════════════════════════════════╗${NC}"
    echo -e "  ${P}║${NC}              ${W}M A I N   M E N U${NC}                 ${P}║${NC}"
    echo -e "  ${P}╠═══════════════════════════════════════════════╣${NC}"
    echo -e "  ${P}║${NC}                                               ${P}║${NC}"
    echo -e "  ${P}║${NC}  ${C}[1]${NC}  ${W}Personalizacao manual do terminal${NC}       ${P}║${NC}"
    echo -e "  ${P}║${NC}  ${C}[2]${NC}  ${W}Criar banner personalizado${NC}              ${P}║${NC}"
    echo -e "  ${P}║${NC}  ${C}[3]${NC}  ${W}Escolher temas${NC}                          ${P}║${NC}"
    echo -e "  ${P}║${NC}  ${C}[4]${NC}  ${W}Configuracoes avancadas${NC}                  ${P}║${NC}"
    echo -e "  ${P}║${NC}  ${C}[5]${NC}  ${W}Modo automatico (tudo)${NC}                   ${P}║${NC}"
    echo -e "  ${P}║${NC}  ${C}[6]${NC}  ${W}Sobre o projeto${NC}                         ${P}║${NC}"
    echo -e "  ${P}║${NC}                                               ${P}║${NC}"
    echo -e "  ${P}║${NC}  ${R}[0]${NC}  ${D}Sair${NC}                                     ${P}║${NC}"
    echo -e "  ${P}║${NC}                                               ${P}║${NC}"
    echo -e "  ${P}╚═══════════════════════════════════════════════╝${NC}"
    echo ""
    echo -ne "  ${C}>${NC} ${W}Selecione: ${NC}"
}

# ============================================================
#   [1] MANUAL CUSTOMIZATION
# ============================================================

manual_setup() {
    printf "\033c"
    echo ""
    echo -e "  ${C}╔═══════════════════════════════════════════════╗${NC}"
    echo -e "  ${C}║${NC}    ${W}M A N U A L   C U S T O M I Z A T I O N${NC}     ${C}║${NC}"
    echo -e "  ${C}╚═══════════════════════════════════════════════╝${NC}"
    echo ""

    # Name
    echo -e "  ${D}Nome atual: ${W}${NEXUS_USERNAME:-Nao definido}${NC}"
    echo -ne "  ${C}>${NC} ${W}Novo nome (ENTER para manter): ${NC}"
    read -r new_name
    [ -n "$new_name" ] && NEXUS_USERNAME="$new_name"

    # Nickname
    echo -e "  ${D}Apelido atual: ${W}${NEXUS_NICKNAME:-Nao definido}${NC}"
    echo -ne "  ${C}>${NC} ${W}Novo apelido (ENTER para manter): ${NC}"
    read -r new_nick
    [ -n "$new_nick" ] && NEXUS_NICKNAME="$new_nick"

    echo ""
    echo -e "  ${W}Escolha o prompt (PS1):${NC}"
    echo -e "  ${C}[1]${NC} cyber    ${D}- user@host ~/path >${NC}"
    echo -e "  ${C}[2]${NC} neon     ${D}|- user@host -$ ${NC}"
    echo -e "  ${C}[3]${NC} hacker   ${D}- [user@host] #${NC}"
    echo -e "  ${C}[4]${NC} arrow    ${D}- -> ~/path${NC}"
    echo -e "  ${C}[5]${NC} fancy    ${D}- two-line powerline${NC}"
    echo -ne "  ${C}>${NC} ${W}Opcao: ${NC}"
    read -r ps1_choice

    case "$ps1_choice" in
        1) NEXUS_PS1="cyber" ;;
        2) NEXUS_PS1="neon" ;;
        3) NEXUS_PS1="hacker" ;;
        4) NEXUS_PS1="arrow" ;;
        5) NEXUS_PS1="fancy" ;;
    esac

    apply_ps1
    save_settings

    echo ""
    echo -e "  ${G}[OK]${NC} Configuracao salva!"
    echo -ne "  ${D}Pressione ENTER para voltar...${NC}"
    read -r
}

# ============================================================
#   [2] BANNER CREATOR
# ============================================================

banner_creator() {
    printf "\033c"
    echo ""
    echo -e "  ${C}╔═══════════════════════════════════════════════╗${NC}"
    echo -e "  ${C}║${NC}       ${W}B A N N E R   C R E A T O R${NC}              ${C}║${NC}"
    echo -e "  ${C}╚═══════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "  ${C}[1]${NC}  ${W}Classico${NC}     ${D}- Banner ASCII completo${NC}"
    echo -e "  ${C}[2]${NC}  ${W}Minimal${NC}      ${D}- Design limpo${NC}"
    echo -e "  ${C}[3]${NC}  ${W}Hacker${NC}       ${D}- Estilo cyberpunk${NC}"
    echo -e "  ${C}[4]${NC}  ${W}Customizado${NC}  ${D}- Crie o seu proprio${NC}"
    echo -e "  ${D}[0]${NC}  ${D}Voltar${NC}"
    echo ""
    echo -ne "  ${C}>${NC} ${W}Selecione: ${NC}"
    read -r choice

    local nick="${NEXUS_NICKNAME:-${NEXUS_USERNAME:-Developer}}"
    local banner_content=""

    case "$choice" in
        1)
            banner_content=$(cat << BANNER
${C}╔══════════════════════════════════════════════════╗
║                                                  ║
║   ${W}██████╗ ██╗  ██╗ █████╗ ███╗   ██╗████████╗${NC}${C}   ║
║   ${W}██╔══██╗██║  ██║██╔══██╗████╗  ██║╚══██╔══╝${NC}${C}   ║
║   ${W}██████╔╝███████║███████║██╔██╗ ██║   ██║${NC}${C}      ║
║   ${W}██╔═══╝ ██╔══██║██╔══██║██║╚██╗██║   ██║${NC}${C}      ║
║   ${W}██║     ██║  ██║██║  ██║██║ ╚████║   ██║${NC}${C}      ║
║   ${W}╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝   ╚═╝${NC}${C}      ║
║                                                  ║
║   ${G}Welcome, ${nick}!${NC}${C}                                  ║
║   ${D}Termux Customizer v2.0${NC}${C}                        ║
║                                                  ║
╚══════════════════════════════════════════════════╝${NC}
BANNER
            )
            ;;
        2)
            banner_content=$(cat << BANNER
${P}  ┌──────────────────────────────────────────┐
  │                                          │
  │   ${W}N E X U S${NC}${P}  ${D}·${NC}${W}  T E R M${NC}${P}                │
  │                                          │
  │   ${G}${nick}${NC}${P}                                     │
  │   ${D}>_${NC}                                     │
  │                                          │
  └──────────────────────────────────────────┘${NC}
BANNER
            )
            ;;
        3)
            banner_content=$(cat << BANNER
${G}  ╔══════════════════════════════════════════════╗
  ║  ${W}██████╗ ██╗  ██╗ █████╗ ███╗   ██╗████████╗${NC}${G} ║
  ║  ${W}██╔══██╗██║  ██║██╔══██╗████╗  ██║╚══██╔══╝${NC}${G} ║
  ║  ${W}██████╔╝███████║███████║██╔██╗ ██║   ██║${NC}${G}    ║
  ║  ${W}██╔═══╝ ██╔══██║██╔══██║██║╚██╗██║   ██║${NC}${G}    ║
  ║  ${W}██║     ██║  ██║██║  ██║██║ ╚████║   ██║${NC}${G}    ║
  ║  ${W}╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝   ╚═╝${NC}${G}    ║
  ║                                            ║
  ║  ${D}[${G}+${D}] User: ${W}${nick}${NC}${G}                           ║
  ║  ${D}[${G}+${D}] Status: ${G}ACTIVE${NC}${G}                       ║
  ╚══════════════════════════════════════════════╝${NC}
BANNER
            )
            ;;
        4)
            echo ""
            echo -ne "  ${C}>${NC} ${W}Linha 1 do banner: ${NC}"
            read -r line1
            echo -ne "  ${C}>${NC} ${W}Linha 2 do banner: ${NC}"
            read -r line2
            banner_content=$(cat << BANNER
${C}╔══════════════════════════════════════════════════╗
║                                                  ║
║   ${W}${nick}${NC}${C}                                           ║
║                                                  ║
║   ${G}${line1}${NC}${C}                                           ║
║   ${P}${line2}${NC}${C}                                           ║
║                                                  ║
╚══════════════════════════════════════════════════╝${NC}
BANNER
            )
            ;;
        0) return ;;
    esac

    if [ -n "$banner_content" ]; then
        echo ""
        echo "$banner_content"
        echo ""
        echo -ne "  ${G}>${NC} ${W}Aplicar este banner? (s/n): ${NC}"
        read -r apply
        if [[ "$apply" =~ ^[Ss]$ ]]; then
            apply_motd_banner "$banner_content"
            echo -e "  ${G}[OK]${NC} Banner aplicado!"
        fi
    fi

    echo -ne "  ${D}Pressione ENTER para voltar...${NC}"
    read -r
}

apply_motd_banner() {
    local content="$1"
    local shell_rc=""
    [ -f "$HOME/.bashrc" ] && shell_rc="$HOME/.bashrc"
    [ -f "$HOME/.zshrc" ] && shell_rc="$HOME/.zshrc"
    [ -z "$shell_rc" ] && shell_rc="$HOME/.bashrc"

    sed -i '/# Nexus MOTD/,/# Nexus MOTD End/d' "$shell_rc" 2>/dev/null

    cat > "$CONFIG_DIR/motd.sh" << MOTDEOF
#!/bin/bash
echo -e "$content"
MOTDEOF

    cat >> "$shell_rc" << 'RCEOF'

# Nexus MOTD
if [ -f "$HOME/.nexus-termux/config/motd.sh" ]; then
    bash "$HOME/.nexus-termux/config/motd.sh"
fi
# Nexus MOTD End
RCEOF
}

# ============================================================
#   [3] THEME SELECTOR
# ============================================================

theme_selector() {
    printf "\033c"
    echo ""
    echo -e "  ${C}╔═══════════════════════════════════════════════╗${NC}"
    echo -e "  ${C}║${NC}        ${W}T H E M E   S E L E C T O R${NC}             ${C}║${NC}"
    echo -e "  ${C}╚═══════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "  ${D}Tema atual: ${C}${NEXUS_THEME}${NC}"
    echo ""
    echo -e "  ${C}[1]${NC}  ${W}Cyber${NC}     ${D}- Azul ciano futurista${NC}"
    echo -e "  ${P}[2]${NC}  ${W}Neon${NC}      ${D}- Roxo neon vibrante${NC}"
    echo -e "  ${B}[3]${NC}  ${W}Ocean${NC}     ${D}- Azul profundo${NC}"
    echo -e "  ${G}[4]${NC}  ${W}Matrix${NC}    ${D}- Verde classico${NC}"
    echo -e "  ${R}[5]${NC}  ${W}Sunset${NC}    ${D}- Vermelho e laranja${NC}"
    echo -e "  ${P}[6]${NC}  ${W}Dracula${NC}   ${D}- Roxo e ciano${NC}"
    echo -e "  ${D}[0]${NC}  ${D}Voltar${NC}"
    echo ""
    echo -ne "  ${C}>${NC} ${W}Selecione: ${NC}"
    read -r choice

    case "$choice" in
        1) NEXUS_THEME="cyber" ;;
        2) NEXUS_THEME="neon" ;;
        3) NEXUS_THEME="ocean" ;;
        4) NEXUS_THEME="matrix" ;;
        5) NEXUS_THEME="sunset" ;;
        6) NEXUS_THEME="dracula" ;;
        0) return ;;
        *) echo -e "  ${R}[!]${NC} Invalido"; sleep 1; return ;;
    esac

    apply_theme
    save_settings
    echo ""
    echo -e "  ${G}[OK]${NC} Tema ${C}${NEXUS_THEME}${NC} aplicado!"
    echo -e "  ${D}Reinicie o terminal para ver as mudancas.${NC}"
    echo -ne "  ${D}Pressione ENTER para voltar...${NC}"
    read -r
}

apply_theme() {
    local shell_rc=""
    [ -f "$HOME/.bashrc" ] && shell_rc="$HOME/.bashrc"
    [ -f "$HOME/.zshrc" ] && shell_rc="$HOME/.zshrc"
    [ -z "$shell_rc" ] && shell_rc="$HOME/.bashrc"

    sed -i '/# Nexus Theme/,/# Nexus Theme End/d' "$shell_rc" 2>/dev/null

    local ps1_line=""
    local ls_colors=""

    case "$NEXUS_THEME" in
        cyber)
            ps1_line='PS1="\[\033[0;36m\]\u@\h \[\033[1;37m\]\w \[\033[0;36m\]❯ \[\033[0m\]"'
            ls_colors='export LS_COLORS="di=0;36:ln=0;36:so=0;35:ex=1;32:ow=0;36"'
            ;;
        neon)
            ps1_line='PS1="\[\033[0;35m\]╭─ \[\033[1;37m\]\u@\h \[\033[0;35m\]╰─ \[\033[0;36m\]\$ \[\033[0m\]"'
            ls_colors='export LS_COLORS="di=0;35:ln=0;35:so=0;31:ex=1;32:ow=0;35"'
            ;;
        ocean)
            ps1_line='PS1="\[\033[0;34m\]\u@\h \[\033[1;37m\]\w \[\033[0;34m\]❯ \[\033[0m\]"'
            ls_colors='export LS_COLORS="di=0;34:ln=0;36:so=0;35:ex=1;32:ow=0;34"'
            ;;
        matrix)
            ps1_line='PS1="\[\033[0;32m\]\u@\h \[\033[1;37m\]\w \[\033[0;32m\]❯ \[\033[0m\]"'
            ls_colors='export LS_COLORS="di=0;32:ln=0;36:so=0;35:ex=1;32:ow=0;32"'
            ;;
        sunset)
            ps1_line='PS1="\[\033[0;31m\]\u@\h \[\033[1;37m\]\w \[\033[0;31m\]❯ \[\033[0m\]"'
            ls_colors='export LS_COLORS="di=0;31:ln=0;33:so=0;35:ex=1;32:ow=0;31"'
            ;;
        dracula)
            ps1_line='PS1="\[\033[0;35m\]\u@\h \[\033[1;37m\]\w \[\033[0;36m\]❯ \[\033[0m\]"'
            ls_colors='export LS_COLORS="di=0;35:ln=0;36:so=0;32:ex=1;32:ow=0;35"'
            ;;
    esac

    cat >> "$shell_rc" << THEMEEOF

# Nexus Theme
export TERM=xterm-256color
$ps1_line
$ls_colors
# Nexus Theme End
THEMEEOF
}

# ============================================================
#   [4] ADVANCED SETTINGS
# ============================================================

advanced_settings() {
    while true; do
        printf "\033c"
        echo ""
        echo -e "  ${C}╔═══════════════════════════════════════════════╗${NC}"
        echo -e "  ${C}║${NC}     ${W}A D V A N C E D   S E T T I N G S${NC}          ${C}║${NC}"
        echo -e "  ${C}╚═══════════════════════════════════════════════╝${NC}"
        echo ""
        echo -e "  ${C}[1]${NC}  ${W}Gerenciar aliases${NC}"
        echo -e "  ${C}[2]${NC}  ${W}Instalar pacotes${NC}"
        echo -e "  ${C}[3]${NC}  ${W}Configurar PS1 customizado${NC}"
        echo -e "  ${C}[4]${NC}  ${W}MOTD (mensagem ao iniciar)${NC}"
        echo -e "  ${C}[5]${NC}  ${W}Backup / Restaurar${NC}"
        echo -e "  ${C}[6]${NC}  ${W}Atualizar ferramenta${NC}"
        echo -e "  ${D}[0]${NC}  ${D}Voltar${NC}"
        echo ""
        echo -ne "  ${C}>${NC} ${W}Selecione: ${NC}"
        read -r choice

        case "$choice" in
            1) manage_aliases ;;
            2) install_packages ;;
            3) custom_ps1 ;;
            4) configure_motd ;;
            5) backup_restore ;;
            6) update_tool ;;
            0) return ;;
        esac
    done
}

# --- Aliases ---
manage_aliases() {
    printf "\033c"
    echo ""
    echo -e "  ${C}╔═══════════════════════════════════════════════╗${NC}"
    echo -e "  ${C}║${NC}          ${W}A L I A S   M A N A G E R${NC}             ${C}║${NC}"
    echo -e "  ${C}╚═══════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "  ${C}[1]${NC}  ${W}Carregar aliases essenciais${NC}"
    echo -e "  ${C}[2]${NC}  ${W}Carregar aliases de dev${NC}"
    echo -e "  ${C}[3]${NC}  ${W}Carregar todos os presets${NC}"
    echo -e "  ${C}[4]${NC}  ${W}Criar alias customizado${NC}"
    echo -e "  ${D}[0]${NC}  ${D}Voltar${NC}"
    echo ""
    echo -ne "  ${C}>${NC} ${W}Selecione: ${NC}"
    read -r choice

    local shell_rc=""
    [ -f "$HOME/.bashrc" ] && shell_rc="$HOME/.bashrc"
    [ -f "$HOME/.zshrc" ] && shell_rc="$HOME/.zshrc"
    [ -z "$shell_rc" ] && shell_rc="$HOME/.bashrc"

    case "$choice" in
        1)
            sed -i '/# Nexus Aliases/,/# Nexus Aliases End/d' "$shell_rc" 2>/dev/null
            cat >> "$shell_rc" << 'EOF'

# Nexus Aliases
alias ll='ls -la --color=auto'
alias la='ls -A --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias cls='clear'
alias home='cd ~'
alias reload='source ~/.bashrc'
alias update='pkg update && pkg upgrade -y'
alias myip='curl -s ifconfig.me'
alias nexus='bash ~/.nexus-termux/main.sh'
# Nexus Aliases End
EOF
            echo -e "\n  ${G}[OK]${NC} Aliases essenciais instalados!"
            ;;
        2)
            sed -i '/# Nexus Aliases/,/# Nexus Aliases End/d' "$shell_rc" 2>/dev/null
            cat >> "$shell_rc" << 'EOF'

# Nexus Aliases
alias ll='ls -la --color=auto'
alias la='ls -A --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias cls='clear'
alias home='cd ~'
alias reload='source ~/.bashrc'
alias update='pkg update && pkg upgrade -y'
alias myip='curl -s ifconfig.me'
alias docs='cd ~/Documents'
alias downloads='cd ~/Downloads'
alias projects='cd ~/projects'
alias py='python3'
alias serve='python3 -m http.server 8080'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline'
alias ports='netstat -tuln'
alias nexus='bash ~/.nexus-termux/main.sh'
# Nexus Aliases End
EOF
            echo -e "\n  ${G}[OK]${NC} Aliases de dev instalados!"
            ;;
        3)
            sed -i '/# Nexus Aliases/,/# Nexus Aliases End/d' "$shell_rc" 2>/dev/null
            cat >> "$shell_rc" << 'EOF'

# Nexus Aliases
alias ll='ls -la --color=auto'
alias la='ls -A --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias cls='clear'
alias home='cd ~'
alias reload='source ~/.bashrc'
alias update='pkg update && pkg upgrade -y'
alias myip='curl -s ifconfig.me'
alias docs='cd ~/Documents'
alias downloads='cd ~/Downloads'
alias projects='cd ~/projects'
alias py='python3'
alias serve='python3 -m http.server 8080'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline'
alias ports='netstat -tuln'
alias scan='nmap -sV'
alias nexus='bash ~/.nexus-termux/main.sh'
# Nexus Aliases End
EOF
            echo -e "\n  ${G}[OK]${NC} Todos os aliases instalados!"
            ;;
        4)
            echo ""
            echo -ne "  ${C}>${NC} ${W}Nome do alias: ${NC}"
            read -r aname
            echo -ne "  ${C}>${NC} ${W}Comando: ${NC}"
            read -r acmd
            if [ -n "$aname" ] && [ -n "$acmd" ]; then
                sed -i '/# Nexus Aliases End/d' "$shell_rc" 2>/dev/null
                echo "alias ${aname}='${acmd}'" >> "$shell_rc"
                echo "# Nexus Aliases End" >> "$shell_rc"
                echo -e "\n  ${G}[OK]${NC} Alias ${C}${aname}${NC} criado!"
            fi
            ;;
        0) return ;;
    esac

    echo -ne "\n  ${D}Pressione ENTER para voltar...${NC}"
    read -r
}

# --- Install Packages ---
install_packages() {
    printf "\033c"
    echo ""
    echo -e "  ${C}╔═══════════════════════════════════════════════╗${NC}"
    echo -e "  ${C}║${NC}       ${W}P A C K A G E   I N S T A L L E R${NC}         ${C}║${NC}"
    echo -e "  ${C}╚═══════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "  ${C}[1]${NC}  ${W}Essenciais${NC}    ${D}- git, curl, wget, nano${NC}"
    echo -e "  ${C}[2]${NC}  ${W}Utils${NC}         ${D}- neofetch, htop, figlet${NC}"
    echo -e "  ${C}[3]${NC}  ${W}Dev${NC}           ${D}- python, nodejs, golang${NC}"
    echo -e "  ${C}[4]${NC}  ${W}Tudo${NC}          ${D}- Instalar tudo${NC}"
    echo -e "  ${D}[0]${NC}  ${D}Voltar${NC}"
    echo ""
    echo -ne "  ${C}>${NC} ${W}Selecione: ${NC}"
    read -r choice

    local IS_TERMUX=0
    [ -d "/data/data/com.termux" ] && IS_TERMUX=1

    do_install() {
        for pkg in $1; do
            echo -ne "  ${D}[${NC}${W}${pkg}${NC}${D}]${NC} "
            if command -v "$pkg" > /dev/null 2>&1; then
                echo -e "${G}ja instalado${NC}"
            else
                if [ "$IS_TERMUX" -eq 1 ]; then
                    pkg install -y "$pkg" > /dev/null 2>&1
                elif command -v apt > /dev/null 2>&1; then
                    sudo apt install -y "$pkg" > /dev/null 2>&1
                fi
                if command -v "$pkg" > /dev/null 2>&1; then
                    echo -e "${G}ok${NC}"
                else
                    echo -e "${D}skip${NC}"
                fi
            fi
        done
    }

    echo ""
    case "$choice" in
        1) do_install "git curl wget nano vim zip unzip tar tree" ;;
        2) do_install "neofetch htop figlet fortune cowsay" ;;
        3)
            if [ "$IS_TERMUX" -eq 1 ]; then
                do_install "python nodejs"
            else
                do_install "python3 nodejs golang rust"
            fi
            ;;
        4)
            do_install "git curl wget nano vim zip unzip tar tree neofetch htop figlet fortune"
            if [ "$IS_TERMUX" -eq 1 ]; then
                do_install "python nodejs"
            else
                do_install "python3 nodejs"
            fi
            ;;
        0) return ;;
    esac

    echo -ne "\n  ${D}Pressione ENTER para voltar...${NC}"
    read -r
}

# --- Custom PS1 ---
custom_ps1() {
    printf "\033c"
    echo ""
    echo -e "  ${C}╔═══════════════════════════════════════════════╗${NC}"
    echo -e "  ${C}║${NC}         ${W}P S 1   C U S T O M I Z E R${NC}            ${C}║${NC}"
    echo -e "  ${C}╚═══════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "  ${C}[1]${NC}  ${W}user@host ~/path >${NC}       ${D}- Classico${NC}"
    echo -e "  ${C}[2]${NC}  ${W}|- user@host -$${NC}           ${D}- Neon box${NC}"
    echo -e "  ${C}[3]${NC}  ${W}[user@host] #${NC}             ${D}- Hacker root${NC}"
    echo -e "  ${C}[4]${NC}  ${W}-> ~/path${NC}                ${D}- Arrow minimal${NC}"
    echo -e "  ${C}[5]${NC}  ${W}Two-line powerline${NC}        ${D}- Fancy${NC}"
    echo -e "  ${C}[6]${NC}  ${W}\$${NC}                          ${D}- Dollar sign${NC}"
    echo -e "  ${D}[0]${NC}  ${D}Voltar${NC}"
    echo ""
    echo -ne "  ${C}>${NC} ${W}Selecione: ${NC}"
    read -r choice

    local shell_rc=""
    [ -f "$HOME/.bashrc" ] && shell_rc="$HOME/.bashrc"
    [ -f "$HOME/.zshrc" ] && shell_rc="$HOME/.zshrc"
    [ -z "$shell_rc" ] && shell_rc="$HOME/.bashrc"

    sed -i '/# Nexus PS1/,/# Nexus PS1 End/d' "$shell_rc" 2>/dev/null

    local ps1_line=""
    case "$choice" in
        1) ps1_line='PS1="\[\033[0;36m\]\u@\h \[\033[1;37m\]\w \[\033[0;36m\]> \[\033[0m\]"' ;;
        2) ps1_line='PS1="\[\033[0;35m\]|- \[\033[1;37m\]\u@\h \[\033[0;35m\]-$ \[\033[0m\]"' ;;
        3) ps1_line='PS1="\[\033[0;32m\][\[\033[1;37m\]\u@\h\[\033[0;32m\]] \[\033[0;32m\]# \[\033[0m\]"' ;;
        4) ps1_line='PS1="\[\033[0;34m\]-> \[\033[1;37m\]\w \[\033[0m\]"' ;;
        5) ps1_line='PS1="\[\033[0;35m\]┌──\[\033[0;36m\](\u@\h)\[\033[1;37m\]-~\n\[\033[0;35m\]└──╼\[\033[0m\] \$ "' ;;
        6) ps1_line='PS1="\[\033[2;37m\]\$ \[\033[0m\]"' ;;
        0) return ;;
    esac

    if [ -n "$ps1_line" ]; then
        echo "" >> "$shell_rc"
        echo "# Nexus PS1" >> "$shell_rc"
        echo "$ps1_line" >> "$shell_rc"
        echo "# Nexus PS1 End" >> "$shell_rc"
        NEXUS_PS1="$choice"
        save_settings
        echo -e "\n  ${G}[OK]${NC} PS1 atualizado!"
    fi

    echo -ne "\n  ${D}Pressione ENTER para voltar...${NC}"
    read -r
}

# --- MOTD ---
configure_motd() {
    printf "\033c"
    echo ""
    echo -e "  ${C}╔═══════════════════════════════════════════════╗${NC}"
    echo -e "  ${C}║${NC}       ${W}M O T D   C O N F I G U R A T O R${NC}        ${C}║${NC}"
    echo -e "  ${C}╚═══════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "  ${D}Mensagem exibida ao abrir o Termux${NC}"
    echo ""
    echo -e "  ${C}[1]${NC}  ${W}Welcome${NC}      ${D}- Boas-vindas com nome e data${NC}"
    echo -e "  ${C}[2]${NC}  ${W}System Info${NC}  ${D}- Info do dispositivo${NC}"
    echo -e "  ${C}[3]${NC}  ${W}ASCII Art${NC}    ${D}- Banner visual${NC}"
    echo -e "  ${C}[4]${NC}  ${W}Desativar${NC}    ${D}- Sem mensagem${NC}"
    echo -e "  ${D}[0]${NC}  ${D}Voltar${NC}"
    echo ""
    echo -ne "  ${C}>${NC} ${W}Selecione: ${NC}"
    read -r choice

    local shell_rc=""
    [ -f "$HOME/.bashrc" ] && shell_rc="$HOME/.bashrc"
    [ -f "$HOME/.zshrc" ] && shell_rc="$HOME/.zshrc"
    [ -z "$shell_rc" ] && shell_rc="$HOME/.bashrc"

    sed -i '/# Nexus MOTD/,/# Nexus MOTD End/d' "$shell_rc" 2>/dev/null
    rm -f "$CONFIG_DIR/motd.sh"

    case "$choice" in
        1)
            local nick="${NEXUS_NICKNAME:-${NEXUS_USERNAME:-Developer}}"
            cat > "$CONFIG_DIR/motd.sh" << MEOF
echo -e ""
echo -e "\033[0;36m  Welcome back, \033[1;37m${nick}\033[0;36m!\033[0m"
echo -e "\033[2;37m  \$(date +'%A, %d %B %Y - %H:%M')\033[0m"
echo -e ""
MEOF
            add_motd_to_rc "$shell_rc"
            echo -e "\n  ${G}[OK]${NC} MOTD Welcome ativado!"
            ;;
        2)
            cat > "$CONFIG_DIR/motd.sh" << 'MEOF'
echo -e ""
echo -e "\033[0;36m  ┌──────────────────────────────────┐\033[0m"
echo -e "\033[0;36m  │\033[0m  \033[1;37mSystem Info\033[0m                   \033[0;36m│\033[0m"
echo -e "\033[0;36m  ├──────────────────────────────────┤\033[0m"
echo -e "\033[0;36m  │\033[0m  \033[2;37mUser:\033[0m   \033[1;37m\$(whoami)\033[0m              \033[0;36m│\033[0m"
echo -e "\033[0;36m  │\033[0m  \033[2;37mShell:\033[0m  \033[1;37m\${SHELL}\033[0m              \033[0;36m│\033[0m"
echo -e "\033[0;36m  │\033[0m  \033[2;37mDate:\033[0m   \033[1;37m\$(date +'%d/%m/%Y %H:%M')\033[0m \033[0;36m│\033[0m"
echo -e "\033[0;36m  └──────────────────────────────────┘\033[0m"
echo -e ""
MEOF
            add_motd_to_rc "$shell_rc"
            echo -e "\n  ${G}[OK]${NC} MOTD System ativado!"
            ;;
        3)
            local nick="${NEXUS_NICKNAME:-${NEXUS_USERNAME:-NEXUS}}"
            cat > "$CONFIG_DIR/motd.sh" << MEOF
echo -e ""
echo -e "\033[0;36m  ███╗   ██╗ ██████╗ \033[0m"
echo -e "\033[0;36m  ████╗  ██║██╔═══██╗\033[0m"
echo -e "\033[0;36m  ██╔██╗ ██║██║   ██║\033[0m  \033[1;37m${nick}\033[0m"
echo -e "\033[0;36m  ██║╚██╗██║██║   ██║\033[0m"
echo -e "\033[0;36m  ██║ ╚████║╚██████╔╝\033[0m  \033[2;37mNEXUS 2026\033[0m"
echo -e "\033[0;36m  ╚═╝  ╚═══╝ ╚═════╝ \033[0m"
echo -e ""
MEOF
            add_motd_to_rc "$shell_rc"
            echo -e "\n  ${G}[OK]${NC} MOTD ASCII ativado!"
            ;;
        4)
            echo -e "\n  ${G}[OK]${NC} MOTD desativado!"
            ;;
        0) return ;;
    esac

    echo -ne "\n  ${D}Pressione ENTER para voltar...${NC}"
    read -r
}

add_motd_to_rc() {
    local rc="$1"
    cat >> "$rc" << 'MOTDRC'

# Nexus MOTD
if [ -f "$HOME/.nexus-termux/config/motd.sh" ]; then
    bash "$HOME/.nexus-termux/config/motd.sh"
fi
# Nexus MOTD End
MOTDRC
}

# --- Backup / Restore ---
backup_restore() {
    printf "\033c"
    echo ""
    echo -e "  ${C}╔═══════════════════════════════════════════════╗${NC}"
    echo -e "  ${C}║${NC}       ${W}B A C K U P   M A N A G E R${NC}              ${C}║${NC}"
    echo -e "  ${C}╚═══════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "  ${C}[1]${NC}  ${W}Criar backup${NC}"
    echo -e "  ${C}[2]${NC}  ${W}Listar backups${NC}"
    echo -e "  ${C}[3]${NC}  ${W}Restaurar backup${NC}"
    echo -e "  ${D}[0]${NC}  ${D}Voltar${NC}"
    echo ""
    echo -ne "  ${C}>${NC} ${W}Selecione: ${NC}"
    read -r choice

    case "$choice" in
        1)
            local ts=$(date +"%Y%m%d_%H%M%S")
            local bdir="$BACKUP_DIR/backup_${ts}"
            mkdir -p "$bdir"
            [ -f "$CONFIG_DIR/settings.conf" ] && cp "$CONFIG_DIR/settings.conf" "$bdir/"
            [ -f "$CONFIG_DIR/motd.sh" ] && cp "$CONFIG_DIR/motd.sh" "$bdir/"
            local shell_rc=""
            [ -f "$HOME/.bashrc" ] && shell_rc="$HOME/.bashrc"
            [ -f "$HOME/.zshrc" ] && shell_rc="$HOME/.zshrc"
            [ -n "$shell_rc" ] && cp "$shell_rc" "$bdir/"
            echo -e "\n  ${G}[OK]${NC} Backup criado: $bdir"
            ;;
        2)
            echo ""
            if ls "$BACKUP_DIR"/backup_* > /dev/null 2>&1; then
                ls -d "$BACKUP_DIR"/backup_* | while read -r d; do
                    echo -e "  ${C}>${NC} $(basename "$d")"
                done
            else
                echo -e "  ${D}Nenhum backup encontrado.${NC}"
            fi
            ;;
        3)
            echo ""
            if ls "$BACKUP_DIR"/backup_* > /dev/null 2>&1; then
                local i=1
                local backups=()
                for d in "$BACKUP_DIR"/backup_*; do
                    backups+=("$d")
                    echo -e "  ${C}[$i]${NC} $(basename "$d")"
                    ((i++))
                done
                echo ""
                echo -ne "  ${C}>${NC} ${W}Numero do backup: ${NC}"
                read -r num
                if [ "$num" -ge 1 ] && [ "$num" -le ${#backups[@]} ]; then
                    local bdir="${backups[$((num-1))]}"
                    [ -f "$bdir/settings.conf" ] && cp "$bdir/settings.conf" "$CONFIG_DIR/"
                    [ -f "$bdir/motd.sh" ] && cp "$bdir/motd.sh" "$CONFIG_DIR/"
                    local shell_rc=""
                    [ -f "$HOME/.bashrc" ] && shell_rc="$HOME/.bashrc"
                    [ -f "$HOME/.zshrc" ] && shell_rc="$HOME/.zshrc"
                    [ -n "$shell_rc" ] && [ -f "$bdir/$(basename "$shell_rc")" ] && cp "$bdir/$(basename "$shell_rc")" "$HOME/"
                    echo -e "\n  ${G}[OK]${NC} Backup restaurado!"
                fi
            else
                echo -e "  ${D}Nenhum backup encontrado.${NC}"
            fi
            ;;
        0) return ;;
    esac

    echo -ne "\n  ${D}Pressione ENTER para voltar...${NC}"
    read -r
}

# --- Update ---
update_tool() {
    echo ""
    echo -e "  ${Y}[*]${NC} Atualizando Nexus Termux Customizer..."
    cd "$NEXUS_DIR" && git pull 2>/dev/null
    chmod +x "$NEXUS_DIR/main.sh" 2>/dev/null
    chmod +x "$NEXUS_DIR/install.sh" 2>/dev/null
    echo -e "\n  ${G}[OK]${NC} Ferramenta atualizada!"
    echo -ne "\n  ${D}Pressione ENTER para voltar...${NC}"
    read -r
}

# ============================================================
#   [5] AUTO MODE
# ============================================================

auto_mode() {
    printf "\033c"
    echo ""
    echo -e "  ${C}╔═══════════════════════════════════════════════╗${NC}"
    echo -e "  ${C}║${NC}      ${W}A U T O   M O D E${NC}                        ${C}║${NC}"
    echo -e "  ${C}╚═══════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "  ${D}Isso ira configurar tudo automaticamente.${NC}"
    echo -e "  ${D}Tema cyber, aliases essenciais, PS1 classico.${NC}"
    echo ""
    echo -ne "  ${G}>${NC} ${W}Continuar? (s/n): ${NC}"
    read -r confirm

    if [[ ! "$confirm" =~ ^[Ss]$ ]]; then
        return
    fi

    echo ""
    echo -e "  ${Y}[*]${NC} Configurando tema..."
    NEXUS_THEME="cyber"
    apply_theme

    echo -e "  ${Y}[*]${NC} Instalando aliases..."
    local shell_rc=""
    [ -f "$HOME/.bashrc" ] && shell_rc="$HOME/.bashrc"
    [ -f "$HOME/.zshrc" ] && shell_rc="$HOME/.zshrc"
    [ -z "$shell_rc" ] && shell_rc="$HOME/.bashrc"

    sed -i '/# Nexus Aliases/,/# Nexus Aliases End/d' "$shell_rc" 2>/dev/null
    cat >> "$shell_rc" << 'EOF'

# Nexus Aliases
alias ll='ls -la --color=auto'
alias la='ls -A --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias cls='clear'
alias home='cd ~'
alias reload='source ~/.bashrc'
alias update='pkg update && pkg upgrade -y'
alias myip='curl -s ifconfig.me'
alias nexus='bash ~/.nexus-termux/main.sh'
# Nexus Aliases End
EOF

    echo -e "  ${Y}[*]${NC} Configurando PS1..."
    sed -i '/# Nexus PS1/,/# Nexus PS1 End/d' "$shell_rc" 2>/dev/null
    echo "" >> "$shell_rc"
    echo "# Nexus PS1" >> "$shell_rc"
    echo 'PS1="\[\033[0;36m\]\u@\h \[\033[1;37m\]\w \[\033[0;36m\]> \[\033[0m\]"' >> "$shell_rc"
    echo "# Nexus PS1 End" >> "$shell_rc"

    echo -e "  ${Y}[*]${NC} Configurando MOTD..."
    local nick="${NEXUS_NICKNAME:-${NEXUS_USERNAME:-Developer}}"
    cat > "$CONFIG_DIR/motd.sh" << MEOF
echo -e ""
echo -e "\033[0;36m  Welcome, \033[1;37m${nick}\033[0;36m!\033[0m"
echo -e "\033[2;37m  \$(date +'%A, %d %B %Y - %H:%M')\033[0m"
echo -e ""
MEOF
    add_motd_to_rc "$shell_rc"

    save_settings

    echo ""
    echo -e "  ${G}[OK]${NC} Configuracao automatica completa!"
    echo -e "  ${D}Reinicie o terminal para aplicar todas as mudancas.${NC}"
    echo -ne "\n  ${D}Pressione ENTER para voltar...${NC}"
    read -r
}

# ============================================================
#   [6] ABOUT
# ============================================================

show_about() {
    printf "\033c"
    echo ""
    echo -e "${C}"
    cat << 'ABOUT'
  ███╗   ██╗███████╗██╗  ██╗██╗   ██╗███████╗
  ████╗  ██║██╔════╝╚██╗██╔╝██║   ██║██╔════╝
  ██╔██╗ ██║█████╗   ╚███╔╝ ██║   ██║███████╗
  ██║╚██╗██║██╔══╝   ██╔██╗ ██║   ██║╚════██║
  ██║ ╚████║███████╗██╔╝ ██╗╚██████╔╝███████║
  ╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝
ABOUT
    echo -e "${NC}"
    echo -e "  ${P}╔═══════════════════════════════════════════════╗${NC}"
    echo -e "  ${P}║${NC}   ${W}T E R M U X   C U S T O M I Z E R   2 0 2 6${NC}   ${P}║${NC}"
    echo -e "  ${P}╚═══════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "  ${W}Ferramenta criada e desenvolvida por:${NC}"
    echo ""
    echo -e "  ${C}  ██████╗ ██╗${NC}   ${C}██╗${NC}"
    echo -e "  ${C}  ██╔══██╗██║${NC}   ${C}██║${NC}"
    echo -e "  ${C}  ██████╔╝██║${NC}   ${C}██║${NC}     ${W}Brian Lewis${NC}"
    echo -e "  ${C}  ██╔══██╗██║${NC}   ${C}██║${NC}"
    echo -e "  ${C}  ██████╔╝╚██████╔╝${NC}     ${P}@Brian_lewis_2${NC}"
    echo -e "  ${C}  ╚═════╝  ╚═════╝${NC}"
    echo ""
    echo -e "  ${D}Instagram: ${P}@Brian_lewis_2${NC}"
    echo ""
    echo -e "  ${W}Projeto open source para usuarios Termux.${NC}"
    echo -e "  ${W}Transforme seu terminal em um ambiente profissional.${NC}"
    echo ""
    echo -e "  ${C}Version:  ${W}$NEXUS_VERSION${NC}"
    echo -e "  ${C}License:  ${W}MIT${NC}"
    echo -e "  ${C}Platform: ${W}Termux (Android)${NC}"
    echo ""
    echo -e "  ${D}GitHub: https://github.com/brianlewislife-png/NEXUS-TERMUX-CUSTOMIZER-2026${NC}"
    echo ""
    echo -ne "\n  ${D}Pressione ENTER para voltar...${NC}"
    read -r
}

# ============================================================
#   FIRST RUN
# ============================================================

first_run() {
    if [ -z "$NEXUS_USERNAME" ]; then
        printf "\033c"
        echo ""
        echo -e "${C}"
        cat << 'FIRSTRUN'
  ███╗   ██╗███████╗██╗  ██╗██╗   ██╗███████╗
  ████╗  ██║██╔════╝╚██╗██╔╝██║   ██║██╔════╝
  ██╔██╗ ██║█████╗   ╚███╔╝ ██║   ██║███████╗
  ██║╚██╗██║██╔══╝   ██╔██╗ ██║   ██║╚════██║
  ██║ ╚████║███████╗██╔╝ ██╗╚██████╔╝███████║
  ╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝
FIRSTRUN
        echo -e "${NC}"
        echo -e "  ${W}Bem-vindo! Vamos configurar seu ambiente.${NC}"
        echo ""
        echo -e "  ${D}Responda 2 perguntas para comecar:${NC}"
        echo ""
        echo -e "  ${C}──────────────────────────────────────${NC}"
        echo ""
        echo -ne "  ${P}[1/2]${NC} Qual seu nome? ${C}>${NC} "
        read -r name
        echo ""
        echo -ne "  ${P}[2/2]${NC} Qual seu apelido/vulgo? ${C}>${NC} "
        read -r nick

        [ -z "$name" ] && name="Developer"
        [ -z "$nick" ] && nick="$name"

        NEXUS_USERNAME="$name"
        NEXUS_NICKNAME="$nick"
        save_settings

        echo ""
        echo -e "  ${G}[OK]${NC} Configuracao salva!"
        echo ""
        echo -e "  ${C}──────────────────────────────────────${NC}"
        echo -e "  ${W}Ola, ${G}${nick}${W}! Ambiente configurado.${NC}"
        echo -e "  ${C}──────────────────────────────────────${NC}"
        echo ""
        echo -ne "  ${D}Pressione ENTER para continuar...${NC}"
        read -r
    fi
}

# ============================================================
#   MAIN LOOP
# ============================================================

main() {
    mkdir -p "$CONFIG_DIR" "$BACKUP_DIR"
    load_settings
    first_run

    while true; do
        show_banner
        show_welcome
        show_menu

        read -r choice
        echo ""

        case "$choice" in
            1) manual_setup ;;
            2) banner_creator ;;
            3) theme_selector ;;
            4) advanced_settings ;;
            5) auto_mode ;;
            6) show_about ;;
            0)
                printf "\033c"
                echo ""
                echo -e "${C}========================================${NC}"
                echo -e "${W}  Obrigado por usar o${NC}"
                echo -e "${W}  ${P}NEXUS TERMUX CUSTOMIZER 2026${NC}"
                echo -e "${C}========================================${NC}"
                echo ""
                echo -e "${D}Desenvolvido por:${NC}"
                echo -e "${W}Brian Lewis${NC}"
                echo -e "${P}@Brian_lewis_2${NC}"
                echo ""
                echo -e "${C}========================================${NC}"
                echo ""
                exit 0
                ;;
            *)
                echo -e "  ${R}[!]${NC} Opcao invalida."
                sleep 1
                ;;
        esac
    done
}

main
