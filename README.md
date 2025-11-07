# Dotfiles Repository

This repository contains my personal dotfiles configuration, set up with a public/private split for security and portability.

## Structure

- `.gitconfig` - Public Git configuration with aliases and settings
- `.gitignore` - Ignores private configuration files
- `setup.sh` - Script to symlink dotfiles to your home directory
- `.gitconfig.local` - Private configuration (not tracked by Git)

## Setup on a New Machine

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
   ```

2. Navigate to the directory:
   ```bash
   cd ~/dotfiles
   ```

3. Run the setup script:
   ```bash
   ./setup.sh
   ```

4. Create your private configuration file:
   ```bash
   nano ~/.gitconfig.local
   ```

5. Add your personal information to `.gitconfig.local`:
   ```ini
   [user]
       name = Your Name
       email = your.email@example.com
   ```

## Security Notes

- Sensitive information (email, tokens, etc.) should go in `.gitconfig.local`
- This file is ignored by Git and will never be committed
- This allows you to have a public repository while keeping private data secure

## Adding More Dotfiles

To add more configuration files:

1. Add the file to this repository
2. Update `.gitignore` if you need a private version
3. Update `setup.sh` to create the symlink
4. Commit and push your changes

## Corporate Usage

This setup is perfect for corporate environments:
- Clone the repository without authentication (HTTPS)
- Create a corporate-specific `.gitconfig.local` with your work email
- Your personal configurations remain private

## License

MIT License - feel free to use this structure for your own dotfiles!