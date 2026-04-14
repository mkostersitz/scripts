#!/bin/bash

# Installation Verification Script
# Tests that all components are properly installed and configured

set -e

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

PASSED=0
FAILED=0

print_header() {
    echo -e "\n${BLUE}═══════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  $1${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}\n"
}

check_command() {
    local cmd=$1
    local name=${2:-$1}
    
    if command -v "$cmd" &> /dev/null; then
        local version=$($cmd --version 2>&1 | head -n 1)
        echo -e "${GREEN}✓${NC} $name installed: $version"
        ((PASSED++))
        return 0
    else
        echo -e "${RED}✗${NC} $name not found"
        ((FAILED++))
        return 1
    fi
}

check_file() {
    local file=$1
    local name=$2
    
    if [ -f "$file" ]; then
        echo -e "${GREEN}✓${NC} $name exists: $file"
        ((PASSED++))
        return 0
    else
        echo -e "${RED}✗${NC} $name not found: $file"
        ((FAILED++))
        return 1
    fi
}

check_in_file() {
    local file=$1
    local pattern=$2
    local name=$3
    
    if [ ! -f "$file" ]; then
        echo -e "${RED}✗${NC} $name - file not found: $file"
        ((FAILED++))
        return 1
    fi
    
    if grep -q "$pattern" "$file" 2>/dev/null; then
        echo -e "${GREEN}✓${NC} $name configured in $file"
        ((PASSED++))
        return 0
    else
        echo -e "${RED}✗${NC} $name not configured in $file"
        ((FAILED++))
        return 1
    fi
}

check_font() {
    local os_type=$(uname)
    
    if [ "$os_type" = "Darwin" ]; then
        # macOS
        if system_profiler SPFontsDataType 2>/dev/null | grep -qi "FiraCode Nerd Font"; then
            echo -e "${GREEN}✓${NC} FiraCode Nerd Font installed"
            ((PASSED++))
            return 0
        else
            echo -e "${YELLOW}⚠${NC} FiraCode Nerd Font may not be installed (check manually)"
            return 0
        fi
    elif [ "$os_type" = "Linux" ]; then
        # Linux
        if fc-list 2>/dev/null | grep -qi "FiraCode Nerd Font"; then
            echo -e "${GREEN}✓${NC} FiraCode Nerd Font installed"
            ((PASSED++))
            return 0
        else
            echo -e "${RED}✗${NC} FiraCode Nerd Font not found"
            ((FAILED++))
            return 1
        fi
    else
        echo -e "${YELLOW}⚠${NC} Font check not supported on this platform"
        return 0
    fi
}

main() {
    print_header "Shell Environment Verification"
    
    echo "Checking installation on: $(uname -s)"
    echo "Current shell: $SHELL"
    echo ""
    
    # Determine shell config based on user's default shell (not the script's shell)
    SHELL_CONFIG=""
    SHELL_TYPE=$(basename "$SHELL")
    
    if [ "$SHELL_TYPE" = "zsh" ]; then
        SHELL_CONFIG="$HOME/.zshrc"
        echo "Detected default shell: Zsh"
    elif [ "$SHELL_TYPE" = "bash" ]; then
        SHELL_CONFIG="$HOME/.bashrc"
        echo "Detected default shell: Bash"
    else
        # Fallback: try to detect from existing files
        if [ -f "$HOME/.zshrc" ] && [ ! -f "$HOME/.bashrc" ]; then
            SHELL_CONFIG="$HOME/.zshrc"
            echo "Detected default shell: Zsh (from config file)"
        elif [ -f "$HOME/.bashrc" ]; then
            SHELL_CONFIG="$HOME/.bashrc"
            echo "Detected default shell: Bash (from config file)"
        else
            SHELL_CONFIG="$HOME/.bashrc"
            echo "Unknown shell, defaulting to Bash"
        fi
    fi
    
    echo "Using config file: $SHELL_CONFIG"
    echo ""
    
    print_header "Package Manager"
    check_command "brew" "Homebrew"
    
    print_header "Core Tools"
    check_command "starship" "Starship"
    check_command "git" "Git"
    
    print_header "Development Tools"
    check_command "uv" "uv (Python package manager)"
    check_command "node" "Node.js"
    check_command "npm" "npm"
    
    print_header "Enhanced Commands"
    check_command "eza" "eza (modern ls)"
    check_command "bat" "bat (modern cat)"
    check_command "fd" "fd (modern find)"
    
    print_header "Navigation & Search"
    check_command "zoxide" "zoxide"
    check_command "fzf" "fzf"
    
    print_header "Productivity Tools"
    check_command "thefuck" "thefuck"
    check_command "tldr" "tldr"
    check_command "ncdu" "ncdu"
    check_command "yazi" "yazi"
    check_command "lazygit" "lazygit"
    
    print_header "Configuration Files"
    check_file "$SHELL_CONFIG" "Shell config"
    check_file "$HOME/.config/starship.toml" "Starship config"
    
    print_header "Shell Configuration"
    check_in_file "$SHELL_CONFIG" "starship init" "Starship initialization"
    check_in_file "$SHELL_CONFIG" "zoxide init" "zoxide initialization"
    check_in_file "$SHELL_CONFIG" "thefuck --alias" "thefuck alias"
    check_in_file "$SHELL_CONFIG" "alias ls=" "eza alias"
    
    print_header "Fonts"
    check_font
    
    print_header "Testing Functionality"
    
    # Test starship
    if command -v starship &> /dev/null; then
        if starship prompt &> /dev/null; then
            echo -e "${GREEN}✓${NC} Starship prompt renders correctly"
            ((PASSED++))
        else
            echo -e "${RED}✗${NC} Starship prompt failed"
            ((FAILED++))
        fi
    fi
    
    # Test eza icons (basic check)
    if command -v eza &> /dev/null; then
        if eza --icons / &> /dev/null; then
            echo -e "${GREEN}✓${NC} eza can render icons"
            ((PASSED++))
        else
            echo -e "${YELLOW}⚠${NC} eza icons might not render (check font in terminal)"
        fi
    fi
    
    # Test zoxide database
    if command -v zoxide &> /dev/null; then
        if [ -f "$HOME/.local/share/zoxide/db.zo" ] || zoxide query --list &> /dev/null; then
            echo -e "${GREEN}✓${NC} zoxide database exists"
            ((PASSED++))
        else
            echo -e "${YELLOW}⚠${NC} zoxide database empty (visit directories to populate)"
        fi
    fi
    
    # Test bat syntax highlighting
    if command -v bat &> /dev/null; then
        if echo "print('hello')" | bat -l python &> /dev/null; then
            echo -e "${GREEN}✓${NC} bat syntax highlighting works"
            ((PASSED++))
        else
            echo -e "${RED}✗${NC} bat syntax highlighting failed"
            ((FAILED++))
        fi
    fi
    
    print_header "Summary"
    
    local total=$((PASSED + FAILED))
    local percentage=0
    if [ $total -gt 0 ]; then
        percentage=$((PASSED * 100 / total))
    fi
    
    echo -e "Total Checks: $total"
    echo -e "${GREEN}Passed: $PASSED${NC}"
    echo -e "${RED}Failed: $FAILED${NC}"
    echo -e "Success Rate: ${percentage}%"
    echo ""
    
    if [ $FAILED -eq 0 ]; then
        echo -e "${GREEN}🎉 All checks passed! Your environment is properly configured.${NC}"
        echo ""
        echo "Next steps:"
        echo "1. Restart your terminal or run: source $SHELL_CONFIG"
        echo "2. Configure your terminal font to 'FiraCode Nerd Font'"
        echo "3. Try: ls, z ~, tldr ls, bat $SHELL_CONFIG"
    else
        echo -e "${YELLOW}⚠️ Some checks failed. Review the output above.${NC}"
        echo ""
        echo "Common fixes:"
        echo "1. Source your shell config: source $SHELL_CONFIG"
        echo "2. Ensure Homebrew is in PATH"
        echo "3. Re-run the setup script: ./setup.sh"
    fi
    
    echo ""
}

main "$@"
