# macOS-specific configuration

# Homebrew paths (Apple Silicon)
if [[ -d "/opt/homebrew" ]]; then
    export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
    
    # MySQL paths
    if [[ -d "/opt/homebrew/opt/mysql@8.0/bin" ]]; then
        export PATH="/opt/homebrew/opt/mysql@8.0/bin:$PATH"
    fi
    if [[ -d "/opt/homebrew/opt/mysql-client/bin" ]]; then
        export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
    fi
fi

# Homebrew paths (Intel)
if [[ -d "/usr/local/Homebrew" ]]; then
    export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
fi

# Conda initialization (if installed)
if [[ -f "$HOME/opt/anaconda3/etc/profile.d/conda.sh" ]]; then
    . "$HOME/opt/anaconda3/etc/profile.d/conda.sh"
elif [[ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]]; then
    . "$HOME/anaconda3/etc/profile.d/conda.sh"
elif command -v conda &> /dev/null; then
    eval "$(conda shell.zsh hook 2>/dev/null)"
fi

# Google Cloud SDK
if [[ -f "$HOME/Downloads/google-cloud-sdk/path.zsh.inc" ]]; then
    . "$HOME/Downloads/google-cloud-sdk/path.zsh.inc"
fi
if [[ -f "$HOME/Downloads/google-cloud-sdk/completion.zsh.inc" ]]; then
    . "$HOME/Downloads/google-cloud-sdk/completion.zsh.inc"
fi

# Docker Desktop
if [[ -f "$HOME/.docker/init-zsh.sh" ]]; then
    source "$HOME/.docker/init-zsh.sh" 2>/dev/null || true
fi

# Windsurf/Codeium
if [[ -d "$HOME/.codeium/windsurf/bin" ]]; then
    export PATH="$HOME/.codeium/windsurf/bin:$PATH"
fi

# macOS-specific function: show listening ports
macnst() {
    netstat -Watnlv | grep LISTEN | awk '{"ps -o comm= -p " $9 | getline procname;colred="\033[01;31m";colclr="\033[0m"; print colred "proto: " colclr $1 colred " | addr.port: " colclr $4 colred " | pid: " colclr $9 colred " | name: " colclr procname;  }' | column -t -s "|"
}

