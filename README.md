# Dotfiles Repository

This repository contains personal dotfiles configuration with a public/private split for security and portability. It includes Git configuration, bash enhancements with Oh My Bash and Ble.sh, and a convenient setup script.

## Features

- **Public/Private Split**: Sensitive configurations are kept in local files that are ignored by Git
- **Enhanced Bash Experience**: Combines Oh My Bash for theming and plugins with Ble.sh for advanced line editing
- **Git Configuration**: Optimized Git settings with aliases and sensible defaults
- **Automated Setup**: One-command installation with dependency management

## Structure

- `.gitconfig` - Public Git configuration with optimized settings
- `.gitconfig.local` - Private Git configuration (ignored by Git, may exist locally)
- `.gitignore` - Ignores private configuration files
- `.bashrc` - Bash configuration with Oh My Bash and Ble.sh integration
- `.bashrc.local` - Private bash configuration (ignored by Git, may exist locally)
- `.blerc` - Ble.sh configuration for enhanced bash line editing
- `.blerc.local` - Private Ble.sh configuration (ignored by Git, may exist locally)
- `setup.sh` - Automated installation script with dependency management

## Setup on a New Machine

1. Clone this repository:
   ```bash
   git clone https://github.com/jacekbazydlo/dotfiles.git ~/dotfiles
   ```

2. Navigate to the directory:
   ```bash
   cd ~/dotfiles
   ```

3. Run the setup script:
   ```bash
   ./setup.sh
   ```

4. Update your personal information in `.gitconfig.local`:
   ```bash
   nano ~/.gitconfig.local
   ```

5. (Optional) For bash-specific private settings, create `.bashrc.local`:
   ```bash
   nano ~/.bashrc.local
   ```

6. (Optional) For ble.sh specific settings, create `.blerc.local`:
   ```bash
   nano ~/.blerc.local
   ```

The setup script will automatically:
- Install Oh My Bash if not present
- Install Ble.sh if not present
- Create symlinks for public configuration files
- Create symlinks for local configuration files only if they exist in the dotfiles directory

## Security Notes

- Sensitive information (email, tokens, etc.) should go in `.gitconfig.local`
- Private configuration files (`.gitconfig.local`, `.bashrc.local`, `.blerc.local`) are ignored by Git
- These files can be stored in your dotfiles folder for convenience (they won't be committed)
- The setup script will create symlinks to these local files only if they exist
- This approach allows you to maintain a public repository while keeping private data secure
- All configuration files can be modified from one place (your dotfiles folder)

## Adding More Dotfiles

To add more configuration files:

1. Add the file to this repository
2. Update `.gitignore` if you need a private version (add `.filename.local`)
3. Update `setup.sh` to create the symlink (add `ln -sf "$DOTFILES_DIR/.filename" ~/.filename`)
4. For private files, add conditional symlink logic like:
   ```bash
   if [ -f "$DOTFILES_DIR/.filename.local" ]; then
       ln -sf "$DOTFILES_DIR/.filename.local" ~/.filename.local
       echo "Linked .filename.local"
   fi
   ```
5. Commit and push your changes

## Corporate Usage

This setup is perfect for corporate environments:
- Clone the repository without authentication (HTTPS)
- Create a corporate-specific `.gitconfig.local` with your work email
- Your personal configurations remain private and separate from work settings

## Requirements

- Git
- Bash
- Make (for Ble.sh installation)
- Sudo access (recommended for Ble.sh installation, but script will attempt without it)

## Customization

### Oh My Bash
The configuration uses the "powerbash10k" theme with the following plugins:
- git
- bashmarks
- fzf

### Ble.sh
Minimal configuration is provided in `.blerc`, but you can extend it with:
```bash
# Example .blerc.local additions
bleopt history_preserve_point=yes
bleopt history_share=yes
bleopt history_dupe_erase=yes
```

## License

MIT License - feel free to use this structure for your own dotfiles!