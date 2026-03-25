#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Install nix if not present
if ! command -v nix &>/dev/null; then
    echo "Nix not found, installing..."
    curl -L https://nixos.org/nix/install | sh -s -- --daemon --yes
    # Source nix in current shell
    if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
    fi
fi

# Ensure flakes are enabled
if ! nix flake --help &>/dev/null; then
    echo "Enabling flakes..."
    mkdir -p ~/.config/nix
    grep -q 'experimental-features.*flakes' ~/.config/nix/nix.conf 2>/dev/null || \
        echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
fi

# Determine system architecture
ARCH="$(uname -m)"
OS="$(uname -s)"

if [[ "$OS" == "Darwin" ]]; then
    CONFIG_NAME="darwin"
elif [[ "$(whoami)" == "vscode" ]] || [[ -n "${REMOTE_CONTAINERS:-}" ]] || [[ -n "${CODESPACES:-}" ]]; then
    if [[ "$ARCH" == "aarch64" || "$ARCH" == "arm64" ]]; then
        CONFIG_NAME="devcontainer"
    else
        CONFIG_NAME="devcontainer-x86"
    fi
else
    if [[ "$ARCH" == "aarch64" || "$ARCH" == "arm64" ]]; then
        CONFIG_NAME="linux-arm"
    else
        CONFIG_NAME="linux"
    fi
fi

echo "=== Home Manager Setup ==="
echo "Config: ${CONFIG_NAME}"
echo "Directory: ${SCRIPT_DIR}"

# Remove packages from nix profile that home-manager will manage,
# to avoid conflicts
for pkg in direnv; do
    if nix profile list 2>/dev/null | grep -q "$pkg"; then
        echo "Removing '$pkg' from nix profile (will be managed by home-manager)..."
        nix profile remove "$pkg" 2>/dev/null || true
    fi
done

nix run home-manager/master -- switch --impure --flake "${SCRIPT_DIR}#${CONFIG_NAME}" -b backup

# Set zsh as default shell if available and not already active
ZSH_PATH="$(which zsh 2>/dev/null || true)"
if [[ -n "$ZSH_PATH" ]] && [[ "$SHELL" != *"zsh"* ]]; then
    echo "$ZSH_PATH" | sudo tee -a /etc/shells > /dev/null 2>&1 || true
    sudo chsh -s "$ZSH_PATH" "$(whoami)" 2>/dev/null || true
fi

echo "=== Home Manager setup complete ==="
