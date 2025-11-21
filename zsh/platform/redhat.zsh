# RedHat/CentOS/Fedora-specific configuration

# Add common RedHat paths if needed
if [[ -d "/usr/local/go/bin" ]]; then
    export PATH="/usr/local/go/bin:$PATH"
fi

