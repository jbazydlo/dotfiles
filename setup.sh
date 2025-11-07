#!/bin/bash
# Dotfiles installation script

# Directory where this script is located
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Setting up dotfiles from $DOTFILES_DIR"

# Create symlinks
echo "Creating symlinks..."
ln -sf "$DOTFILES_DIR/.gitconfig" ~/.gitconfig
ln -sf "$DOTFILES_DIR/.gitconfig.local" ~/.gitconfig.local

# Add more symlinks here as you add more dotfiles
# ln -sf "$DOTFILES_DIR/.bashrc" ~/.bashrc
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