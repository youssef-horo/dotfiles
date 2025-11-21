#!/bin/bash

# Platform detection script
# Detects the operating system and package manager

detect_platform() {
    local os=""
    local pkg_manager=""
    
    # Detect OS
    if [[ "$OSTYPE" == "darwin"* ]]; then
        os="macos"
        # Check for Homebrew
        if command -v brew &> /dev/null; then
            pkg_manager="brew"
        else
            pkg_manager="none"
        fi
    elif [[ -f /etc/os-release ]]; then
        # Read OS release file
        . /etc/os-release
        case $ID in
            debian|ubuntu)
                os="debian"
                pkg_manager="apt"
                ;;
            rhel|centos|fedora|rocky|almalinux)
                os="redhat"
                if command -v dnf &> /dev/null; then
                    pkg_manager="dnf"
                elif command -v yum &> /dev/null; then
                    pkg_manager="yum"
                else
                    pkg_manager="none"
                fi
                ;;
            *)
                os="linux"
                # Try to detect package manager
                if command -v apt &> /dev/null; then
                    pkg_manager="apt"
                elif command -v dnf &> /dev/null; then
                    pkg_manager="dnf"
                elif command -v yum &> /dev/null; then
                    pkg_manager="yum"
                else
                    pkg_manager="unknown"
                fi
                ;;
        esac
    else
        os="unknown"
        pkg_manager="unknown"
    fi
    
    echo "$os:$pkg_manager"
}

# If script is executed directly, output platform info
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    detect_platform
fi

