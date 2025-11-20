#!/bin/bash

# Installation script for dotfiles
# This script sets up symlinks for zsh configuration

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ZSH_RC="$HOME/.zshrc"
ZSH_RC_BACKUP="$HOME/.zshrc.backup.$(date +%Y%m%d_%H%M%S)"

echo "Installing dotfiles from $DOTFILES_DIR"

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
echo "Reload your shell with: source ~/.zshrc"
echo "Or restart your terminal."

