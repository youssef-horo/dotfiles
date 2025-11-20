# Dotfiles & Bash Scripts

Personal dotfiles and bash scripts repository.

## Structure

```
.
├── bash/          # Bash configuration files (.bashrc, .bash_profile, etc.)
├── scripts/       # Reusable bash scripts
├── dotfiles/      # Other dotfiles (.vimrc, .gitconfig, etc.)
└── README.md      # This file
```

## Installation

### Bash Configuration

```bash
# Symlink bash files
ln -s ~/dotfiles/bash/.bashrc ~/.bashrc
ln -s ~/dotfiles/bash/.bash_profile ~/.bash_profile
```

### Scripts

Add scripts directory to PATH in your `.bashrc`:

```bash
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

