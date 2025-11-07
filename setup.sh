#!/bin/bash
# Dotfiles installation script

# Directory where this script is located
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Install Oh My Bash if not already installed
install_oh_my_bash() {
    if [ ! -d "$HOME/.oh-my-bash" ]; then
        echo "Installing Oh My Bash..."
        git clone https://github.com/ohmybash/oh-my-bash.git ~/.oh-my-bash || {
            echo "Error: Failed to clone Oh My Bash repository."
            return 1
        }
        echo "Oh My Bash installed successfully!"
    else
        echo "Oh My Bash is already installed"
    fi
}

# Install Ble.sh if not already installed
install_ble_sh() {
    if [ ! -d "$HOME/.local/share/blesh" ]; then
        echo "Installing Ble.sh..."
        
        # Check if /tmp is writable
        if [ ! -w "/tmp" ]; then
            echo "Error: /tmp directory is not writable. Cannot install Ble.sh."
            return 1
        fi
        
        # Create a temporary directory for the installation
        TEMP_DIR=$(mktemp -d)
        if [ $? -ne 0 ]; then
            echo "Error: Failed to create temporary directory. Cannot install Ble.sh."
            return 1
        fi
        
        # Clone and build Ble.sh
        cd "$TEMP_DIR" || {
            echo "Error: Failed to change to temporary directory."
            rm -rf "$TEMP_DIR"
            return 1
        }
        
        git clone --depth 1 https://github.com/akinomyoga/ble.sh.git || {
            echo "Error: Failed to clone Ble.sh repository."
            cd "$DOTFILES_DIR"
            rm -rf "$TEMP_DIR"
            return 1
        }
        
        cd ble.sh || {
            echo "Error: Failed to enter Ble.sh directory."
            cd "$DOTFILES_DIR"
            rm -rf "$TEMP_DIR"
            return 1
        }
        
        make || {
            echo "Error: Failed to build Ble.sh."
            cd "$DOTFILES_DIR"
            rm -rf "$TEMP_DIR"
            return 1
        }
        
        # Check if sudo is available and needed
        if command -v sudo >/dev/null 2>&1; then
            echo "Using sudo for installation..."
            sudo make install || {
                echo "Error: Failed to install Ble.sh with sudo."
                cd "$DOTFILES_DIR"
                rm -rf "$TEMP_DIR"
                return 1
            }
        else
            echo "Sudo not available. Attempting to install without sudo..."
            make install || {
                echo "Error: Failed to install Ble.sh without sudo. You may need to run this script with sudo privileges."
                cd "$DOTFILES_DIR"
                rm -rf "$TEMP_DIR"
                return 1
            }
        fi
        
        # Cleanup
        cd "$DOTFILES_DIR"
        rm -rf "$TEMP_DIR"
        echo "Ble.sh installed successfully!"
    else
        echo "Ble.sh is already installed"
    fi
}

echo "Setting up dotfiles from $DOTFILES_DIR"

# Install dependencies if needed
install_oh_my_bash || {
    echo "Error: Oh My Bash installation failed. Aborting."
    exit 1
}

install_ble_sh || {
    echo "Error: Ble.sh installation failed. Aborting."
    exit 1
}

# Create symlinks for public files
echo "Creating symlinks for public configuration files..."
ln -sf "$DOTFILES_DIR/.gitconfig" ~/.gitconfig
ln -sf "$DOTFILES_DIR/.bashrc" ~/.bashrc
ln -sf "$DOTFILES_DIR/.blerc" ~/.blerc

# Create symlinks for local files if they exist in the dotfiles directory
# These files are ignored by git but may exist locally for convenience
echo "Creating symlinks for local configuration files (if they exist)..."
if [ -f "$DOTFILES_DIR/.gitconfig.local" ]; then
    ln -sf "$DOTFILES_DIR/.gitconfig.local" ~/.gitconfig.local
    echo "Linked .gitconfig.local"
fi

if [ -f "$DOTFILES_DIR/.bashrc.local" ]; then
    ln -sf "$DOTFILES_DIR/.bashrc.local" ~/.bashrc.local
    echo "Linked .bashrc.local"
fi

if [ -f "$DOTFILES_DIR/.blerc.local" ]; then
    ln -sf "$DOTFILES_DIR/.blerc.local" ~/.blerc.local
    echo "Linked .blerc.local"
fi

# Add more symlinks here as you add more dotfiles
# ln -sf "$DOTFILES_DIR/.vimrc" ~/.vimrc

echo "Dotfiles installed successfully!"
echo ""
echo "Remember to:"
echo "1. Update ~/.gitconfig.local with your user settings (if not already done)"
echo "2. Add any other private configuration files you need"
echo ""
echo "Example ~/.gitconfig.local:"
echo "[user]"
echo "    name = Your Name"
echo "    email = your.email@example.com"