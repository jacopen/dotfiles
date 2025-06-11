# Dotfiles - Multi-Environment Support

Modern, cross-platform dotfiles with template-based configuration for multiple environments.

## Quick Start

### Simple Installation (Auto-detect environment)
```bash
./install.sh
```

### Custom Installation
```bash
# For your personal Mac
./install.sh --user-name "Kazuto Kusama" --user-email "jacopen@gmail.com"

# For Linux server as ubuntu user
./install.sh --user-name "Ubuntu User" --user-email "ubuntu@server.com" --home-dir "/home/ubuntu"

# For Linux server as different user
./install.sh --user-name "Deploy User" --user-email "deploy@company.com" --home-dir "/home/deploy"
```

### Dry Run (Preview changes)
```bash
./install.sh --dry-run --verbose
```

## Features

- ✅ **Multi-Environment Support**: Works on macOS, Linux, different users
- ✅ **Template System**: Dynamic configuration based on environment
- ✅ **Safe Installation**: Automatic backups of existing files
- ✅ **Modern Tools**: Updated Git aliases, Neovim config, modern zsh setup
- ✅ **Dry Run Support**: Preview changes before applying
- ✅ **Verbose Logging**: Detailed output for troubleshooting

## Installation Options

| Option | Description | Example |
|--------|-------------|---------|
| `--user-name` | Git user name | `"Kazuto Kusama"` |
| `--user-email` | Git user email | `"jacopen@gmail.com"` |
| `--home-dir` | Home directory path | `/home/ubuntu` |
| `--os-type` | OS type (auto-detected) | `linux`, `darwin` |
| `--shell-type` | Shell type | `zsh`, `bash` |
| `--dry-run` | Preview mode | |
| `--verbose` | Detailed output | |

## Supported Environments

### macOS
```bash
./install.sh --user-name "Your Name" --home-dir "/Users/username"
```

### Ubuntu/Debian Linux
```bash
./install.sh --user-name "Your Name" --home-dir "/home/username"
```

### CentOS/RHEL/Amazon Linux
```bash
./install.sh --user-name "Your Name" --home-dir "/home/username"
```

### Docker/Container environments
```bash
./install.sh --user-name "Container User" --home-dir "/root"
```

## What's Included

- **Shell Configuration**: Modern zsh setup with git integration
- **Neovim**: AstroNvim-based configuration with custom plugins
- **Git**: Modern aliases and efficient workflow commands
- **Terminal Tools**: tmux, vim, screen configurations
- **Development Tools**: Support for Ruby, Python, Node.js, Android, Flutter

## Template System

The following files are dynamically generated from templates:

- `.gitconfig` - Git configuration with user info and modern aliases
- `zsh/pipx` - Python package manager paths
- `zsh/android` - Android SDK paths
- `config.json` - Installation configuration backup

## Modern Git Aliases

| Alias | Command | Description |
|-------|---------|-------------|
| `git sw` | `git switch` | Modern branch switching |
| `git restore` | `git restore` | File restoration |
| `git unstage` | `git reset HEAD --` | Unstage files |
| `git last` | `git log -1 HEAD` | Show last commit |
| `git amend` | `git commit --amend` | Amend last commit |
| `git pushf` | `git push --force-with-lease` | Safe force push |

## File Structure

```
dotfiles/
├── install.sh              # Main installation script
├── templates/              # Template files
│   ├── .gitconfig.template
│   ├── zsh_pipx.template
│   └── zsh_android.template
├── config.template.json    # Configuration template
├── nvim/                   # Neovim configuration
├── zsh/                    # Zsh modules
├── tools/                  # Installation tools
└── private/               # Private configurations
```

## Troubleshooting

### Check what would be installed
```bash
./install.sh --dry-run --verbose
```

### View current configuration
```bash
cat config.json  # After installation
```

### Restore from backup
```bash
# Backups are created with timestamp
ls -la ~/.gitconfig.bak.*
mv ~/.gitconfig.bak.20241201_123456 ~/.gitconfig
```

## Migration from Legacy symlink.sh

The old `symlink.sh` script has been removed. Use `install.sh` instead:
```bash
# Old way (removed)
# ./symlink.sh

# New way
./install.sh
```

## Contributing

1. Fork the repository
2. Create templates for new configuration files in `templates/`
3. Update `install.sh` to process new templates
4. Test with `--dry-run` flag
5. Submit pull request

## License

MIT License - see LICENSE file for details.