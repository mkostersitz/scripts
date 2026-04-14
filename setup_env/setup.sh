#!/bin/bash

# Cross-platform Shell Environment Setup Script
# Supports macOS, Linux, and Windows (Git Bash/WSL)
# Installs: Starship, Nerd Fonts, Zsh plugins, modern CLI tools

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Global variables
DRY_RUN=false
DETECTED_OS=""
SHELL_CONFIG=""
SHELL_TYPE=""

# Utility functions
print_header() {
    echo -e "\n${BLUE}═══════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  $1${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}\n"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

run_cmd() {
    if [ "$DRY_RUN" = true ]; then
        echo -e "${YELLOW}[DRY RUN]${NC} $*"
    else
        "$@"
    fi
}

# Detect operating system
detect_os() {
    print_header "Detecting Operating System"
    
    if [[ "$OSTYPE" == "darwin"* ]]; then
        DETECTED_OS="macos"
        print_success "Detected: macOS"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        DETECTED_OS="linux"
        print_success "Detected: Linux"
    elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
        DETECTED_OS="windows"
        print_success "Detected: Windows (Git Bash/MSYS)"
    elif grep -qEi "(Microsoft|WSL)" /proc/version 2>/dev/null; then
        DETECTED_OS="wsl"
        print_success "Detected: Windows Subsystem for Linux (WSL)"
    else
        print_error "Unknown operating system: $OSTYPE"
        exit 1
    fi
}

# Detect shell type and config file
detect_shell() {
    print_header "Detecting Shell"
    
    if [ -n "$ZSH_VERSION" ]; then
        SHELL_TYPE="zsh"
        SHELL_CONFIG="$HOME/.zshrc"
    elif [ -n "$BASH_VERSION" ]; then
        SHELL_TYPE="bash"
        SHELL_CONFIG="$HOME/.bashrc"
    else
        # Check default shell
        SHELL_TYPE=$(basename "$SHELL")
        if [ "$SHELL_TYPE" = "zsh" ]; then
            SHELL_CONFIG="$HOME/.zshrc"
        else
            SHELL_CONFIG="$HOME/.bashrc"
        fi
    fi
    
    print_success "Detected shell: $SHELL_TYPE"
    print_info "Config file: $SHELL_CONFIG"
}

# Backup shell config
backup_config() {
    if [ -f "$SHELL_CONFIG" ]; then
        local backup_file="${SHELL_CONFIG}.backup.$(date +%Y%m%d_%H%M%S)"
        print_info "Creating backup: $backup_file"
        run_cmd cp "$SHELL_CONFIG" "$backup_file"
        print_success "Backup created"
    else
        print_info "No existing config file to backup"
    fi
}

# Install Homebrew (macOS/Linux)
install_homebrew() {
    if command -v brew &> /dev/null; then
        print_success "Homebrew already installed"
        return 0
    fi
    
    print_info "Installing Homebrew..."
    if [ "$DRY_RUN" = true ]; then
        echo -e "${YELLOW}[DRY RUN]${NC} Would install Homebrew"
    else
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        # Add Homebrew to PATH
        if [ "$DETECTED_OS" = "macos" ]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        elif [ "$DETECTED_OS" = "linux" ] || [ "$DETECTED_OS" = "wsl" ]; then
            eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        fi
    fi
    print_success "Homebrew installed"
}

# Install packages with Homebrew
install_brew_packages() {
    print_header "Installing Packages with Homebrew"
    
    local packages=(
        # Core
        "starship"
        "git"
        
        # Development tools
        "uv"
        "node"
        
        # Enhanced commands
        "eza"
        "bat"
        "fd"
        
        # Navigation and search
        "zoxide"
        "fzf"
        
        # Productivity
        "thefuck"
        "tldr"
        "ncdu"
        "yazi"
        "lazygit"
    )
    
    if [ "$DETECTED_OS" = "macos" ]; then
        # macOS specific packages
        packages+=("zsh-syntax-highlighting" "zsh-autosuggestions")
    fi
    
    for package in "${packages[@]}"; do
        if brew list "$package" &>/dev/null; then
            print_success "$package already installed"
        else
            print_info "Installing $package..."
            run_cmd brew install "$package"
            print_success "$package installed"
        fi
    done
}

# Install Nerd Fonts
install_nerd_fonts() {
    print_header "Installing Nerd Fonts"
    
    if [ "$DETECTED_OS" = "macos" ]; then
        local font="font-fira-code-nerd-font"
        if brew list --cask "$font" &>/dev/null; then
            print_success "FiraCode Nerd Font already installed"
        else
            print_info "Installing FiraCode Nerd Font..."
            run_cmd brew install --cask "$font"
            print_success "FiraCode Nerd Font installed"
        fi
    elif [ "$DETECTED_OS" = "linux" ] || [ "$DETECTED_OS" = "wsl" ]; then
        if fc-list | grep -qi "FiraCode Nerd Font"; then
            print_success "FiraCode Nerd Font already installed"
        else
            print_info "Installing FiraCode Nerd Font..."
            if [ "$DRY_RUN" = false ]; then
                mkdir -p ~/.local/share/fonts
                cd ~/.local/share/fonts
                curl -fLo "FiraCode Nerd Font.ttf" https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/FiraCode/Regular/FiraCodeNerdFont-Regular.ttf
                fc-cache -fv
                cd - > /dev/null
            else
                echo -e "${YELLOW}[DRY RUN]${NC} Would install FiraCode Nerd Font"
            fi
            print_success "FiraCode Nerd Font installed"
        fi
    fi
}

# Install packages with winget (Windows)
install_winget_packages() {
    print_header "Installing Packages with Winget"
    
    if ! command -v winget.exe &> /dev/null; then
        print_error "Winget not found. Please install it from the Microsoft Store."
        return 1
    fi
    
    local packages=(
        "Starship.Starship"
        "Git.Git"
        "JanDeDobbeleer.OhMyPosh"  # Alternative to starship
        "Nerd Fonts - FiraCode"
    )
    
    for package in "${packages[@]}"; do
        print_info "Installing $package..."
        run_cmd winget.exe install -e --id "$package"
    done
}

# Configure Zsh plugins (macOS)
configure_zsh_plugins() {
    if [ "$SHELL_TYPE" != "zsh" ] || [ "$DETECTED_OS" != "macos" ]; then
        return 0
    fi
    
    print_header "Configuring Zsh Plugins"
    
    local plugin_config="
# Zsh plugins (installed via Homebrew)
source \$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source \$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
"
    
    if grep -q "zsh-autosuggestions" "$SHELL_CONFIG" 2>/dev/null; then
        print_success "Zsh plugins already configured"
    else
        print_info "Adding Zsh plugin configuration..."
        if [ "$DRY_RUN" = false ]; then
            echo "$plugin_config" >> "$SHELL_CONFIG"
        else
            echo -e "${YELLOW}[DRY RUN]${NC} Would add Zsh plugin configuration"
        fi
        print_success "Zsh plugins configured"
    fi
}

# Configure Starship
configure_starship() {
    print_header "Configuring Starship"
    
    # Add starship init to shell config
    local starship_init=""
    if [ "$SHELL_TYPE" = "zsh" ]; then
        starship_init='eval "$(starship init zsh)"'
    else
        starship_init='eval "$(starship init bash)"'
    fi
    
    if grep -q "starship init" "$SHELL_CONFIG" 2>/dev/null; then
        print_success "Starship already configured in $SHELL_CONFIG"
    else
        print_info "Adding Starship initialization..."
        if [ "$DRY_RUN" = false ]; then
            echo -e "\n# Starship prompt\n$starship_init" >> "$SHELL_CONFIG"
        else
            echo -e "${YELLOW}[DRY RUN]${NC} Would add Starship initialization"
        fi
        print_success "Starship configured"
    fi
    
    # Download starship.toml configuration
    local config_dir="$HOME/.config"
    local starship_config="$config_dir/starship.toml"
    
    if [ -f "$starship_config" ]; then
        print_warning "Starship config already exists at $starship_config"
        read -p "Do you want to overwrite it? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            print_info "Skipping Starship config download"
            return 0
        fi
    fi
    
    print_info "Creating Starship configuration directory..."
    run_cmd mkdir -p "$config_dir"
    
    print_info "Downloading Starship configuration..."
    if [ "$DRY_RUN" = false ]; then
        curl -fsSL https://gist.githubusercontent.com/sttamper/ff69056e8cb94be9397a2c5508e57018/raw -o "$starship_config"
        print_success "Starship configuration downloaded to $starship_config"
    else
        echo -e "${YELLOW}[DRY RUN]${NC} Would download Starship configuration"
    fi
}

# Configure shell aliases and integrations
configure_shell_integrations() {
    print_header "Configuring Shell Aliases and Integrations"
    
    local integration_config="
# Tool integrations
eval \"\$(zoxide init $SHELL_TYPE)\"
eval \"\$(thefuck --alias)\"

# Enhanced defaults
alias ls='eza --icons=auto --color=auto'
alias la='ls --almost-all'
alias ll='ls --long --time-style=relative --ignore-glob=.git'
alias lla='la --long --time-style=relative --ignore-glob=.git'
alias cat='bat'

# Navigation shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias c='clear'

# Safety
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# Pager configuration
export MANPAGER=\"sh -c 'col -bx | bat -l man -p'\"
export PAGER=\"bat\"
export EDITOR=\"nano\"
"
    
    if grep -q "zoxide init" "$SHELL_CONFIG" 2>/dev/null; then
        print_success "Shell integrations already configured"
    else
        print_info "Adding shell integrations..."
        if [ "$DRY_RUN" = false ]; then
            echo "$integration_config" >> "$SHELL_CONFIG"
        else
            echo -e "${YELLOW}[DRY RUN]${NC} Would add shell integrations"
        fi
        print_success "Shell integrations configured"
    fi
}

# Configure Homebrew PATH
configure_brew_path() {
    local brew_init=""
    
    if [ "$DETECTED_OS" = "macos" ]; then
        brew_init='eval "$(/opt/homebrew/bin/brew shellenv)"'
    elif [ "$DETECTED_OS" = "linux" ] || [ "$DETECTED_OS" = "wsl" ]; then
        brew_init='eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"'
    else
        return 0
    fi
    
    if grep -q "brew shellenv" "$SHELL_CONFIG" 2>/dev/null; then
        print_success "Homebrew PATH already configured"
    else
        print_info "Adding Homebrew to PATH..."
        if [ "$DRY_RUN" = false ]; then
            echo -e "\n# Homebrew\n$brew_init" >> "$SHELL_CONFIG"
        else
            echo -e "${YELLOW}[DRY RUN]${NC} Would add Homebrew PATH configuration"
        fi
        print_success "Homebrew PATH configured"
    fi
}

# Print next steps
print_next_steps() {
    print_header "Setup Complete!"
    
    echo -e "${GREEN}Next steps:${NC}\n"
    echo "1. Restart your terminal or run:"
    echo -e "   ${BLUE}source $SHELL_CONFIG${NC}"
    
    # Warn if user might source wrong file
    if [ "$SHELL_TYPE" = "zsh" ] && [ -f "$HOME/.bashrc" ]; then
        echo -e "\n   ${YELLOW}⚠ WARNING:${NC} You're using Zsh. Make sure to source ${BLUE}~/.zshrc${NC}"
        echo -e "   ${YELLOW}⚠ DO NOT run:${NC} source ~/.bashrc (this will cause errors!)"
    elif [ "$SHELL_TYPE" = "bash" ] && [ -f "$HOME/.zshrc" ]; then
        echo -e "\n   ${YELLOW}⚠ WARNING:${NC} You're using Bash. Make sure to source ${BLUE}~/.bashrc${NC}"
        echo -e "   ${YELLOW}⚠ DO NOT run:${NC} source ~/.zshrc (this may cause errors!)"
    fi
    echo ""
    
    echo "2. Configure your terminal font to use FiraCode Nerd Font:"
    if [ "$DETECTED_OS" = "macos" ]; then
        echo "   • iTerm2: Settings → Profiles → Default → Text → Font"
        echo "   • macOS Terminal: Settings → Profiles → Text → Font"
    fi
    echo "   • VS Code: Settings → Terminal: Font Family → 'FiraCode Nerd Font'"
    echo ""
    
    echo "3. Test your new setup:"
    echo -e "   ${BLUE}ls${NC}          # Should show icons and colors"
    echo -e "   ${BLUE}z ~${NC}         # Jump to home directory (after visiting it)"
    echo -e "   ${BLUE}tldr ls${NC}     # Show simplified help for ls"
    echo ""
    
    if [ -f "$SHELL_CONFIG.backup."* ]; then
        echo "4. If something went wrong, restore your backup:"
        echo -e "   ${BLUE}cp $SHELL_CONFIG.backup.* $SHELL_CONFIG${NC}"
        echo ""
    fi
}

# Main installation flow
main() {
    print_header "Shell Environment Setup Script"
    
    # Parse arguments
    for arg in "$@"; do
        case $arg in
            --dry-run)
                DRY_RUN=true
                print_warning "DRY RUN MODE - No changes will be made"
                ;;
        esac
    done
    
    # Detect environment
    detect_os
    detect_shell
    
    # Backup existing configuration
    backup_config
    
    # Install based on OS
    if [ "$DETECTED_OS" = "windows" ]; then
        install_winget_packages
    else
        install_homebrew
        configure_brew_path
        install_brew_packages
        install_nerd_fonts
        
        if [ "$SHELL_TYPE" = "zsh" ] && [ "$DETECTED_OS" = "macos" ]; then
            configure_zsh_plugins
        fi
    fi
    
    # Configure tools
    configure_starship
    configure_shell_integrations
    
    # Print next steps
    print_next_steps
}

# Run main function
main "$@"
