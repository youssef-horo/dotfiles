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

# Create symlinks for custom plugins/themes if they exist
if [ -d "$DOTFILES_DIR/zsh/custom/plugins" ] && [ "$(ls -A $DOTFILES_DIR/zsh/custom/plugins)" ]; then
    if [ ! -L "$HOME/.oh-my-zsh/custom/plugins" ]; then
        echo "Creating symlink for custom plugins"
        ln -s "$DOTFILES_DIR/zsh/custom/plugins" "$HOME/.oh-my-zsh/custom/plugins"
    fi
fi

if [ -d "$DOTFILES_DIR/zsh/custom/themes" ] && [ "$(ls -A $DOTFILES_DIR/zsh/custom/themes)" ]; then
    if [ ! -L "$HOME/.oh-my-zsh/custom/themes" ]; then
        echo "Creating symlink for custom themes"
        ln -s "$DOTFILES_DIR/zsh/custom/themes" "$HOME/.oh-my-zsh/custom/themes"
    fi
fi

echo ""
echo "Installation complete!"
echo ""
echo "Next steps:"
echo "1. Reload your shell: source ~/.zshrc"
echo "2. Or restart your terminal"
echo ""
echo "Platform-specific notes:"
if [[ "$OS" == "macos" ]]; then
    echo "- Homebrew is recommended for package management"
    echo "- Run: brew install git kubectl kustomize"
elif [[ "$OS" == "debian" ]]; then
    echo "- Install packages with: sudo apt-get install git kubectl kustomize"
elif [[ "$OS" == "redhat" ]]; then
    echo "- Install packages with: sudo $PKG_MANAGER install git kubectl kustomize"
fi

