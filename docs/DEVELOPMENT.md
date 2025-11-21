# Development Guide

## Project Structure

```
.
├── zsh/                    # Zsh configuration files
│   ├── .zshrc              # Main zsh configuration
│   ├── platform/           # Platform-specific configurations
│   │   ├── macos.zsh       # macOS-specific settings
│   │   ├── linux.zsh       # Common Linux settings
│   │   ├── debian.zsh      # Debian/Ubuntu-specific
│   │   └── redhat.zsh      # RedHat/CentOS/Fedora-specific
│   └── custom/             # oh-my-zsh custom files
│       ├── plugins/        # Custom oh-my-zsh plugins
│       └── themes/         # Custom oh-my-zsh themes
├── scripts/                # Reusable bash/zsh scripts
│   └── detect-platform.sh  # Platform detection utility
├── dotfiles/               # Other dotfiles (.vimrc, .gitconfig, etc.)
├── install.sh              # Installation script
├── docs/                   # Documentation
└── .github/workflows/      # GitHub Actions workflows
```

## Platform Detection

Platform detection is handled by `scripts/detect-platform.sh`:

- Detects OS type (macOS, Debian, RedHat, etc.)
- Detects package manager (brew, apt, dnf, yum)
- Returns format: `os:package_manager`

## Adding Platform Support

1. Create platform config file in `zsh/platform/`
2. Update platform detection in `zsh/.zshrc`
3. Add installation steps in `install.sh`
4. Update documentation in `docs/PLATFORMS.md`

## Testing

### Local Testing

Test installation script:

```bash
./install.sh
```

Test platform detection:

```bash
./scripts/detect-platform.sh
```

Test zsh syntax:

```bash
zsh -n zsh/.zshrc
```

### CI Testing

GitHub Actions automatically tests on:
- Ubuntu (latest)
- macOS (latest)

See [GitHub Actions documentation](GITHUB_ACTIONS.md) for details.

## Customization

### Adding Custom Plugins

1. Add plugin to `zsh/custom/plugins/`
2. Update `plugins` array in `zsh/.zshrc`

### Adding Custom Themes

1. Add theme to `zsh/custom/themes/`
2. Set `ZSH_THEME` in `zsh/.zshrc`

### Platform-Specific Settings

Edit the appropriate file in `zsh/platform/`:
- `macos.zsh` for macOS
- `debian.zsh` for Debian/Ubuntu
- `redhat.zsh` for RedHat/CentOS/Fedora
- `linux.zsh` for common Linux settings

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test on your platform
5. Submit a pull request

## CI Mode

The installation script supports CI mode:

```bash
CI=1 ./install.sh
```

In CI mode:
- Errors are non-fatal
- Suitable for automated testing
- Used by GitHub Actions

