# Shell Environment Setup Script

A cross-platform setup script that configures a modern, productive terminal environment on macOS, Linux, and Windows with Starship prompt, Nerd Fonts, enhanced CLI tools, and optimized shell configuration.

## Features

### 🚀 Starship Prompt
- Cross-platform minimal, fast prompt
- Context-aware (Git, AWS, Node.js, Java, Python, etc.)
- Customizable via `starship.toml`

### 🔤 Nerd Fonts
- FiraCode Nerd Font with icon support
- Proper rendering of glyphs and symbols

### 🛠️ Modern CLI Tools
- **Enhanced commands**: `eza` (ls), `bat` (cat), `fd` (find)
- **Navigation**: `zoxide` (smart cd), `fzf` (fuzzy finder)
- **Productivity**: `thefuck`, `tldr`, `ncdu`, `yazi`, `lazygit`
- **Development**: `uv` (Python), `node` (JavaScript)

### ⚡ Shell Enhancements (macOS Zsh)
- `zsh-syntax-highlighting` - Real-time command highlighting
- `zsh-autosuggestions` - Command suggestions from history

### 🔧 Shell Configuration
- Smart aliases for common commands
- Safety aliases (confirm before overwrite/delete)
- Tool integrations (zoxide, thefuck, etc.)
- Optimized pager settings

## Quick Start

### One-Line Install

**macOS / Linux / WSL:**
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/setup.sh)"
```

Or download and run:
```bash
curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/setup.sh -o setup.sh
chmod +x setup.sh
./setup.sh
```

### Dry Run (Preview Changes)

To see what the script will do without making any changes:
```bash
./setup.sh --dry-run
```

## Platform Support

| Platform | Package Manager | Shells Supported |
|----------|----------------|------------------|
| macOS | Homebrew | Zsh, Bash |
| Linux | Homebrew (Linuxbrew) | Bash, Zsh |
| WSL | Homebrew (Linuxbrew) | Bash, Zsh |
| Windows | Winget | Git Bash |

## What Gets Installed

### Core Tools
- **Starship** - Cross-shell prompt
- **Git** - Version control

### Development Tools
- **uv** - Fast Python package manager
- **node** - JavaScript runtime
- **npm** - JavaScript package manager

### Enhanced Commands
- **eza** - Modern replacement for `ls` with icons and Git status
- **bat** - `cat` clone with syntax highlighting
- **fd** - Simple, fast `find` alternative

### Navigation & Search
- **zoxide** - Smarter `cd` that learns your habits
- **fzf** - Fuzzy finder for files and history

### Productivity Tools
- **thefuck** - Corrects mistyped commands
- **tldr** - Simplified man pages
- **ncdu** - Disk usage analyzer
- **yazi** - Terminal file manager
- **lazygit** - Terminal UI for Git

### Fonts
- **FiraCode Nerd Font** - Patched font with programming ligatures and icons

## Configuration Files Modified

The script will modify your shell configuration file:
- **Zsh**: `~/.zshrc`
- **Bash**: `~/.bashrc`

### Automatic Backups

Before making changes, the script creates a timestamped backup:
```
~/.zshrc.backup.YYYYMMDD_HHMMSS
```

To restore a backup:
```bash
cp ~/.zshrc.backup.20260414_174500 ~/.zshrc
source ~/.zshrc
```

## Post-Installation Steps

### 1. Apply Changes

Restart your terminal or run:
```bash
source ~/.zshrc   # for Zsh
source ~/.bashrc  # for Bash
```

### 2. Configure Terminal Font

Set your terminal to use **FiraCode Nerd Font**:

**iTerm2 (macOS):**
- Go to: Settings → Profiles → Default → Text → Font
- Select: "FiraCode Nerd Font"

**macOS Terminal:**
- Go to: Terminal → Settings → Profiles → Text
- Click "Change" under Font
- Select: "FiraCode Nerd Font"

**VS Code:**
- Open Settings (Cmd/Ctrl + ,)
- Search: "Terminal Font"
- Set: `FiraCode Nerd Font`

**Windows Terminal:**
```json
{
    "profiles": {
        "defaults": {
            "font": {
                "face": "FiraCode Nerd Font"
            }
        }
    }
}
```

### 3. Test Your Setup

```bash
# Test eza (enhanced ls)
ls

# Test zoxide (smart cd)
z ~          # Jump to home
z Documents  # Jump to Documents (after visiting it once)

# Test tldr (simplified man pages)
tldr ls

# Test bat (enhanced cat)
cat ~/.zshrc

# Test lazygit (Git UI)
lazygit

# Test yazi (file manager)
yazi
```

## Aliases Included

### Navigation
```bash
..      # cd ..
...     # cd ../..
c       # clear
```

### Enhanced Commands
```bash
ls      # eza --icons=auto --color=auto
la      # ls --almost-all
ll      # ls --long --time-style=relative --ignore-glob=.git
lla     # la --long --time-style=relative --ignore-glob=.git
cat     # bat (with syntax highlighting)
```

### Safety
```bash
cp      # cp -i (confirm before overwrite)
mv      # mv -i (confirm before overwrite)
rm      # rm -i (confirm before delete)
```

## Starship Configuration

The script downloads a pre-configured Starship theme from:
https://gist.github.com/sttamper/ff69056e8cb94be9397a2c5508e57018

This provides:
- AWS profile and region display
- Git branch and status
- Node.js version
- Java/Gradle versions
- Python version
- And more...

### Customize Starship

Edit the configuration:
```bash
nano ~/.config/starship.toml
```

Browse themes at: https://starship.rs/presets/

## Tool Integration Examples

### zoxide (Smart Directory Jumping)

Visit directories normally, then jump to them:
```bash
cd ~/Documents/Projects/my-app
cd ~/Downloads
# Later, jump anywhere:
z app       # Jumps to my-app
z down      # Jumps to Downloads
```

### thefuck (Command Correction)

```bash
$ apt-get install vim
E: Could not open lock file...

$ fuck
apt-get install vim → sudo apt-get install vim [enter/↑/↓/ctrl+c]
```

### fzf (Fuzzy Finding)

```bash
# Search command history
Ctrl + R

# Find and edit files
vim $(fzf)
```

## Troubleshooting

### Homebrew Not Found After Installation

Add Homebrew to your PATH:

**macOS (Zsh):**
```bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
source ~/.zshrc
```

**Linux/WSL (Bash):**
```bash
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc
source ~/.bashrc
```

### Fonts Not Displaying Correctly

1. Verify font installation:
   ```bash
   # macOS
   brew list --cask font-fira-code-nerd-font
   
   # Linux
   fc-list | grep -i "firacode"
   ```

2. Restart your terminal application

3. Ensure terminal is configured to use the font (see Post-Installation Steps)

### Starship Not Loading

Check if initialization line is in your config:
```bash
grep "starship init" ~/.zshrc
```

If missing, add it manually:
```bash
echo 'eval "$(starship init zsh)"' >> ~/.zshrc
source ~/.zshrc
```

### Zsh Plugins Not Working (macOS)

Ensure Homebrew prefix is correct:
```bash
echo $(brew --prefix)
```

If using Apple Silicon (M1/M2/M3), it should be `/opt/homebrew`

## Uninstallation

### Remove Installed Packages

```bash
brew uninstall starship eza bat fd zoxide fzf thefuck tldr ncdu yazi lazygit uv node
brew uninstall --cask font-fira-code-nerd-font

# macOS Zsh plugins
brew uninstall zsh-syntax-highlighting zsh-autosuggestions
```

### Remove Configuration

1. Restore your backup:
   ```bash
   cp ~/.zshrc.backup.YYYYMMDD_HHMMSS ~/.zshrc
   ```

2. Or manually remove the added sections from `~/.zshrc` or `~/.bashrc`

3. Remove Starship config:
   ```bash
   rm ~/.config/starship.toml
   ```

## Credits

Based on tutorials from:
- [Customizing macOS Terminal with Starship](https://dev.to/stamperlabs/customizing-macos-terminal-with-starship-like-a-pro-2geb) by Stamper Labs
- [Shell Configuration Tutorial](https://wfu-agentic-ai.github.io/workgroup/tutorials/shell-configuration.html) by WFU Agentic AI Workgroup

## License

MIT License - Feel free to use and modify as needed.

## Contributing

Issues and pull requests are welcome!
