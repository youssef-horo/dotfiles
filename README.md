# Dotfiles & Zsh Scripts

Personal dotfiles and zsh scripts repository for oh-my-zsh configuration.

## Structure

```
.
├── zsh/           # Zsh configuration files (.zshrc, oh-my-zsh custom plugins/themes)
├── scripts/       # Reusable bash/zsh scripts
├── dotfiles/      # Other dotfiles (.vimrc, .gitconfig, etc.)
└── README.md      # This file
```

## Installation

### Zsh Configuration (oh-my-zsh)

```bash
# Symlink zshrc
ln -s ~/dotfiles/zsh/.zshrc ~/.zshrc

# If using oh-my-zsh custom plugins/themes, symlink them:
# ln -s ~/dotfiles/zsh/custom/plugins ~/.oh-my-zsh/custom/plugins
# ln -s ~/dotfiles/zsh/custom/themes ~/.oh-my-zsh/custom/themes
```

### Scripts

Add scripts directory to PATH in your `.zshrc`:

```zsh
export PATH="$PATH:$HOME/dotfiles/scripts"
```

## Usage

Clone this repository:

```bash
git clone <repository-url> ~/dotfiles
```

Then follow the installation instructions above.

## License

Personal use only.

