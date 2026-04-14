# Platform-Specific Installation Guides

## macOS

### Prerequisites
- macOS 10.15 (Catalina) or later
- Command Line Tools: `xcode-select --install`

### Installation
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/setup.sh)"
```

### What Gets Installed
- ✅ Homebrew (if not already installed)
- ✅ Starship prompt
- ✅ FiraCode Nerd Font
- ✅ Zsh plugins (syntax-highlighting, autosuggestions)
- ✅ Modern CLI tools (eza, bat, fd, zoxide, fzf, etc.)

### Default Shell
macOS uses Zsh by default (since Catalina). Config file: `~/.zshrc`

---

## Linux (Ubuntu/Debian)

### Prerequisites
```bash
sudo apt-get update
sudo apt-get install build-essential curl git
```

### Installation
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/setup.sh)"
```

### What Gets Installed
- ✅ Homebrew (Linuxbrew)
- ✅ Starship prompt
- ✅ FiraCode Nerd Font
- ✅ Modern CLI tools

### Font Installation Note
On Linux, fonts are installed to `~/.local/share/fonts/`. After installation, configure your terminal emulator to use "FiraCode Nerd Font".

### Popular Terminal Emulators
- **GNOME Terminal**: Edit → Preferences → Profiles → Font
- **Konsole**: Settings → Edit Current Profile → Appearance → Font
- **Alacritty**: Edit `~/.config/alacritty/alacritty.yml`
  ```yaml
  font:
    normal:
      family: "FiraCode Nerd Font"
  ```

---

## Linux (Fedora/RHEL/CentOS)

### Prerequisites
```bash
sudo dnf groupinstall "Development Tools"
sudo dnf install curl git
```

### Installation
Same as Ubuntu/Debian above.

---

## Linux (Arch)

### Prerequisites
```bash
sudo pacman -S base-devel curl git
```

### Installation
Same as Ubuntu/Debian above.

---

## Windows Subsystem for Linux (WSL)

### Prerequisites
1. Install WSL 2: https://docs.microsoft.com/en-us/windows/wsl/install
2. Install Ubuntu from Microsoft Store
3. Inside WSL:
   ```bash
   sudo apt-get update
   sudo apt-get install build-essential curl git
   ```

### Installation
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/setup.sh)"
```

### What Gets Installed
- ✅ Homebrew (Linuxbrew)
- ✅ Starship prompt
- ✅ FiraCode Nerd Font
- ✅ Modern CLI tools

### Windows Terminal Configuration
1. Install FiraCode Nerd Font on Windows (not just WSL)
2. Download from: https://github.com/ryanoasis/nerd-fonts/releases
3. Install the `.ttf` files on Windows
4. Configure Windows Terminal:

Open: `settings.json`
```json
{
    "profiles": {
        "defaults": {
            "font": {
                "face": "FiraCode Nerd Font",
                "size": 11
            }
        }
    }
}
```

### VS Code with WSL
1. Install "Remote - WSL" extension
2. Open folder in WSL: `Ctrl+Shift+P` → "WSL: Open Folder in WSL"
3. Terminal will use WSL with your configured setup

---

## Windows (Git Bash - Limited Support)

### Prerequisites
1. Install Git for Windows: https://git-scm.com/download/win
2. Install Winget (comes with Windows 11, or from Microsoft Store)

### Installation
```bash
./setup.sh
```

### What Gets Installed
- ✅ Starship via Winget
- ✅ Git
- ⚠️ Limited CLI tools support

### Limitations
- Not all Homebrew packages available
- Winget has fewer packages than Homebrew
- Some Unix tools may not work properly

### Recommended Alternative
**Use WSL instead** for full Linux compatibility and access to all tools.

---

## Windows (PowerShell - Alternative)

For PowerShell users, consider using:
- **Oh My Posh**: https://ohmyposh.dev/
- **Scoop**: https://scoop.sh/ (package manager)

### Quick Setup
```powershell
# Install Scoop
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
irm get.scoop.sh | iex

# Install tools
scoop install starship git
oh-my-posh font install
```

Add to PowerShell profile:
```powershell
Invoke-Expression (&starship init powershell)
```

---

## Cloud Development Environments

### GitHub Codespaces
The setup script works in Codespaces:
```bash
curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/setup.sh | bash
```

### GitPod
Add to `.gitpod.yml`:
```yaml
tasks:
  - init: |
      curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/setup.sh | bash
      source ~/.bashrc
```

### AWS Cloud9
Works out of the box with Bash configuration.

---

## Docker Containers

Create a Dockerfile with the setup:

```dockerfile
FROM ubuntu:22.04

# Install prerequisites
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    sudo

# Create non-root user
RUN useradd -m -s /bin/bash dev && \
    echo "dev ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER dev
WORKDIR /home/dev

# Run setup script
RUN curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/setup.sh | bash

# Source config in interactive shells
RUN echo 'source ~/.bashrc' >> ~/.bash_profile

CMD ["/bin/bash", "-l"]
```

Build and run:
```bash
docker build -t dev-env .
docker run -it dev-env
```

---

## Verification

After installation on any platform, verify with:

```bash
# Check installations
command -v starship
command -v eza
command -v bat
command -v zoxide

# Test prompt
starship --version

# Test enhanced ls
ls -la

# Check font rendering (should show icons)
eza --icons

# Verify shell config loaded
source ~/.zshrc  # or ~/.bashrc
```

Expected output: No errors, icons display correctly, prompt shows Starship theme.
