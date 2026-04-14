# Quick Reference Guide

Essential commands and tips for your newly configured terminal environment.

## 📁 Enhanced Navigation

### eza (better ls)
```bash
ls              # List with icons and colors
la              # List all (including hidden)
ll              # Long format with details
lla             # Long format + hidden files
eza --tree      # Tree view
eza -l --git    # Show git status
```

### zoxide (smart cd)
```bash
z <partial>     # Jump to frequently used directory
z foo           # Jump to directory matching "foo"
zi              # Interactive selection with fzf
zoxide query    # Show database
zoxide remove   # Remove path from database
```

**Pro tip**: Just use directories normally first, then zoxide learns your patterns!

### yazi (file manager)
```bash
yazi            # Launch file manager
y               # Navigate
Enter           # Open file/directory
q               # Quit
```

## 📝 Better File Viewing

### bat (better cat)
```bash
bat file.txt           # View with syntax highlighting
bat -A file.txt        # Show non-printable characters
bat -p file.txt        # Plain output (no line numbers)
bat --language=json    # Force language
bat file1 file2 file3  # View multiple files
```

### fd (better find)
```bash
fd pattern              # Find files/directories
fd -e txt              # Find by extension
fd -H pattern          # Include hidden files
fd -t f pattern        # Only files
fd -t d pattern        # Only directories
fd -x cmd              # Execute command on results
```

## 🔍 Fuzzy Finding

### fzf
```bash
Ctrl+R              # Search command history
Ctrl+T              # Search files in current directory
Alt+C               # cd into selected directory

# Use in commands
vim $(fzf)          # Select file to edit
cd $(fd -t d | fzf) # Select directory to cd into
kill -9 $(ps aux | fzf | awk '{print $2}')  # Select process to kill
```

## 🔧 Productivity

### tldr (simplified man pages)
```bash
tldr ls             # Quick examples for ls
tldr tar            # Quick examples for tar
tldr --update       # Update cache
tldr --list         # List all pages
```

### thefuck
```bash
# Just type command wrong
apt install vim
# Command 'apt' not found

# Then type:
fuck
# Suggests: sudo apt install vim
```

### ncdu (disk usage)
```bash
ncdu                # Analyze current directory
ncdu /              # Analyze root
ncdu ~              # Analyze home

# Inside ncdu:
# ↑↓ - Navigate
# Enter - Open directory
# d - Delete
# q - Quit
```

## 🌳 Git

### lazygit (Git UI)
```bash
lazygit             # Launch in current repo

# Inside lazygit:
# 1-5 - Switch panels
# Enter - View details
# Space - Stage/unstage
# c - Commit
# P - Push
# p - Pull
# q - Quit
```

### Git aliases (if configured)
```bash
git status          # Check status
git add .           # Stage all
git commit -m "msg" # Commit
git push            # Push to remote
```

## ⚡ Starship Prompt Features

Your prompt automatically shows:

- 📁 Current directory
- 🌿 Git branch and status
- 🐍 Python version (in Python projects)
- 📦 Node.js version (in Node projects)
- ☕ Java version (in Java projects)
- ☁️ AWS profile (if set)
- ⚡ Command duration (if > 2s)
- ❌ Error indicator (if last command failed)

### Customize Starship
```bash
nano ~/.config/starship.toml    # Edit config
starship config                 # Show config location
starship preset                 # List available presets
```

## 🔑 Aliases Reference

### Navigation
```bash
..          # cd ..
...         # cd ../..
c           # clear
```

### Safety
```bash
cp file     # Prompts before overwrite
mv file     # Prompts before overwrite
rm file     # Prompts before delete
```

## 🐍 Python (uv)

```bash
uv venv                    # Create virtual environment
source .venv/bin/activate  # Activate (macOS/Linux)
uv pip install package     # Install package
uv pip freeze             # List installed packages
uv run script.py          # Run in project environment
```

## 📦 Node.js (npm)

```bash
npm init                # Initialize project
npm install package     # Install package
npm install -g package  # Install globally
npm run script         # Run package.json script
npx command            # Execute package binary
```

## 🍺 Homebrew

```bash
brew install package       # Install package
brew install --cask app    # Install GUI app
brew update               # Update Homebrew
brew upgrade              # Upgrade all packages
brew search query         # Search for packages
brew info package         # Show package info
brew list                 # List installed packages
brew uninstall package    # Remove package
brew cleanup             # Remove old versions
brew doctor              # Check for issues
```

## 🎨 Shell Customization

### Add your own aliases
```bash
nano ~/.zshrc    # or ~/.bashrc

# Add lines like:
alias gst='git status'
alias python='python3'
alias ll='ls -lah'

# Save and apply:
source ~/.zshrc
```

### Add to PATH
```bash
nano ~/.zshrc

# Add:
export PATH="$HOME/bin:$PATH"

# Apply:
source ~/.zshrc
```

### Set environment variables
```bash
nano ~/.zshrc

# Add:
export EDITOR="code"
export GITHUB_TOKEN="your_token"

# Apply:
source ~/.zshrc
```

## 🔄 Keep System Updated

```bash
# Update everything
brew update && brew upgrade

# Update tldr database
tldr --update

# Update uv
uv self-update

# Update npm
npm install -g npm@latest
```

## 🆘 Troubleshooting

### Reload configuration
```bash
source ~/.zshrc     # Zsh
source ~/.bashrc    # Bash
```

### Clear shell cache
```bash
hash -r            # Clear command cache
rehash             # Rebuild command hash table (Zsh)
```

### Check what a command actually runs
```bash
which ls           # Show path to ls
type ls            # Show if it's alias/function/file
command -v ls      # POSIX-compliant version
```

### Temporarily bypass an alias
```bash
\ls                # Run actual ls, not alias
command ls         # Same effect
```

### Debug shell startup
```bash
zsh -x             # Start Zsh with trace
bash -x            # Start Bash with trace
```

## 📚 Learn More

- Starship: https://starship.rs/
- eza: https://github.com/eza-community/eza
- bat: https://github.com/sharkdp/bat
- fd: https://github.com/sharkdp/fd
- zoxide: https://github.com/ajeetdsouza/zoxide
- fzf: https://github.com/junegunn/fzf
- lazygit: https://github.com/jesseduffield/lazygit
- uv: https://github.com/astral-sh/uv

## 💡 Pro Tips

1. **Use `z` instead of `cd`** - After a few directory visits, `z proj` beats `cd ~/Documents/Projects/my-project`

2. **Pipe to fzf** - Any list becomes searchable:
   ```bash
   history | fzf
   git branch | fzf
   ```

3. **Combine tools**:
   ```bash
   bat $(fd -e md | fzf)              # Find and view markdown
   cd $(z -l | fzf | awk '{print $2}')  # Interactive zoxide
   ```

4. **Use tldr first, man second** - `tldr` gives examples, `man` gives details

5. **Customize Starship** - Make it yours! Edit `~/.config/starship.toml`

6. **Create project-specific aliases** - Add them to `~/.zshrc`

7. **Use `bat` as your MANPAGER** - Already configured! Man pages with syntax highlighting.

8. **Leverage Git integrations** - `eza --git` and Starship show git status automatically

## 🎯 Common Workflows

### Starting a new Python project
```bash
z projects           # Jump to projects dir
mkdir myproject && cd myproject
uv venv             # Create virtual environment
source .venv/bin/activate
uv pip install ...
```

### Finding and editing files
```bash
fd config.json      # Find the file
vim $(fd config.json | fzf)  # Select and edit
# or
bat $(fd -e json | fzf)      # View JSON files
```

### Git workflow
```bash
lazygit            # Visual Git interface
# or traditional:
git status
git add .
git commit -m "message"
git push
```

Enjoy your enhanced terminal! 🚀
