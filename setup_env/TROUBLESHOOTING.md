# Troubleshooting Guide

## Common Issues and Solutions

### 🔴 Error: "command not found: shopt"

**Symptom:**
```
(eval):140: command not found: shopt
```

**Cause:**
You're running **Zsh** but trying to source a **Bash** configuration file (`.bashrc`). The `shopt` command is Bash-specific and doesn't exist in Zsh.

**Solution:**
Use the correct config file for your shell:

```bash
# Check your shell
echo $SHELL

# If it shows /bin/zsh or /usr/bin/zsh:
source ~/.zshrc

# If it shows /bin/bash or /usr/bin/bash:
source ~/.bashrc
```

**Quick fix for Zsh users:**
```bash
source ~/.zshrc
```

**Prevention:**
The setup script should automatically detect your shell. If you see this error, it means you manually tried to source the wrong file.

---

### 🔴 Commands Not Found After Installation

**Symptom:**
```
zsh: command not found: starship
zsh: command not found: eza
```

**Cause:**
The shell configuration hasn't been loaded yet, or Homebrew isn't in your PATH.

**Solution 1: Reload your shell config**
```bash
source ~/.zshrc   # for Zsh
source ~/.bashrc  # for Bash
```

**Solution 2: Add Homebrew to PATH manually**

For Zsh (macOS):
```bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
source ~/.zshrc
```

For Bash (Linux/WSL):
```bash
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc
source ~/.bashrc
```

**Solution 3: Verify Homebrew installation**
```bash
/opt/homebrew/bin/brew --version  # macOS
/home/linuxbrew/.linuxbrew/bin/brew --version  # Linux
```

---

### 🔴 Icons Showing as Boxes or Question Marks

**Symptom:**
Icons appear as `?`, `□`, or other placeholder characters instead of proper icons.

**Cause:**
Your terminal isn't using a Nerd Font.

**Solution:**

**macOS Terminal:**
1. Open Terminal → Settings (Cmd+,)
2. Select Profiles tab
3. Click Text
4. Click "Change" under Font
5. Search for "FiraCode Nerd Font"
6. Select it and close preferences
7. Restart Terminal

**iTerm2:**
1. Open iTerm2 → Settings (Cmd+,)
2. Go to Profiles → Default → Text
3. Click "Change Font" under Font
4. Search for "FiraCode Nerd Font"
5. Select Regular or Retina
6. Close and restart iTerm2

**VS Code:**
1. Open Settings (Cmd+, or Ctrl+,)
2. Search for "Terminal Font"
3. Set `Terminal › Integrated: Font Family` to `FiraCode Nerd Font`
4. Restart VS Code

**Verify font is installed:**
```bash
# macOS
system_profiler SPFontsDataType | grep -i "firacode"

# Linux
fc-list | grep -i "firacode"
```

---

### 🔴 Starship Prompt Not Showing

**Symptom:**
Terminal shows default prompt instead of Starship.

**Cause:**
Starship initialization line is missing or not being executed.

**Solution:**

**Check if Starship is configured:**
```bash
grep "starship init" ~/.zshrc  # or ~/.bashrc
```

**If nothing appears, add it manually:**

For Zsh:
```bash
echo 'eval "$(starship init zsh)"' >> ~/.zshrc
source ~/.zshrc
```

For Bash:
```bash
echo 'eval "$(starship init bash)"' >> ~/.bashrc
source ~/.bashrc
```

**Verify Starship is installed:**
```bash
starship --version
```

**Test Starship manually:**
```bash
starship prompt
```

---

### 🔴 Homebrew Not Found

**Symptom:**
```
brew: command not found
```

**Cause:**
Homebrew isn't installed or isn't in your PATH.

**Solution 1: Check if Homebrew is installed**

macOS:
```bash
ls /opt/homebrew/bin/brew
```

Linux/WSL:
```bash
ls /home/linuxbrew/.linuxbrew/bin/brew
```

**Solution 2: Install Homebrew**
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

**Solution 3: Add to PATH**

macOS (Zsh):
```bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
source ~/.zshrc
```

Linux/WSL (Bash):
```bash
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc
source ~/.bashrc
```

---

### 🔴 zoxide Not Working ("z" Command Not Found)

**Symptom:**
```
zsh: command not found: z
```

**Cause:**
zoxide isn't initialized in your shell config.

**Solution:**

**Check if configured:**
```bash
grep "zoxide init" ~/.zshrc  # or ~/.bashrc
```

**Add manually if missing:**

For Zsh:
```bash
echo 'eval "$(zoxide init zsh)"' >> ~/.zshrc
source ~/.zshrc
```

For Bash:
```bash
echo 'eval "$(zoxide init bash)"' >> ~/.bashrc
source ~/.bashrc
```

**Note:** zoxide needs to "learn" directories first. Use `cd` to visit directories normally, then `z` will work:
```bash
cd ~/Documents
cd ~/Projects
# Now you can use:
z doc    # jumps to Documents
z proj   # jumps to Projects
```

---

### 🔴 thefuck Alias Not Working

**Symptom:**
```
zsh: command not found: fuck
```

**Cause:**
thefuck isn't configured in your shell config.

**Solution:**

**Check if configured:**
```bash
grep "thefuck" ~/.zshrc  # or ~/.bashrc
```

**Add manually:**

For Zsh:
```bash
echo 'eval "$(thefuck --alias)"' >> ~/.zshrc
source ~/.zshrc
```

For Bash:
```bash
echo 'eval "$(thefuck --alias)"' >> ~/.bashrc
source ~/.bashrc
```

**Test it:**
```bash
apt install vim  # Wrong command (no sudo)
fuck             # Should suggest: sudo apt install vim
```

---

### 🔴 Aliases Not Working (ls Still Shows Default Output)

**Symptom:**
`ls` command shows default output without icons.

**Cause:**
Aliases haven't been loaded or eza isn't installed.

**Solution:**

**Check if eza is installed:**
```bash
which eza
eza --version
```

**Check if alias is configured:**
```bash
alias ls
# Should show: ls='eza --icons=auto --color=auto'
```

**If not configured, add manually:**
```bash
echo "alias ls='eza --icons=auto --color=auto'" >> ~/.zshrc
source ~/.zshrc
```

**Bypass alias temporarily to see default ls:**
```bash
\ls
# or
command ls
```

---

### 🔴 Need to Revert All Changes

**Symptom:**
Want to undo everything and go back to original configuration.

**Solution:**

**Find your backup:**
```bash
ls -la ~/.zshrc.backup.* ~/.bashrc.backup.*
```

**Restore from backup:**
```bash
# Find the backup file with the timestamp you want
cp ~/.zshrc.backup.20260414_105530 ~/.zshrc
source ~/.zshrc
```

**Uninstall packages:**
```bash
brew uninstall starship eza bat fd zoxide fzf thefuck tldr ncdu yazi lazygit uv node
brew uninstall --cask font-fira-code-nerd-font
```

**Remove Starship config:**
```bash
rm ~/.config/starship.toml
```

---

### 🔴 Permission Denied Errors

**Symptom:**
```
Permission denied
```

**Solution:**

**For Homebrew installation:**
- Don't use `sudo` with Homebrew commands
- Homebrew should install to user directories

**For script execution:**
```bash
chmod +x setup.sh
chmod +x verify.sh
./setup.sh
```

**For file editing:**
```bash
# Ensure you own your config files
ls -la ~/.zshrc ~/.bashrc
# Should show your username
```

---

## Getting More Help

### Run Verification Script
```bash
./verify.sh
```

This will check all installations and configurations and report what's working and what needs fixing.

### Check Tool Documentation

Each tool has detailed documentation:

- **Starship**: https://starship.rs/
- **eza**: https://github.com/eza-community/eza
- **bat**: https://github.com/sharkdp/bat
- **zoxide**: https://github.com/ajeetdsouza/zoxide
- **fzf**: https://github.com/junegunn/fzf
- **Homebrew**: https://docs.brew.sh/

### Debug Steps

1. Run `./verify.sh` to see what's working
2. Check your shell: `echo $SHELL`
3. Verify config file: `cat ~/.zshrc` or `cat ~/.bashrc`
4. Check PATH: `echo $PATH`
5. Test individual tools: `starship --version`, `eza --version`, etc.
6. Review recent changes: `tail -50 ~/.zshrc`

---

**Still stuck?** Check the README.md for more information or review your shell configuration files.
