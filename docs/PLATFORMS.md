# Platform Support

The dotfiles automatically detect your platform and load appropriate configurations.

## Supported Platforms

### macOS

- **Package Manager**: Homebrew
- **Paths**: `/opt/homebrew` (Apple Silicon) or `/usr/local` (Intel)
- **Features**:
  - Homebrew integration
  - macOS-specific functions (`macnst`)
  - Docker Desktop support
  - Conda/Anaconda support

### Debian/Ubuntu

- **Package Manager**: apt
- **Detection**: `/etc/os-release` with `ID=debian` or `ID=ubuntu`
- **Features**:
  - apt package manager support
  - Common Linux paths
  - Docker support

### RedHat/CentOS/Fedora

- **Package Manager**: dnf (Fedora/RHEL 8+) or yum (CentOS 7/RHEL 7)
- **Detection**: `/etc/os-release` with `ID=rhel`, `ID=centos`, `ID=fedora`, etc.
- **Features**:
  - dnf/yum package manager support
  - Common Linux paths
  - Docker support

## Platform Detection

The platform is automatically detected using:

1. **macOS**: `$OSTYPE == "darwin*"`
2. **Linux**: Reads `/etc/os-release` and checks `ID` field

You can manually check platform detection:

```bash
./scripts/detect-platform.sh
```

Output format: `os:package_manager` (e.g., `macos:brew`, `debian:apt`)

## Platform-Specific Configurations

Platform-specific settings are in `zsh/platform/`:

- `macos.zsh` - macOS-specific paths and functions
- `linux.zsh` - Common Linux configurations
- `debian.zsh` - Debian/Ubuntu-specific settings
- `redhat.zsh` - RedHat/CentOS/Fedora-specific settings

These files are automatically loaded based on detected platform.

## Customization

To add platform-specific settings:

1. Edit the appropriate file in `zsh/platform/`
2. Or create a new platform file if needed
3. Update platform detection in `zsh/.zshrc` if adding new platform

## Platform-Specific Plugins

- **macOS**: Includes `brew` plugin
- **Linux**: Excludes `brew` plugin (not available)

Plugins are automatically adjusted based on platform.

