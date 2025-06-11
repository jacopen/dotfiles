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
INSTALL_TOOLS=false
TOOLS_ONLY=false
USE_MODERN_ZSH=false

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

# Package manager detection and tools installation functions
detect_package_manager() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        if command -v brew &> /dev/null; then
            echo "brew"
        else
            echo "brew-missing"
        fi
    elif command -v apt &> /dev/null; then
        echo "apt"
    elif command -v dnf &> /dev/null; then
        echo "dnf"
    elif command -v yum &> /dev/null; then
        echo "yum"
    else
        echo "unsupported"
    fi
}

install_homebrew_first() {
    log_info "Homebrew not found. Installing Homebrew first..."
    if [[ "$DRY_RUN" == "false" ]]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        # Add Homebrew to PATH for this session
        if [[ -x "/opt/homebrew/bin/brew" ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        elif [[ -x "/usr/local/bin/brew" ]]; then
            eval "$(/usr/local/bin/brew shellenv)"
        fi
        log_success "Homebrew installed successfully"
    else
        log_info "Would install Homebrew"
    fi
}

# Modern tools configuration
MODERN_TOOLS=("bat" "fd" "ripgrep" "fzf" "jq" "direnv")
OPTIONAL_TOOLS=("eza" "gh" "starship")

# Development packages configuration
DEV_PACKAGES=("git" "curl" "zip" "zsh" "tig" "dstat" "iotop" "nethogs" "pinfo" "htop" "colordiff" "wget" "neovim")
DEV_LIBRARIES=("zlib" "openssl" "readline" "bzip2" "sqlite" "llvm" "ncurses")
BUILD_TOOLS=("build-essential")

# Package name mapping function
get_package_name() {
    local tool="$1"
    local pkg_manager="$2"
    
    case "${tool}_${pkg_manager}" in
        "bat_brew") echo "bat" ;;
        "bat_apt") echo "bat" ;;
        "bat_yum") echo "bat" ;;
        "bat_dnf") echo "bat" ;;
        
        "fd_brew") echo "fd" ;;
        "fd_apt") echo "fd-find" ;;
        "fd_yum") echo "fd-find" ;;
        "fd_dnf") echo "fd-find" ;;
        
        "ripgrep_brew") echo "ripgrep" ;;
        "ripgrep_apt") echo "ripgrep" ;;
        "ripgrep_yum") echo "ripgrep" ;;
        "ripgrep_dnf") echo "ripgrep" ;;
        
        "fzf_brew") echo "fzf" ;;
        "fzf_apt") echo "fzf" ;;
        "fzf_yum") echo "fzf" ;;
        "fzf_dnf") echo "fzf" ;;
        
        "jq_brew") echo "jq" ;;
        "jq_apt") echo "jq" ;;
        "jq_yum") echo "jq" ;;
        "jq_dnf") echo "jq" ;;
        
        "direnv_brew") echo "direnv" ;;
        "direnv_apt") echo "direnv" ;;
        "direnv_yum") echo "direnv" ;;
        "direnv_dnf") echo "direnv" ;;
        
        "eza_brew") echo "eza" ;;
        "eza_apt") echo "eza" ;;
        "eza_dnf") echo "eza" ;;
        
        "gh_brew") echo "gh" ;;
        "gh_apt") echo "gh" ;;
        "gh_dnf") echo "gh" ;;
        
        "starship_brew") echo "starship" ;;
        "starship_apt") echo "" ;;  # Install via curl
        "starship_yum") echo "" ;;  # Install via curl
        "starship_dnf") echo "" ;;  # Install via curl
        
        # Development packages
        "git_brew") echo "git" ;;
        "git_apt") echo "git" ;;
        "git_yum") echo "git" ;;
        "git_dnf") echo "git" ;;
        
        "curl_brew") echo "curl" ;;
        "curl_apt") echo "curl" ;;
        "curl_yum") echo "curl" ;;
        "curl_dnf") echo "curl" ;;
        
        "zip_brew") echo "zip" ;;
        "zip_apt") echo "zip" ;;
        "zip_yum") echo "zip" ;;
        "zip_dnf") echo "zip" ;;
        
        "zsh_brew") echo "zsh" ;;
        "zsh_apt") echo "zsh" ;;
        "zsh_yum") echo "zsh" ;;
        "zsh_dnf") echo "zsh" ;;
        
        "tig_brew") echo "tig" ;;
        "tig_apt") echo "tig" ;;
        "tig_yum") echo "tig" ;;
        "tig_dnf") echo "tig" ;;
        
        "dstat_brew") echo "dstat" ;;
        "dstat_apt") echo "dstat" ;;
        "dstat_yum") echo "dstat" ;;
        "dstat_dnf") echo "dstat" ;;
        
        "iotop_brew") echo "iotop" ;;
        "iotop_apt") echo "iotop" ;;
        "iotop_yum") echo "iotop" ;;
        "iotop_dnf") echo "iotop" ;;
        
        "nethogs_brew") echo "nethogs" ;;
        "nethogs_apt") echo "nethogs" ;;
        "nethogs_yum") echo "nethogs" ;;
        "nethogs_dnf") echo "nethogs" ;;
        
        "pinfo_brew") echo "pinfo" ;;
        "pinfo_apt") echo "pinfo" ;;
        "pinfo_yum") echo "pinfo" ;;
        "pinfo_dnf") echo "pinfo" ;;
        
        "htop_brew") echo "htop" ;;
        "htop_apt") echo "htop" ;;
        "htop_yum") echo "htop" ;;
        "htop_dnf") echo "htop" ;;
        
        "colordiff_brew") echo "colordiff" ;;
        "colordiff_apt") echo "colordiff" ;;
        "colordiff_yum") echo "colordiff" ;;
        "colordiff_dnf") echo "colordiff" ;;
        
        "wget_brew") echo "wget" ;;
        "wget_apt") echo "wget" ;;
        "wget_yum") echo "wget" ;;
        "wget_dnf") echo "wget" ;;
        
        "neovim_brew") echo "neovim" ;;
        "neovim_apt") echo "neovim" ;;
        "neovim_yum") echo "neovim" ;;
        "neovim_dnf") echo "neovim" ;;
        
        # Development libraries
        "zlib_brew") echo "zlib" ;;
        "zlib_apt") echo "zlib1g-dev" ;;
        "zlib_yum") echo "zlib-devel" ;;
        "zlib_dnf") echo "zlib-devel" ;;
        
        "openssl_brew") echo "openssl" ;;
        "openssl_apt") echo "libssl-dev" ;;
        "openssl_yum") echo "openssl-devel" ;;
        "openssl_dnf") echo "openssl-devel" ;;
        
        "readline_brew") echo "readline" ;;
        "readline_apt") echo "libreadline-dev" ;;
        "readline_yum") echo "readline-devel" ;;
        "readline_dnf") echo "readline-devel" ;;
        
        "bzip2_brew") echo "bzip2" ;;
        "bzip2_apt") echo "libbz2-dev" ;;
        "bzip2_yum") echo "bzip2-devel" ;;
        "bzip2_dnf") echo "bzip2-devel" ;;
        
        "sqlite_brew") echo "sqlite" ;;
        "sqlite_apt") echo "libsqlite3-dev" ;;
        "sqlite_yum") echo "sqlite-devel" ;;
        "sqlite_dnf") echo "sqlite-devel" ;;
        
        "llvm_brew") echo "llvm" ;;
        "llvm_apt") echo "llvm" ;;
        "llvm_yum") echo "llvm" ;;
        "llvm_dnf") echo "llvm" ;;
        
        "ncurses_brew") echo "ncurses" ;;
        "ncurses_apt") echo "libncurses5-dev libncursesw5-dev" ;;
        "ncurses_yum") echo "ncurses-devel" ;;
        "ncurses_dnf") echo "ncurses-devel" ;;
        
        # Build tools
        "build-essential_apt") echo "build-essential" ;;
        "build-essential_yum") echo "groupinstall Development Tools" ;;
        "build-essential_dnf") echo "groupinstall Development Tools" ;;
        
        *) echo "" ;;
    esac
}

update_package_manager() {
    local pkg_manager="$1"
    
    if [[ "$DRY_RUN" == "false" ]]; then
        case "$pkg_manager" in
            "apt")
                log_info "Updating apt package list..."
                sudo apt update
                ;;
            "yum"|"dnf")
                log_info "Package manager $pkg_manager ready"
                ;;
            "brew")
                log_info "Updating Homebrew..."
                brew update
                ;;
        esac
    else
        log_info "Would update $pkg_manager package manager"
    fi
}

install_build_tools() {
    local pkg_manager="$1"
    
    case "$pkg_manager" in
        "apt")
            if [[ "$DRY_RUN" == "false" ]]; then
                sudo apt install -y build-essential || log_warning "Failed to install build-essential"
            else
                log_info "Would install: build-essential via apt"
            fi
            ;;
        "yum")
            if [[ "$DRY_RUN" == "false" ]]; then
                sudo yum groupinstall -y "Development Tools" || log_warning "Failed to install Development Tools"
            else
                log_info "Would install: Development Tools group via yum"
            fi
            ;;
        "dnf")
            if [[ "$DRY_RUN" == "false" ]]; then
                sudo dnf groupinstall -y "Development Tools" || log_warning "Failed to install Development Tools"
            else
                log_info "Would install: Development Tools group via dnf"
            fi
            ;;
        "brew")
            log_info "Build tools included with Xcode Command Line Tools on macOS"
            ;;
    esac
}

install_starship() {
    if command -v starship &> /dev/null; then
        log_info "Starship already installed, skipping"
        return 0
    fi
    
    if [[ "$DRY_RUN" == "false" ]]; then
        log_info "Installing Starship via official installer..."
        curl -sS https://starship.rs/install.sh | sh -s -- --yes
        if command -v starship &> /dev/null; then
            log_success "Installed: starship"
        else
            log_warning "Starship installation may have failed"
        fi
    else
        log_info "Would install Starship via curl installer"
    fi
}

install_single_tool() {
    local tool="$1"
    local pkg_manager="$2"
    local optional="${3:-false}"
    
    # Special handling for Starship
    if [[ "$tool" == "starship" ]]; then
        if [[ "$pkg_manager" == "brew" ]]; then
            # Use Homebrew on macOS
            local package_name="starship"
        else
            # Use curl installer on other platforms
            install_starship
            return $?
        fi
    else
        local package_name="$(get_package_name "$tool" "$pkg_manager")"
    fi
    
    if [[ -z "$package_name" ]]; then
        if [[ "$optional" != "optional" ]]; then
            log_warning "Tool '$tool' not available for $pkg_manager"
        fi
        return 1
    fi
    
    # Check if already installed
    local cmd_name="$tool"
    if [[ "$tool" == "ripgrep" ]]; then
        cmd_name="rg"
    elif [[ "$tool" == "fd" && "$pkg_manager" == "apt" ]]; then
        cmd_name="fdfind"
    fi
    
    if command -v "$cmd_name" &> /dev/null; then
        log_info "Tool '$tool' already installed, skipping"
        return 0
    fi
    
    if [[ "$DRY_RUN" == "false" ]]; then
        case "$pkg_manager" in
            "brew")
                brew install "$package_name" || log_warning "Failed to install $tool"
                ;;
            "apt")
                sudo apt install -y "$package_name" || log_warning "Failed to install $tool"
                ;;
            "yum")
                sudo yum install -y "$package_name" || log_warning "Failed to install $tool"
                ;;
            "dnf")
                sudo dnf install -y "$package_name" || log_warning "Failed to install $tool"
                ;;
        esac
        
        if command -v "$cmd_name" &> /dev/null; then
            log_success "Installed: $tool"
        else
            log_warning "Installation may have failed: $tool"
        fi
    else
        log_info "Would install: $tool ($package_name) via $pkg_manager"
    fi
}

install_modern_tools() {
    local pkg_manager="$(detect_package_manager)"
    
    log_info "Installing modern tools for $OS_TYPE using $pkg_manager..."
    
    case "$pkg_manager" in
        "brew-missing")
            install_homebrew_first
            pkg_manager="brew"
            ;;
        "unsupported")
            log_error "Unsupported OS. Supported: macOS, Ubuntu/Debian, CentOS/RHEL"
            return 1
            ;;
    esac
    
    # Update package manager first
    update_package_manager "$pkg_manager"
    
    # Install build tools first (required for development)
    if [[ "$pkg_manager" != "brew" ]]; then
        log_info "Installing build tools..."
        install_build_tools "$pkg_manager"
    fi
    
    # Install development packages
    log_info "Installing development packages..."
    for package in "${DEV_PACKAGES[@]}"; do
        install_single_tool "$package" "$pkg_manager"
    done
    
    # Install development libraries
    log_info "Installing development libraries..."
    for library in "${DEV_LIBRARIES[@]}"; do
        install_single_tool "$library" "$pkg_manager"
    done
    
    # Install core modern tools
    log_info "Installing modern tools..."
    for tool in "${MODERN_TOOLS[@]}"; do
        install_single_tool "$tool" "$pkg_manager"
    done
    
    # Install optional tools
    log_info "Installing optional tools..."
    for tool in "${OPTIONAL_TOOLS[@]}"; do
        install_single_tool "$tool" "$pkg_manager" "optional"
    done
    
    log_success "Development environment installation completed!"
}

setup_modern_aliases() {
    local aliases_file="$GENERATED_DIR/zsh/modern-aliases"
    
    log_info "Setting up modern tool aliases..."
    
    if [[ "$DRY_RUN" == "false" ]]; then
        # Ensure generated zsh directory exists
        mkdir -p "$GENERATED_DIR/zsh"
        
        # Create modern aliases file
        cat > "$aliases_file" << 'EOF'
# Modern tool aliases (auto-generated)
# Generated by install.sh

# bat available for syntax highlighting (cat remains original)
if command -v bat &> /dev/null; then
    alias catp='bat --paging=never'
fi

# eza/exa available as separate commands (ls remains original)
if command -v eza &> /dev/null; then
    alias ll='eza -la --git'
    alias tree='eza --tree'
elif command -v exa &> /dev/null; then
    alias ll='exa -la --git'
    alias tree='exa --tree'
fi

# Enhanced find
if command -v fd &> /dev/null; then
    alias find='fd'
elif command -v fdfind &> /dev/null; then
    alias find='fdfind'
    alias fd='fdfind'
fi

# Enhanced grep
if command -v rg &> /dev/null; then
    alias grep='rg'
fi

# FZF integration
if command -v fzf &> /dev/null; then
    # Ctrl+R for command history search
    export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
    
    # Setup fzf key bindings and completions if available
    if [[ -f ~/.fzf.zsh ]]; then
        source ~/.fzf.zsh
    elif [[ -f /usr/share/fzf/key-bindings.zsh ]]; then
        source /usr/share/fzf/key-bindings.zsh
        source /usr/share/fzf/completion.zsh
    fi
fi

# GitHub CLI shortcuts
if command -v gh &> /dev/null; then
    alias ghpr='gh pr create'
    alias ghpv='gh pr view'
    alias ghis='gh issue create'
    alias ghiv='gh issue view'
fi
EOF
        log_success "Modern aliases configured: $aliases_file"
    else
        log_info "Would create modern aliases file: $aliases_file"
    fi
}

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
    -t, --install-tools         Install complete development environment (build tools, dev packages, modern tools)
    --skip-tools                Skip tools installation (default)
    --tools-only                Only install tools, skip dotfiles setup
    --modern-zsh                Use modern Zinit-based .zshrc instead of legacy version
    --dry-run                   Show what would be done without making changes
    -v, --verbose               Verbose output
    --help                      Show this help message

EXAMPLES:
    # Basic installation with auto-detection
    ./install.sh

    # Install with complete development environment
    ./install.sh --install-tools

    # Custom user and email with development environment
    ./install.sh --user-name "John Doe" --user-email "john@example.com" --install-tools

    # Ubuntu environment with development packages
    ./install.sh --user-name "Ubuntu User" --home-dir "/home/ubuntu" --install-tools

    # Install only development environment, skip dotfiles
    ./install.sh --tools-only

    # Dry run to see what would be installed
    ./install.sh --install-tools --dry-run

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
        -t|--install-tools)
            INSTALL_TOOLS=true
            shift
            ;;
        --skip-tools)
            INSTALL_TOOLS=false
            shift
            ;;
        --tools-only)
            INSTALL_TOOLS=true
            TOOLS_ONLY=true
            shift
            ;;
        --modern-zsh)
            USE_MODERN_ZSH=true
            shift
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
echo "  Install Tools: $INSTALL_TOOLS"
echo "  Tools Only:   $TOOLS_ONLY"
echo "  Modern Zsh:   $USE_MODERN_ZSH"
echo "  Dry Run:      $DRY_RUN"

if [[ "$DRY_RUN" == "true" ]]; then
    log_warning "DRY RUN MODE: No changes will be made"
fi

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATES_DIR="$SCRIPT_DIR/templates"

# External generation directory (XDG-compliant)
GENERATED_DIR="${XDG_CONFIG_HOME:-$HOME_DIR/.config}/dotfiles/generated"

# Create generation directory
create_generated_dir() {
    if [[ "$DRY_RUN" == "false" ]]; then
        mkdir -p "$GENERATED_DIR"
        mkdir -p "$GENERATED_DIR/zsh"
        log_success "Created generation directory: $GENERATED_DIR"
    else
        log_info "Would create generation directory: $GENERATED_DIR"
    fi
}

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
    
    if [[ "$DRY_RUN" == "false" ]]; then
        # Ensure output directory exists
        local output_dir="$(dirname "$output_file")"
        mkdir -p "$output_dir"
        
        # Use sed to replace placeholders
        sed -e "s|{{USER_NAME}}|$USER_NAME|g" \
            -e "s|{{USER_EMAIL}}|$USER_EMAIL|g" \
            -e "s|{{HOME_DIR}}|$HOME_DIR|g" \
            -e "s|{{OS_TYPE}}|$OS_TYPE|g" \
            -e "s|{{SHELL_TYPE}}|$SHELL_TYPE|g" \
            "$template_file" > "$output_file"
        log_success "Generated: $output_file"
    else
        log_info "Would generate: $output_file"
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
    log_info "Starting installation..."
    
    if [[ "$TOOLS_ONLY" != "true" ]]; then
        log_info "Setting up dotfiles..."
        
        # Update git submodules
        if [[ "$DRY_RUN" == "false" ]]; then
            git submodule update --init --recursive
            log_success "Updated git submodules"
        else
            log_info "Would update git submodules"
        fi
        
        # Create generation directory
        create_generated_dir
        
        # Process templates to external directory
        log_info "Processing templates to external directory..."
        
        # Generate .gitconfig from template
        process_template "$TEMPLATES_DIR/.gitconfig.template" "$GENERATED_DIR/.gitconfig"
        
        # Generate zsh configuration files
        process_template "$TEMPLATES_DIR/zsh_pipx.template" "$GENERATED_DIR/zsh/pipx"
        process_template "$TEMPLATES_DIR/zsh_android.template" "$GENERATED_DIR/zsh/android"
        
        # Generate modern .zshrc with Zinit
        process_template "$TEMPLATES_DIR/.zshrc.template" "$GENERATED_DIR/.zshrc_modern"
        
        # Generate Starship configuration
        process_template "$TEMPLATES_DIR/starship.toml.template" "$GENERATED_DIR/starship.toml"
        
        # Generate config file
        process_template "$SCRIPT_DIR/config.template.json" "$GENERATED_DIR/config.json"
        
        # Create symlinks
        log_info "Creating symlinks..."
        
        # Create symlinks for static files (from repository)
        create_symlink "$SCRIPT_DIR/.vimrc" "$HOME_DIR/.vimrc"
        create_symlink "$SCRIPT_DIR/.screenrc" "$HOME_DIR/.screenrc"
        create_symlink "$SCRIPT_DIR/.zshenv" "$HOME_DIR/.zshenv"
        create_symlink "$SCRIPT_DIR/.vim" "$HOME_DIR/.vim"
        create_symlink "$SCRIPT_DIR/.byobu" "$HOME_DIR/.byobu"
        create_symlink "$SCRIPT_DIR/.tmux.conf" "$HOME_DIR/.tmux.conf"
        create_symlink "$SCRIPT_DIR/nvim" "$HOME_DIR/.config/nvim"
        
        # Create symlinks for generated files (from external directory)
        create_symlink "$GENERATED_DIR/.gitconfig" "$HOME_DIR/.gitconfig"
        
        # Choose between modern Zinit-based .zshrc or legacy version
        if [[ "$USE_MODERN_ZSH" == "true" ]]; then
            create_symlink "$GENERATED_DIR/.zshrc_modern" "$HOME_DIR/.zshrc"
            log_info "Using modern Zinit-based .zshrc (generated)"
            
            # Starship configuration for modern zsh
            create_symlink "$GENERATED_DIR/starship.toml" "$HOME_DIR/.config/starship.toml"
        else
            create_symlink "$SCRIPT_DIR/.zshrc" "$HOME_DIR/.zshrc"
            log_info "Using legacy .zshrc (use --modern-zsh for Zinit version)"
        fi
        
        # SSH config (if exists)
        if [[ -f "$SCRIPT_DIR/private/.ssh_config" ]]; then
            create_symlink "$SCRIPT_DIR/private/.ssh_config" "$HOME_DIR/.ssh/config"
        fi
        
        log_success "Dotfiles setup completed!"
    fi
    
    # Install modern tools if requested
    if [[ "$INSTALL_TOOLS" == "true" ]]; then
        log_info "Installing modern development tools..."
        install_modern_tools
        setup_modern_aliases
    fi
    
    log_success "Installation completed!"
    log_info "Configuration saved to: $GENERATED_DIR/config.json"
    
    if [[ "$INSTALL_TOOLS" == "true" ]]; then
        log_info "Development environment installed. Includes:"
        log_info "  • Build tools and development libraries"
        log_info "  • Essential packages: git, curl, zsh, neovim, htop, tig, etc."
        log_info "  • Modern tools: bat, fd, ripgrep, fzf, jq, direnv, eza, gh"
        log_info "  • Enhanced aliases: find->fd, grep->rg, plus ll->eza"
        log_info "  • Complete setup for Python, Ruby, Node.js development"
    fi
    
    if [[ "$DRY_RUN" == "false" ]]; then
        log_info "Please restart your shell or run: source $HOME_DIR/.zshrc"
    fi
}

# Run main function
main