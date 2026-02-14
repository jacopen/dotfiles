# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository for macOS development environment setup. It uses a symlink-based installation approach to manage configuration files for various development tools.

## Key Commands

### Initial Setup
```bash
# Install dotfiles with auto-detection
./install.sh

# Install for specific environment
./install.sh --user-name "Your Name" --user-email "your@email.com"

# Preview installation
./install.sh --dry-run --verbose

# Install essential development tools via Homebrew
./tools/homebrew.sh
```

### Neovim Management
```bash
# Start Neovim (will auto-install plugins on first run)
nvim

# Update AstroNvim and plugins from within Neovim
:Lazy update
```

## Architecture

### Installation System
- `install.sh` - Main installation script with multi-environment support, template processing, and safe installation features
- Backs up existing configurations with `.bak` extension before creating symlinks
- Links configurations for vim, zsh, git, tmux, neovim, and SSH

### Configuration Structure
- **nvim/** - AstroNvim v4+ configuration with Lazy.nvim plugin manager
- **zsh/** - Modular zsh configuration split by tool (brew, rbenv, android, etc.)
- **private/** - Directory for sensitive configurations (SSH config, etc.)
- **tools/** - Setup scripts for development tools

### Neovim Configuration
- Based on AstroNvim template with customizations in `lua/plugins/`
- Plugin management through `lazy_setup.lua` with community plugins imported
- LSP, treesitter, and completion configured through astrolsp.lua and related files

### Zsh Configuration
- Main configuration in `.zshrc` with git-aware prompt
- Modular tool-specific configurations loaded from `zsh/` directory
- Environment variables defined in `.zshenv`

## Important Files

- `install.sh` - Primary installation script with multi-environment support
- `nvim/init.lua` - Neovim bootstrap file
- `nvim/lua/lazy_setup.lua` - Plugin manager configuration
- `.zshrc` - Main shell configuration
- `.gitconfig` - Git configuration with useful aliases
- `tools/homebrew.sh` - Development tools installation script