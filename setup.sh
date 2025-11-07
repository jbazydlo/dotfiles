#!/bin/bash
# Dotfiles installation script

# Directory where this script is located
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Install Oh My Bash if not already installed
install_oh_my_bash() {
    if [ ! -d "$HOME/.oh-my-bash" ]; then
        echo "Installing Oh My Bash..."
        git clone https://github.com/ohmybash/oh-my-bash.git ~/.oh-my-bash
    else
        echo "Oh My Bash is already installed"
    fi
}

# Install Ble.sh if not already installed
install_ble_sh() {
    if [ ! -d "$HOME/.local/share/blesh" ]; then
        echo "Installing Ble.sh..."
        cd /tmp
        git clone --depth 1 https://github.com/akinomyoga/ble.sh.git
        cd ble.sh
        make
        sudo make install
        cd /tmp
        rm -rf ble.sh
        cd "$DOTFILES_DIR"
    else
        echo "Ble.sh is already installed"
    fi
}

echo "Setting up dotfiles from $DOTFILES_DIR"

# Install dependencies if needed
install_oh_my_bash
install_ble_sh

# Create symlinks
echo "Creating symlinks..."
ln -sf "$DOTFILES_DIR/.gitconfig" ~/.gitconfig
ln -sf "$DOTFILES_DIR/.gitconfig.local" ~/.gitconfig.local
ln -sf "$DOTFILES_DIR/.bashrc" ~/.bashrc
ln -sf "$DOTFILES_DIR/.blerc" ~/.blerc

# Add more symlinks here as you add more dotfiles
# ln -sf "$DOTFILES_DIR/.vimrc" ~/.vimrc

echo "Dotfiles installed successfully!"
echo ""
echo "Remember to:"
echo "1. Create ~/.gitconfig.local with your user settings"
echo "2. Add any other private configuration files you need"
echo ""
echo "Example ~/.gitconfig.local:"
echo "[user]"
echo "    name = Your Name"
echo "    email = your.email@example.com"