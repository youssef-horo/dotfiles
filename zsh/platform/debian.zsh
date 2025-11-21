# Debian/Ubuntu-specific configuration

# Add common Debian paths if needed
if [[ -d "/usr/local/go/bin" ]]; then
    export PATH="/usr/local/go/bin:$PATH"
fi

