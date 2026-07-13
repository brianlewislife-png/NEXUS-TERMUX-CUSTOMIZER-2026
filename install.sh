#!/bin/bash

# ============================================================
#   NEXUS TERMUX CUSTOMIZER 2026 - Installer
#   Developer: Brian Lewis
#   Instagram: @Brian_lewis_2
# ============================================================

INSTALL_DIR="$HOME/.nexus-termux"
REPO_URL="https://github.com/brianlewislife-png/NEXUS-TERMUX-CUSTOMIZER-2026.git"

CYAN='\033[0;36m'
PURPLE='\033[0;35m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
WHITE='\033[1;37m'
DARK='\033[2;37m'
NC='\033[0m'

printf "\033c"

echo -e "${CYAN}"
cat << 'HEADER'

  ███╗   ██╗███████╗██╗  ██╗██╗   ██╗███████╗
  ████╗  ██║██╔════╝╚██╗██╔╝██║   ██║██╔════╝
  ██╔██╗ ██║█████╗   ╚███╔╝ ██║   ██║███████╗
  ██║╚██╗██║██╔══╝   ██╔██╗ ██║   ██║╚════██║
  ██║ ╚████║███████╗██╔╝ ██╗╚██████╔╝███████║
  ╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝
  ╔═══════════════════════════════════════════╗
  ║    T E R M U X   C U S T O M I Z E R     ║
  ║                2 0 2 6                    ║
  ╚═══════════════════════════════════════════╝

HEADER
echo -e "${NC}"
echo -e "  ${DARK}Desenvolvido por: ${WHITE}Brian Lewis${NC}"
echo -e "  ${DARK}Instagram: ${PURPLE}@Brian_lewis_2${NC}"
echo ""

# ============================================================
#   CHECK TERMUX
# ============================================================

IS_TERMUX=0
if [ -d "/data/data/com.termux" ]; then
    IS_TERMUX=1
fi

# ============================================================
#   INSTALL DEPENDENCIES
# ============================================================

echo -e "${YELLOW}[*] Verificando dependencias...${NC}"
echo ""

DEPS="git curl wget bash"
for dep in $DEPS; do
    if command -v "$dep" > /dev/null 2>&1; then
        echo -e "  ${GREEN}[OK]${NC} $dep"
    else
        echo -e "  ${YELLOW}[*]${NC} Instalando $dep..."
        if [ "$IS_TERMUX" -eq 1 ]; then
            pkg update -y > /dev/null 2>&1
            pkg install -y "$dep" > /dev/null 2>&1
        elif command -v apt > /dev/null 2>&1; then
            sudo apt update -y > /dev/null 2>&1
            sudo apt install -y "$dep" > /dev/null 2>&1
        fi
        if command -v "$dep" > /dev/null 2>&1; then
            echo -e "  ${GREEN}[OK]${NC} $dep"
        else
            echo -e "  ${RED}[FALHOU]${NC} $dep"
        fi
    fi
done

# ============================================================
#   INSTALL OPTIONAL PACKAGES
# ============================================================

echo ""
echo -e "${YELLOW}[*] Instalando pacotes opcionais...${NC}"
echo ""

OPT_PKG="neofetch tree htop figlet fortune"
for pkg in $OPT_PKG; do
    if command -v "$pkg" > /dev/null 2>&1; then
        echo -e "  ${GREEN}[OK]${NC} $pkg"
    else
        if [ "$IS_TERMUX" -eq 1 ]; then
            pkg install -y "$pkg" > /dev/null 2>&1
        elif command -v apt > /dev/null 2>&1; then
            sudo apt install -y "$pkg" > /dev/null 2>&1
        fi
        if command -v "$pkg" > /dev/null 2>&1; then
            echo -e "  ${GREEN}[OK]${NC} $pkg"
        else
            echo -e "  ${DARK}[SKIP]${NC} $pkg (opcional)"
        fi
    fi
done

# ============================================================
#   CLONE / UPDATE PROJECT
# ============================================================

echo ""
echo -e "${YELLOW}[*] Baixando Nexus Termux Customizer...${NC}"
echo ""

if [ -d "$INSTALL_DIR" ]; then
    echo -e "  ${DARK}[INFO]${NC} Diretorio ja existe. Atualizando..."
    cd "$INSTALL_DIR" && git pull > /dev/null 2>&1
else
    git clone "$REPO_URL" "$INSTALL_DIR" > /dev/null 2>&1
fi

if [ ! -d "$INSTALL_DIR" ]; then
    echo -e "  ${RED}[ERRO]${NC} Falha ao baixar o projeto."
    echo -e "  ${DARK}Verifique sua conexao com a internet.${NC}"
    exit 1
fi

chmod +x "$INSTALL_DIR/install.sh" 2>/dev/null
chmod +x "$INSTALL_DIR/main.sh" 2>/dev/null

if [ -d "$INSTALL_DIR/modules" ]; then
    chmod +x "$INSTALL_DIR/modules/"*.sh 2>/dev/null
fi

echo -e "  ${GREEN}[OK]${NC} Projeto instalado em: $INSTALL_DIR"

# ============================================================
#   CREATE NEXUS COMMAND
# ============================================================

echo ""
echo -e "${YELLOW}[*] Criando comando 'nexus'...${NC}"
echo ""

# Create a wrapper script in a PATH-accessible location
NEXUS_BIN="$HOME/.nexus-bin"
mkdir -p "$NEXUS_BIN"

cat > "$NEXUS_BIN/nexus" << WRAPPER
#!/bin/bash
exec bash "$INSTALL_DIR/main.sh" "\$@"
WRAPPER
chmod +x "$NEXUS_BIN/nexus"

# Add to PATH if not already there
SHELL_RC=""
[ -f "$HOME/.bashrc" ] && SHELL_RC="$HOME/.bashrc"
[ -f "$HOME/.zshrc" ] && SHELL_RC="$HOME/.zshrc"

if [ -n "$SHELL_RC" ]; then
    if ! grep -q ".nexus-bin" "$SHELL_RC" 2>/dev/null; then
        echo "" >> "$SHELL_RC"
        echo "# Nexus Termux Customizer 2026" >> "$SHELL_RC"
        echo 'export PATH="$HOME/.nexus-bin:$PATH"' >> "$SHELL_RC"
    fi
    # Source it for current session
    export PATH="$HOME/.nexus-bin:$PATH"
fi

# Also try to link to Termux PREFIX/bin
if [ "$IS_TERMUX" -eq 1 ] && [ -d "$PREFIX/bin" ]; then
    ln -sf "$NEXUS_BIN/nexus" "$PREFIX/bin/nexus" 2>/dev/null
fi

echo -e "  ${GREEN}[OK]${NC} Comando 'nexus' criado"

# ============================================================
#   CREATE DEFAULT CONFIG
# ============================================================

echo ""
echo -e "${YELLOW}[*] Criando configuracoes iniciais...${NC}"
echo ""

mkdir -p "$INSTALL_DIR/config"
mkdir -p "$INSTALL_DIR/backups"
mkdir -p "$INSTALL_DIR/banners"

cat > "$INSTALL_DIR/config/settings.conf" << 'CONF'
NEXUS_VERSION="2.0.0"
NEXUS_THEME="cyber"
NEXUS_USERNAME=""
NEXUS_NICKNAME=""
NEXUS_BANNER="default"
NEXUS_PS1="cyber"
NEXUS_MOTD="welcome"
CONF

echo -e "  ${GREEN}[OK]${NC} Configuracoes criadas"

# ============================================================
#   INSTALLATION COMPLETE - LAUNCH MAIN
# ============================================================

echo ""
echo -e "${CYAN}========================================${NC}"
echo -e "${GREEN}  INSTALACAO COMPLETA!${NC}"
echo -e "${CYAN}========================================${NC}"
echo ""
echo -e "  ${WHITE}Para iniciar a qualquer momento:${NC}"
echo -e "  ${CYAN}nexus${NC}"
echo ""
echo -e "${DARK}Iniciando ferramenta...${NC}"
echo ""

sleep 2

# LAUNCH THE MAIN TOOL
exec bash "$INSTALL_DIR/main.sh"
