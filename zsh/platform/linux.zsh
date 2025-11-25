# Linux-specific configuration (Debian/RedHat common)

# Homebrew on Linux
if [[ -d "$HOME/.linuxbrew" ]]; then
    eval "$($HOME/.linuxbrew/bin/brew shellenv)" 2>/dev/null || true
    export PATH="$HOME/.linuxbrew/bin:$HOME/.linuxbrew/sbin:$PATH"
elif [[ -d "/home/linuxbrew/.linuxbrew" ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" 2>/dev/null || true
    export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH"
fi

# Conda initialization (if installed)
if [[ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]]; then
    . "$HOME/anaconda3/etc/profile.d/conda.sh"
elif [[ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]]; then
    . "$HOME/miniconda3/etc/profile.d/conda.sh"
elif command -v conda &> /dev/null; then
    eval "$(conda shell.zsh hook 2>/dev/null)"
fi

# Google Cloud SDK (common locations)
for gcloud_path in "$HOME/google-cloud-sdk" "$HOME/Downloads/google-cloud-sdk" "/opt/google-cloud-sdk"; do
    if [[ -f "$gcloud_path/path.zsh.inc" ]]; then
        . "$gcloud_path/path.zsh.inc"
        break
    fi
done

for gcloud_path in "$HOME/google-cloud-sdk" "$HOME/Downloads/google-cloud-sdk" "/opt/google-cloud-sdk"; do
    if [[ -f "$gcloud_path/completion.zsh.inc" ]]; then
        . "$gcloud_path/completion.zsh.inc"
        break
    fi
done

# Docker (if installed via package manager)
if [[ -f "/usr/share/bash-completion/completions/docker" ]]; then
    # Docker completion might be in different location on Linux
    :
fi

# Linux-specific function: show listening ports
if command -v netstat &> /dev/null; then
    linnst() {
        netstat -tulpn 2>/dev/null | grep LISTEN | awk '{print $1, $4, $7}' | column -t
    }
elif command -v ss &> /dev/null; then
    linnst() {
        ss -tulpn | grep LISTEN
    }
fi

