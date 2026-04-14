# Project Structure

```
setup_env/
├── setup.sh                  # Main installation script
├── verify.sh                 # Verification script to test installation
├── README.md                 # Main documentation
├── PLATFORM_GUIDES.md        # Platform-specific installation guides
├── QUICK_REFERENCE.md        # Command reference for installed tools
└── starship.toml.example     # Example Starship configuration
```

## Files Overview

### 📜 setup.sh
**Main installation script** - Automatically detects your OS and shell, installs all dependencies, and configures your environment.

**Features:**
- Auto-detects macOS, Linux, WSL, and Windows
- Installs package managers (Homebrew/Winget)
- Installs Starship prompt and Nerd Fonts
- Installs modern CLI tools (eza, bat, fd, zoxide, fzf, etc.)
- Configures shell with aliases and integrations
- Creates timestamped backups before making changes
- Supports `--dry-run` mode

**Usage:**
```bash
./setup.sh              # Full installation
./setup.sh --dry-run    # Preview without changes
```

### ✅ verify.sh
**Verification script** - Tests that all components are properly installed and configured.

**Checks:**
- Package manager installation
- All CLI tools
- Configuration files
- Shell integrations
- Font installation
- Functional tests

**Usage:**
```bash
./verify.sh
```

### 📖 README.md
**Main documentation** - Complete guide covering:
- Features overview
- Quick start installation
- Platform support matrix
- Full list of installed tools
- Post-installation steps
- Terminal font configuration
- Troubleshooting guide
- Uninstallation instructions

### 🖥️ PLATFORM_GUIDES.md
**Platform-specific guides** for:
- macOS
- Linux (Ubuntu/Debian, Fedora, Arch)
- WSL (Windows Subsystem for Linux)
- Windows (Git Bash, PowerShell)
- Cloud environments (Codespaces, GitPod, Cloud9)
- Docker containers

Each section includes:
- Prerequisites
- Installation commands
- Platform-specific configuration
- Known limitations

### 📚 QUICK_REFERENCE.md
**Command reference** - Quick lookup for:
- All installed tools and their commands
- Keyboard shortcuts
- Common workflows
- Tool combinations
- Customization tips
- Pro tips and tricks

### 🎨 starship.toml.example
**Example Starship configuration** - Shows the prompt customization that gets downloaded, including:
- Custom format
- Language/tool integrations (Node, Python, Java, etc.)
- Git status indicators
- AWS profile display
- Custom symbols and colors

## Quick Start

### 1. Installation
```bash
# Clone or download this repository
cd setup_env

# Run the setup script
./setup.sh
```

### 2. Verification
```bash
# Test your installation
./verify.sh
```

### 3. Apply Changes
```bash
# Restart terminal or source config
source ~/.zshrc   # for Zsh
source ~/.bashrc  # for Bash
```

### 4. Read the Docs
```bash
# Main guide
cat README.md

# Quick reference
cat QUICK_REFERENCE.md

# Platform-specific info
cat PLATFORM_GUIDES.md
```

## What Gets Installed

### Package Managers
- **macOS/Linux**: Homebrew
- **Windows**: Uses Winget

### Core Tools
- **starship** - Cross-shell prompt
- **git** - Version control
- **FiraCode Nerd Font** - Font with programming ligatures

### Enhanced Commands
| Tool | Replaces | Purpose |
|------|----------|---------|
| eza | ls | File listing with icons |
| bat | cat | File viewing with syntax highlighting |
| fd | find | File searching |

### Navigation
- **zoxide** - Smart directory jumping
- **fzf** - Fuzzy finder

### Productivity
- **thefuck** - Command correction
- **tldr** - Simplified man pages
- **ncdu** - Disk usage analyzer
- **yazi** - Terminal file manager
- **lazygit** - Git UI

### Development
- **uv** - Python package manager
- **node** - JavaScript runtime
- **npm** - JavaScript package manager

### Shell Plugins (macOS Zsh)
- **zsh-syntax-highlighting**
- **zsh-autosuggestions**

## Shell Configuration

The script adds to your shell config (`~/.zshrc` or `~/.bashrc`):

1. **Starship initialization**
   ```bash
   eval "$(starship init zsh)"
   ```

2. **Homebrew PATH** (if needed)
   ```bash
   eval "$(/opt/homebrew/bin/brew shellenv)"
   ```

3. **Zsh plugins** (macOS only)
   ```bash
   source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
   source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
   ```

4. **Tool integrations**
   ```bash
   eval "$(zoxide init zsh)"
   eval "$(thefuck --alias)"
   ```

5. **Aliases**
   ```bash
   alias ls='eza --icons=auto --color=auto'
   alias cat='bat'
   alias ..='cd ..'
   # ... and more
   ```

## Safety Features

- **Automatic backups** before modifying config files
- **Dry-run mode** to preview changes
- **Detection of existing installations** to avoid duplicates
- **Non-destructive** - only appends to config files
- **Preserves existing configurations**

## Customization

After installation, customize to your needs:

### Edit aliases
```bash
nano ~/.zshrc
# Add your own aliases
source ~/.zshrc
```

### Customize Starship
```bash
nano ~/.config/starship.toml
# Modify prompt appearance
```

### Add more tools
```bash
brew search <tool>
brew install <tool>
```

## Documentation Flow

1. **Start with README.md** for overview and installation
2. **Check PLATFORM_GUIDES.md** for OS-specific steps
3. **Run verify.sh** to confirm installation
4. **Use QUICK_REFERENCE.md** as daily reference
5. **Refer to starship.toml.example** for prompt customization

## Contributing

To improve this setup:

1. Test on your platform
2. Report issues or limitations
3. Suggest additional tools
4. Share custom configurations
5. Update documentation

## Version History

- **v1.0** - Initial release
  - Cross-platform support (macOS, Linux, WSL, Windows)
  - Core tools installation
  - Shell configuration
  - Documentation suite

## Support

For issues:
1. Run `./verify.sh` to diagnose
2. Check PLATFORM_GUIDES.md for platform-specific fixes
3. Review README.md troubleshooting section
4. Check tool-specific documentation in QUICK_REFERENCE.md

## License

MIT License - Free to use and modify

## Credits

Based on guides from:
- Stamper Labs - Starship macOS Tutorial
- WFU Agentic AI - Shell Configuration Guide
