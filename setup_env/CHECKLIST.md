# Installation Checklist

Use this checklist to ensure a complete setup.

## Pre-Installation

- [ ] I have reviewed the README.md
- [ ] I have checked PLATFORM_GUIDES.md for my OS
- [ ] I have a backup of my current shell config (or script will create one)
- [ ] I understand what will be installed
- [ ] (Optional) I ran `./setup.sh --dry-run` to preview changes

## Installation

- [ ] Run `./setup.sh`
- [ ] Installation completed without errors
- [ ] Note the location of my config backup

## Post-Installation

### Shell Configuration
- [ ] Restart terminal OR run `source ~/.zshrc` (or `~/.bashrc`)
- [ ] Starship prompt is displaying
- [ ] No errors appear when opening a new terminal

### Font Configuration
- [ ] FiraCode Nerd Font is installed
- [ ] Terminal is configured to use FiraCode Nerd Font
- [ ] VS Code terminal font is set to FiraCode Nerd Font (if using VS Code)
- [ ] Icons and symbols display correctly

### Verification
- [ ] Run `./verify.sh`
- [ ] All (or most) checks pass
- [ ] Fix any failed checks if needed

## Testing Tools

### Enhanced Commands
- [ ] `ls` shows icons and colors
- [ ] `la` shows hidden files with icons
- [ ] `ll` shows detailed list view
- [ ] `bat README.md` shows syntax highlighting
- [ ] `fd setup` finds files

### Navigation
- [ ] `cd` to a few directories
- [ ] `z <directory-name>` jumps to a visited directory
- [ ] `fzf` opens fuzzy finder (Ctrl+R for history)

### Productivity Tools
- [ ] `tldr ls` shows simplified help
- [ ] Type a wrong command, then `fuck` suggests correction
- [ ] `lazygit` opens Git UI (in a git repo)
- [ ] `yazi` opens file manager

### Development Tools
- [ ] `node --version` works
- [ ] `npm --version` works
- [ ] `uv --version` works (Python)

### Starship Prompt
- [ ] Current directory shows in prompt
- [ ] Git branch shows when in a repo
- [ ] Command duration shows for long commands (>2s)
- [ ] Error indicator shows when command fails

## Customization (Optional)

- [ ] Review `~/.config/starship.toml`
- [ ] Edit `~/.zshrc` (or `~/.bashrc`) to add personal aliases
- [ ] Browse QUICK_REFERENCE.md for tips
- [ ] Set preferred `EDITOR` environment variable

## Learning

- [ ] Read QUICK_REFERENCE.md
- [ ] Try combining tools (e.g., `bat $(fd -e md | fzf)`)
- [ ] Explore tool options (`eza --help`, `bat --help`, etc.)
- [ ] Visit tool websites for advanced features

## Troubleshooting

If something doesn't work:

### Homebrew Not Found
- [ ] Add Homebrew to PATH manually (see README.md)
- [ ] Run `source ~/.zshrc` (or `~/.bashrc`)

### Commands Not Found
- [ ] Verify installation: `brew list`
- [ ] Check PATH: `echo $PATH`
- [ ] Re-run setup: `./setup.sh`

### Starship Not Loading
- [ ] Check config: `grep starship ~/.zshrc`
- [ ] Manually add: `echo 'eval "$(starship init zsh)"' >> ~/.zshrc`
- [ ] Source config: `source ~/.zshrc`

### Icons Not Showing
- [ ] Verify font: `fc-list | grep Fira` (Linux) or system Font Book (macOS)
- [ ] Set terminal font to FiraCode Nerd Font
- [ ] Restart terminal application

### Aliases Not Working
- [ ] Check if added to config: `grep "alias ls=" ~/.zshrc`
- [ ] Source config: `source ~/.zshrc`
- [ ] Check for conflicting aliases: `alias ls`

### Tools Not Integrating
- [ ] Verify init lines: `grep "zoxide init" ~/.zshrc`
- [ ] Source config: `source ~/.zshrc`
- [ ] Check tool installation: `which zoxide`

## Restore from Backup

If you need to revert:

- [ ] Find backup: `ls ~/.zshrc.backup.*`
- [ ] Copy backup: `cp ~/.zshrc.backup.YYYYMMDD_HHMMSS ~/.zshrc`
- [ ] Source config: `source ~/.zshrc`
- [ ] Uninstall packages if desired (see README.md)

## Additional Resources

- [ ] Bookmark Starship docs: https://starship.rs/
- [ ] Bookmark tool GitHub repos (see QUICK_REFERENCE.md)
- [ ] Join community discussions for tools you use
- [ ] Share your customizations!

## Success Criteria

You know the setup is complete when:

✅ Opening a terminal shows the Starship prompt
✅ `ls` displays colorful icons
✅ `z <dir>` jumps to frequently used directories
✅ All commands in verify.sh pass
✅ Icons and glyphs render correctly
✅ You can navigate and work more efficiently

---

## Quick Command Reference

Copy this to your notes for quick access:

```bash
# Installation
./setup.sh              # Install everything
./setup.sh --dry-run    # Preview changes
./verify.sh             # Verify installation

# Apply changes
source ~/.zshrc         # Reload config (Zsh)
source ~/.bashrc        # Reload config (Bash)

# Enhanced navigation
ls                      # List with icons
la                      # List all
ll                      # Long format
z <dir>                 # Smart jump
yazi                    # File manager

# File viewing
bat <file>              # Cat with syntax highlighting
fd <pattern>            # Find files

# Productivity
tldr <command>          # Quick help
fuck                    # Fix last command
lazygit                 # Git UI

# Fuzzy finding
Ctrl+R                  # Search history
Ctrl+T                  # Find files

# Package management
brew install <pkg>      # Install package
brew upgrade            # Update all
brew list               # Show installed
```

---

**Last Updated:** 2026-04-14
**Version:** 1.0
