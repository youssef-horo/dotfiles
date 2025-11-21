# Dotfiles & Zsh Scripts

Personal dotfiles and zsh scripts repository for oh-my-zsh configuration.

![License](https://img.shields.io/badge/license-MIT-blue.svg)

## Quick Start

```bash
git clone https://github.com/youssef-horo/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

## Supported Platforms

- **macOS** (Homebrew)
- **Debian/Ubuntu** (apt)
- **RedHat/CentOS/Fedora** (dnf/yum)

The dotfiles automatically detect your platform and load appropriate configurations.

## Structure

```
.
├── zsh/                    # Zsh configuration files
│   ├── .zshrc              # Main zsh configuration
│   ├── platform/           # Platform-specific configurations
│   └── custom/             # oh-my-zsh custom files
├── scripts/                # Reusable bash/zsh scripts
├── dotfiles/               # Other dotfiles
├── install.sh              # Installation script
└── docs/                   # Documentation
```

## Documentation

- **[Installation Guide](docs/INSTALLATION.md)** - Detailed installation instructions
- **[Platform Support](docs/PLATFORMS.md)** - Platform-specific information
- **[GitHub Actions](docs/GITHUB_ACTIONS.md)** - CI/CD setup and usage
- **[Development](docs/DEVELOPMENT.md)** - Contributing and customization

## License

MIT License - see [LICENSE](LICENSE) for details.
