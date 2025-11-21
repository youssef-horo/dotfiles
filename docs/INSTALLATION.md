# Installation Guide

## Prerequisites

### macOS

Install Homebrew (recommended):

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Debian/Ubuntu

Update package list and install zsh:

```bash
sudo apt-get update
sudo apt-get install -y zsh git curl
```

### RedHat/CentOS/Fedora

Install zsh:

```bash
# For Fedora/RHEL 8+
sudo dnf install -y zsh git curl

# For CentOS 7/RHEL 7
sudo yum install -y zsh git curl
```

## Installation

### Automatic Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/youssef-horo/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

2. Run the installation script:
   ```bash
   ./install.sh
   ```

3. Reload your shell:
   ```bash
   source ~/.zshrc
   ```

### Manual Installation

1. **Install oh-my-zsh** (if not already installed):
   ```bash
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
   ```

2. **Symlink zshrc**:
   ```bash
   # Backup existing .zshrc if needed
   mv ~/.zshrc ~/.zshrc.backup 2>/dev/null || true
   
   # Create symlink
   ln -s ~/dotfiles/zsh/.zshrc ~/.zshrc
   ```

3. **If using oh-my-zsh custom plugins/themes**, symlink them:
   ```bash
   ln -s ~/dotfiles/zsh/custom/plugins ~/.oh-my-zsh/custom/plugins
   ln -s ~/dotfiles/zsh/custom/themes ~/.oh-my-zsh/custom/themes
   ```

4. **Reload zsh configuration**:
   ```bash
   source ~/.zshrc
   ```

## Package Installation

### macOS (Homebrew)

```bash
brew install git kubectl kustomize docker node npm
```

### Debian/Ubuntu (apt)

```bash
sudo apt-get install -y git kubectl kustomize docker.io nodejs npm
```

### RedHat/CentOS/Fedora (dnf/yum)

```bash
# Fedora/RHEL 8+
sudo dnf install -y git kubectl kustomize docker nodejs npm

# CentOS 7/RHEL 7
sudo yum install -y git kubectl kustomize docker nodejs npm
```

## Scripts

Add scripts directory to PATH in your `.zshrc` (if not already added):

```zsh
export PATH="$PATH:$HOME/dotfiles/scripts"
```

## Troubleshooting

### Installation fails

- Make sure zsh is installed: `which zsh`
- Check if oh-my-zsh is installed: `ls ~/.oh-my-zsh`
- Verify script permissions: `chmod +x install.sh`

### Platform not detected correctly

- Check platform detection: `./scripts/detect-platform.sh`
- Verify `/etc/os-release` exists (Linux)
- Check `$OSTYPE` variable (macOS)

### Symlinks not working

- Check if symlink exists: `ls -la ~/.zshrc`
- Remove broken symlink: `rm ~/.zshrc`
- Re-run installation script

