#!/bin/bash

# Dotfiles installation script with multi-environment support
# Usage: ./install.sh [OPTIONS]
# Example: ./install.sh --user-name "Kazuto Kusama" --user-email "jacopen@gmail.com" --home-dir "/Users/kkusama"

set -e

# Default values
USER_NAME="$(git config user.name 2>/dev/null || echo 'Your Name')"
USER_EMAIL="$(git config user.email 2>/dev/null || echo 'your.email@example.com')"
HOME_DIR="$HOME"
OS_TYPE="$(uname -s | tr '[:upper:]' '[:lower:]')"
SHELL_TYPE="zsh"
DRY_RUN=false
VERBOSE=false

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Help function
show_help() {
    cat << EOF
Dotfiles Installation Script

USAGE:
    ./install.sh [OPTIONS]

OPTIONS:
    -n, --user-name NAME        Git user name (default: current git config or 'Your Name')
    -e, --user-email EMAIL      Git user email (default: current git config or 'your.email@example.com')
    -h, --home-dir PATH         Home directory path (default: \$HOME)
    -o, --os-type TYPE          OS type: linux, darwin, etc. (default: auto-detected)
    -s, --shell-type SHELL      Shell type: zsh, bash (default: zsh)
    --dry-run                   Show what would be done without making changes
    -v, --verbose               Verbose output
    --help                      Show this help message

EXAMPLES:
    # Basic installation with auto-detection
    ./install.sh

    # Custom user and email
    ./install.sh --user-name "John Doe" --user-email "john@example.com"

    # Linux environment
    ./install.sh --user-name "Ubuntu User" --home-dir "/home/ubuntu"

    # Dry run to see what would be done
    ./install.sh --dry-run

EOF
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -n|--user-name)
            USER_NAME="$2"
            shift 2
            ;;
        -e|--user-email)
            USER_EMAIL="$2"
            shift 2
            ;;
        -h|--home-dir)
            HOME_DIR="$2"
            shift 2
            ;;
        -o|--os-type)
            OS_TYPE="$2"
            shift 2
            ;;
        -s|--shell-type)
            SHELL_TYPE="$2"
            shift 2
            ;;
        --dry-run)
            DRY_RUN=true
            shift
            ;;
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        --help)
            show_help
            exit 0
            ;;
        *)
            log_error "Unknown option: $1"
            show_help
            exit 1
            ;;
    esac
done

# Validate required parameters
if [[ -z "$USER_NAME" || -z "$USER_EMAIL" ]]; then
    log_error "User name and email are required"
    show_help
    exit 1
fi

# Show configuration
log_info "Configuration:"
echo "  User Name:    $USER_NAME"
echo "  User Email:   $USER_EMAIL"
echo "  Home Dir:     $HOME_DIR"
echo "  OS Type:      $OS_TYPE"
echo "  Shell Type:   $SHELL_TYPE"
echo "  Dry Run:      $DRY_RUN"

if [[ "$DRY_RUN" == "true" ]]; then
    log_warning "DRY RUN MODE: No changes will be made"
fi

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATES_DIR="$SCRIPT_DIR/templates"

# Template processing function
process_template() {
    local template_file="$1"
    local output_file="$2"
    
    if [[ ! -f "$template_file" ]]; then
        log_error "Template file not found: $template_file"
        return 1
    fi
    
    if [[ "$VERBOSE" == "true" ]]; then
        log_info "Processing template: $template_file -> $output_file"
    fi
    
    # Use sed to replace placeholders
    sed -e "s|{{USER_NAME}}|$USER_NAME|g" \
        -e "s|{{USER_EMAIL}}|$USER_EMAIL|g" \
        -e "s|{{HOME_DIR}}|$HOME_DIR|g" \
        -e "s|{{OS_TYPE}}|$OS_TYPE|g" \
        -e "s|{{SHELL_TYPE}}|$SHELL_TYPE|g" \
        "$template_file" > "$output_file.tmp"
    
    if [[ "$DRY_RUN" == "false" ]]; then
        mv "$output_file.tmp" "$output_file"
        log_success "Generated: $output_file"
    else
        log_info "Would generate: $output_file"
        rm "$output_file.tmp"
    fi
}

# Backup function
backup_file() {
    local file="$1"
    if [[ -f "$file" ]]; then
        local backup="$file.bak.$(date +%Y%m%d_%H%M%S)"
        if [[ "$DRY_RUN" == "false" ]]; then
            mv "$file" "$backup"
            log_warning "Backed up existing file: $file -> $backup"
        else
            log_info "Would backup: $file -> $backup"
        fi
    fi
}

# Create symlink function
create_symlink() {
    local source="$1"
    local target="$2"
    
    # Create target directory if it doesn't exist
    local target_dir="$(dirname "$target")"
    if [[ ! -d "$target_dir" ]]; then
        if [[ "$DRY_RUN" == "false" ]]; then
            mkdir -p "$target_dir"
            log_info "Created directory: $target_dir"
        else
            log_info "Would create directory: $target_dir"
        fi
    fi
    
    # Backup existing file
    backup_file "$target"
    
    # Create symlink
    if [[ "$DRY_RUN" == "false" ]]; then
        ln -sf "$source" "$target"
        log_success "Created symlink: $target -> $source"
    else
        log_info "Would create symlink: $target -> $source"
    fi
}

# Main installation process
main() {
    log_info "Starting dotfiles installation..."
    
    # Update git submodules
    if [[ "$DRY_RUN" == "false" ]]; then
        git submodule update --init --recursive
        log_success "Updated git submodules"
    else
        log_info "Would update git submodules"
    fi
    
    # Process templates
    log_info "Processing templates..."
    
    # Generate .gitconfig from template
    process_template "$TEMPLATES_DIR/.gitconfig.template" "$SCRIPT_DIR/.gitconfig"
    
    # Generate zsh configuration files
    process_template "$TEMPLATES_DIR/zsh_pipx.template" "$SCRIPT_DIR/zsh/pipx"
    process_template "$TEMPLATES_DIR/zsh_android.template" "$SCRIPT_DIR/zsh/android"
    
    # Generate config file
    process_template "$SCRIPT_DIR/config.template.json" "$SCRIPT_DIR/config.json"
    
    # Create symlinks
    log_info "Creating symlinks..."
    
    create_symlink "$SCRIPT_DIR/.vimrc" "$HOME_DIR/.vimrc"
    create_symlink "$SCRIPT_DIR/.screenrc" "$HOME_DIR/.screenrc"
    create_symlink "$SCRIPT_DIR/.zshenv" "$HOME_DIR/.zshenv"
    create_symlink "$SCRIPT_DIR/.zshrc" "$HOME_DIR/.zshrc"
    create_symlink "$SCRIPT_DIR/.vim" "$HOME_DIR/.vim"
    create_symlink "$SCRIPT_DIR/.byobu" "$HOME_DIR/.byobu"
    create_symlink "$SCRIPT_DIR/.gitconfig" "$HOME_DIR/.gitconfig"
    create_symlink "$SCRIPT_DIR/.tmux.conf" "$HOME_DIR/.tmux.conf"
    create_symlink "$SCRIPT_DIR/nvim" "$HOME_DIR/.config/nvim"
    
    # SSH config (if exists)
    if [[ -f "$SCRIPT_DIR/private/.ssh_config" ]]; then
        create_symlink "$SCRIPT_DIR/private/.ssh_config" "$HOME_DIR/.ssh/config"
    fi
    
    log_success "Dotfiles installation completed!"
    log_info "Configuration saved to: $SCRIPT_DIR/config.json"
    
    if [[ "$DRY_RUN" == "false" ]]; then
        log_info "Please restart your shell or run: source $HOME_DIR/.zshrc"
    fi
}

# Run main function
main