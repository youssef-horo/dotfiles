# Dotfiles & Zsh Scripts

Personal dotfiles and zsh scripts repository for oh-my-zsh configuration.

![License](https://img.shields.io/badge/license-MIT-blue.svg)

## Structure

```
.
├── zsh/                    # Zsh configuration files
│   ├── .zshrc              # Main zsh configuration
│   └── custom/             # oh-my-zsh custom files
│       ├── plugins/        # Custom oh-my-zsh plugins
│       └── themes/         # Custom oh-my-zsh themes
├── scripts/                # Reusable bash/zsh scripts
├── dotfiles/               # Other dotfiles (.vimrc, .gitconfig, etc.)
└── README.md               # This file
```

## Installation

Clone this repository:

```bash
git clone https://github.com/youssef-horo/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

Then run the installation script:

```bash
./install.sh
```

Or follow the manual setup below.

## Prerequisites

This setup uses Homebrew for package management. Install Homebrew first:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Setup

### Zsh Configuration (oh-my-zsh)

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

### Scripts

Add scripts directory to PATH in your `.zshrc` (if not already added):

```zsh
export PATH="$PATH:$HOME/dotfiles/scripts"
```

### Homebrew Dependencies

This configuration uses several tools installed via Homebrew. Install them with:

```bash
# Core tools
brew install git kubectl kustomize

# Other tools (adjust based on your needs)
brew install docker node npm
```

Note: Some paths in `.zshrc` may reference Homebrew-installed binaries. Make sure Homebrew is installed and the tools are available.

## License

MIT License - see [LICENSE](LICENSE) for details.

