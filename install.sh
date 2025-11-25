#!/bin/bash

# Installation script for dotfiles
# Supports macOS, Debian/Ubuntu, and RedHat/CentOS/Fedora

# Allow CI mode (set CI=1 to skip interactive parts)
CI_MODE="${CI:-0}"

# Don't exit on error in CI mode (for testing)
if [[ "$CI_MODE" == "1" ]]; then
    set +e
else
set -e
fi

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ZSH_RC="$HOME/.zshrc"
ZSH_RC_BACKUP="$HOME/.zshrc.backup.$(date +%Y%m%d_%H%M%S)"

# Source platform detection
source "$DOTFILES_DIR/scripts/detect-platform.sh"

PLATFORM_INFO=$(detect_platform)
OS=$(echo "$PLATFORM_INFO" | cut -d: -f1)
PKG_MANAGER=$(echo "$PLATFORM_INFO" | cut -d: -f2)

echo "Installing dotfiles from $DOTFILES_DIR"
echo "Detected OS: $OS"
echo "Package manager: $PKG_MANAGER"
echo ""

# Install Homebrew on all platforms if not present
if ! command -v brew &> /dev/null; then
    echo "Homebrew not found. Installing..."
    if [[ "$OS" == "macos" ]]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        # Add Homebrew to PATH (for Apple Silicon)
        if [[ -d "/opt/homebrew" ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        elif [[ -d "/usr/local/Homebrew" ]]; then
            eval "$(/usr/local/bin/brew shellenv)"
        fi
    else
        # Install Homebrew on Linux
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        # Add Homebrew to PATH for Linux
        if [[ -d "$HOME/.linuxbrew" ]]; then
            eval "$($HOME/.linuxbrew/bin/brew shellenv)"
        elif [[ -d "/home/linuxbrew/.linuxbrew" ]]; then
            eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        fi
    fi
    
    # Add to shell profile for persistence
    if [[ -f "$HOME/.zshrc" ]]; then
        if ! grep -q "brew shellenv" "$HOME/.zshrc"; then
            if [[ "$OS" == "macos" ]]; then
                if [[ -d "/opt/homebrew" ]]; then
                    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zshrc"
                elif [[ -d "/usr/local/Homebrew" ]]; then
                    echo 'eval "$(/usr/local/bin/brew shellenv)"' >> "$HOME/.zshrc"
                fi
            else
                if [[ -d "$HOME/.linuxbrew" ]]; then
                    echo 'eval "$($HOME/.linuxbrew/bin/brew shellenv)"' >> "$HOME/.zshrc"
                elif [[ -d "/home/linuxbrew/.linuxbrew" ]]; then
                    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> "$HOME/.zshrc"
                fi
            fi
        fi
    fi
else
    echo "Homebrew is already installed"
fi

# Install zsh if not present (Linux only)
if [[ "$OS" != "macos" ]]; then
    if ! command -v zsh &> /dev/null; then
        echo "zsh not found. Installing..."
        case "$PKG_MANAGER" in
            apt)
                if [[ "$CI_MODE" == "1" ]]; then
                    sudo apt-get update && sudo apt-get install -y zsh || echo "Failed to install zsh (non-fatal in CI)"
                else
                    sudo apt-get update && sudo apt-get install -y zsh
                fi
                ;;
            dnf)
                if [[ "$CI_MODE" == "1" ]]; then
                    sudo dnf install -y zsh || echo "Failed to install zsh (non-fatal in CI)"
                else
                    sudo dnf install -y zsh
                fi
                ;;
            yum)
                if [[ "$CI_MODE" == "1" ]]; then
                    sudo yum install -y zsh || echo "Failed to install zsh (non-fatal in CI)"
                else
                    sudo yum install -y zsh
                fi
                ;;
            *)
                echo "Warning: Could not detect package manager. Please install zsh manually."
                ;;
        esac
    fi
fi

# Check if oh-my-zsh is installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "oh-my-zsh not found. Installing..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Backup existing .zshrc if it exists and is not already a symlink
if [ -f "$ZSH_RC" ] && [ ! -L "$ZSH_RC" ]; then
    echo "Backing up existing .zshrc to $ZSH_RC_BACKUP"
    mv "$ZSH_RC" "$ZSH_RC_BACKUP"
fi

# Create symlink for .zshrc
if [ ! -L "$ZSH_RC" ]; then
    echo "Creating symlink for .zshrc"
    ln -s "$DOTFILES_DIR/zsh/.zshrc" "$ZSH_RC"
else
    echo ".zshrc is already a symlink, skipping"
fi

# Create symlinks for custom plugins/themes directories
# Always create symlinks even if directories are empty (for future use)
if [ -d "$DOTFILES_DIR/zsh/custom/plugins" ]; then
    if [ ! -L "$HOME/.oh-my-zsh/custom/plugins" ] && [ ! -d "$HOME/.oh-my-zsh/custom/plugins" ]; then
        echo "Creating symlink for custom plugins"
        mkdir -p "$HOME/.oh-my-zsh/custom"
        ln -s "$DOTFILES_DIR/zsh/custom/plugins" "$HOME/.oh-my-zsh/custom/plugins"
    fi
fi

# Always create symlink for custom themes directory (even if empty)
# This ensures the directory structure is ready for future themes
if [ -d "$DOTFILES_DIR/zsh/custom/themes" ]; then
    if [ ! -L "$HOME/.oh-my-zsh/custom/themes" ] && [ ! -d "$HOME/.oh-my-zsh/custom/themes" ]; then
        echo "Creating symlink for custom themes"
        mkdir -p "$HOME/.oh-my-zsh/custom"
        ln -s "$DOTFILES_DIR/zsh/custom/themes" "$HOME/.oh-my-zsh/custom/themes"
    fi
fi

# Install packages from Brewfile (works on all platforms)
echo ""
echo "Installing packages from Brewfile..."
if command -v brew &> /dev/null; then
    if [ -f "$DOTFILES_DIR/Brewfile" ]; then
        echo "Installing packages from Brewfile..."
        brew bundle --file="$DOTFILES_DIR/Brewfile" || echo "Some packages may have failed to install"
    else
        echo "Brewfile not found, skipping package installation"
    fi
else
    echo "Homebrew not available, skipping package installation"
fi

# Optional: Also install packages from native package managers
# (as fallback or for packages not available in Homebrew)
if [[ "$CI_MODE" != "1" ]]; then
    if [[ "$OS" == "debian" ]] && [ -f "$DOTFILES_DIR/packages-apt.txt" ]; then
        echo ""
        echo "Note: You can also install packages from packages-apt.txt:"
        echo "  xargs -a $DOTFILES_DIR/packages-apt.txt sudo apt-get install -y"
    elif [[ "$OS" == "redhat" ]] && [ -f "$DOTFILES_DIR/packages-dnf.txt" ]; then
        echo ""
        echo "Note: You can also install packages from packages-dnf.txt:"
        echo "  xargs -a $DOTFILES_DIR/packages-dnf.txt sudo $PKG_MANAGER install -y"
    fi
fi

echo ""
echo "Installation complete!"
echo ""
echo "Next steps:"
echo "1. Reload your shell: source ~/.zshrc"
echo "2. Or restart your terminal"
echo ""
echo "Package installation:"
echo "- Packages installed from Brewfile (Homebrew works on all platforms)"
echo "- To update: brew bundle --file=$DOTFILES_DIR/Brewfile"
echo "- To add new packages: Edit Brewfile and run: brew bundle --file=$DOTFILES_DIR/Brewfile"

