#!/bin/bash
############################
# dotfiles.sh
# This script install or uninstall dotfiles
# Shamelessly stolen from https://github.com/reenjii/dotfiles.git
############################

########## Variables

# dotfiles folder
DOTFILES="$HOME/.dotfiles"
BACKUP="$DOTFILES/backup"

# ohmyzsh install folder
OH_MY_ZSH="$HOME/.oh-my-zsh"

##########


########## Functions

# Check that a given command exists
need_cmd() {
    if ! hash "$1" &>/dev/null; then
        error "$1 is needed (command not found)"
        exit 1
    fi
    success "$1 check"
}

### Display
COLOR_OFF='\033[0m' # Text Reset
RED='\033[0;31m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
msg()      { printf '%b\n' "$1" >&2; }
success() { msg "${GREEN}[✔]${COLOR_OFF} $1"; }
info()    { msg "${BLUE}[ℹ]${COLOR_OFF} $1"; }
warn()    { msg "${RED}[✘]${COLOR_OFF} $1"; }
error()   { msg "${RED}[✘]${COLOR_OFF} $1"; exit 1; }

# Clones or updates a git repository
# $1 = repository
# $2 = directory absolute path
function fetch_repo {
    local repo=$1
    local dir=$2
    if [[ -d "$dir" ]]; then
        info "Update $dir"
        git -C "$dir" pull
    else
        info "Clone $repo"
        git clone --depth=1 "$repo" "$dir"
    fi
}

# Creates a symbolic link
# $1 = target
# $2 = link name
function make_link {
    local target=$1
    local linkname=$2
    if [[ -L "$linkname" ]]; then
        local linktarget=$(readlink "$linkname")
        if [[ "$linktarget" != "$target" ]]; then
            warn "$linkname is a symbolic link to $linktarget but should target $target instead"
        else
            success "$linkname config file"
        fi
    else
        if [[ -e "$linkname" ]]; then
            warn "$linkname already exists but is not a symbolic link"
            warn "Please remove $linkname to install $target config file"
        else
            info "Install $target config file"
            ln -v -s "$target" "$linkname"
        fi
    fi
}

# Deletes a symbolic link
# $1 = target
# $2 = link name
function unmake_link {
    local target=$1
    local linkname=$2
    if [[ -L "$linkname" ]]; then
        local linktarget=$(readlink "$linkname")
        if [[ "$linktarget" =~ "$target" ]]; then
            rm -v "$linkname"
            success "Removed $target config file"
        fi
    fi
}

# move to backup with timestamp
# $1 = target
function backup {
    local target=$1
    if [[ -e "$target" ]]; then
        basename=$(basename $target)
        cp -L $target "$BACKUP/`date +%y%m%d_%H%M%S`.$basename"
        rm  $target
    fi
}

##########


########## Script
usage () {
    echo "dotfiles install script"
    echo ""
    echo "Usage : dotfiles (install|uninstall)"
}

if [[ $# -gt 0 ]]; then
    case $1 in
        install|i)
            info "Install dotfiles"

            # Needed commands
            need_cmd 'git'
            need_cmd 'curl'
            need_cmd 'ln'

            # Install or update required programs
            # zsh
            if ! grep -q zsh /etc/shells ; then
                info "installing zsh...";
                sudo apt --yes install zsh
            else success "zsh check"
            fi
            # tilix
            if ! grep -q tilix /usr/bin/tilix ; then
                info "installing tilix...";
                sudo apt --yes install tilix
                make_link "/usr/share/tilix/schemes/nord.json" "$DOTFILES/colors/tilix/nord.json"
            else success "tilix check"
            fi
            # vim
            if ! grep -q vim /usr/bin/vim ; then
                info "installing vim...";
                sudo apt --yes install vim-gtk3
            else success "vim check"
            fi
            # tmux
            if ! grep -q tmux /usr/bin/tmux ; then
                info "installing tmux...";
                sudo apt --yes install tmux
            else success "tmux check"
            fi
            # fzf
            if ! grep -q fzf /usr/bin/fzf ; then
                info "installing fzf...";
                sudo apt --yes install fzf
            else success "fzf check"
            fi
            # fasd
            if ! grep -q fasd /usr/bin/fasd ; then
                info "installing fasd...";
                sudo apt --yes install fasd
            else success "fasd check"
            fi
            # bat
            if ! grep -q batcat /usr/bin/batcat ; then
                info "installing batcat...";
                sudo apt --yes install batcat
                make_link "/usr/bin/batcat" "$HOME/.local/bin/bat"
            else success "batcat check"
            fi
            # fd
            if ! grep -q fdfind /usr/bin/fdfind ; then
                info "installing fdfind...";
                sudo apt --yes install fdfind
                make_link "/usr/bin/fdfind" "$HOME/.local/bin/fd"
            else success "fdfind check"
            fi
            # exa
            if ! grep -q exa /usr/bin/exa ; then
                info "installing exa...";
                sudo apt --yes install exa
            else success "exa check"
            fi
            # rg
            if ! grep -q rg /usr/bin/rg ; then
                info "installing rg...";
                sudo apt --yes install rg
            else success "rg check"
            fi
            # direnv
            if ! grep -q direnv /usr/bin/direnv ; then
                info "installing direnv...";
                sudo apt --yes install direnv
            else success "direnv check"
            fi


            # Install oh-my-zsh
            fetch_repo "git://github.com/ohmyzsh/ohmyzsh.git" "$OH_MY_ZSH"
            # Install powerlevel10k for zsh
            fetch_repo https://github.com/romkatv/powerlevel10k.git "$OH_MY_ZSH/custom/themes/powerlevel10k"
            make_link "$DOTFILES/zsh/.p10k.zsh" "$HOME/.p10k.zsh"
            # Install zsh-syntax-highlighting
            fetch_repo https://github.com/zsh-users/zsh-syntax-highlighting.git "$OH_MY_ZSH/custom/plugins/zsh-syntax-highlighting"
            # Install zsh-autosuggestions
            fetch_repo https://github.com/zsh-users/zsh-autosuggestions "$OH_MY_ZSH/custom/plugins/zsh-autosuggestions"

            # zsh
            backup "$HOME/.zsh"
            make_link "$DOTFILES/zsh" "$HOME/.zsh"
            backup "$HOME/.zshrc"
            make_link "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"

            # tmux
            backup "$HOME/.tmux"
            make_link "$DOTFILES/tmux" "$HOME/.tmux"
            backup "$HOME/.tmux.conf"
            make_link "$DOTFILES/tmux/.tmux.conf" "$HOME/.tmux.conf"

            # vim
            backup "$HOME/.vim"
            make_link "$DOTFILES/vim" "$HOME/.vim"
            backup "$HOME/.vimrc"
            make_link "$DOTFILES/vim/.vimrc" "$HOME/.vimrc"

            # git
            backup "$HOME/.gitconfig"
            make_link "$DOTFILES/git/.gitconfig" "$HOME/.gitconfig"
            backup "$HOME/.gitignore_global"
            make_link "$DOTFILES/git/.gitignore_global" "$HOME/.gitignore_global"

            info "Install complete"
            exit 0
            ;;
        uninstall|u)
            info "Uninstall dotfiles"

            # Needed commands
            need_cmd 'git'
            need_cmd 'curl'
            need_cmd 'ln'

            # We leave oh-my-zsh repo

            unmake_link "$DOTFILES/zsh" "$HOME/.zsh"
            unmake_link "$DOTFILES/zshrc" "$HOME/.zshrc"
            unmake_link "$DOTFILES/zsh/.p10k.zsh" "$HOME/.p10k.zsh"
            unmake_link "$DOTFILES/tmux" "$HOME/.tmux"
            unmake_link "$DOTFILES/tmux/.tmux.conf" "$HOME/.tmux.conf"
            unmake_link "$DOTFILES/vim" "$HOME/.vim"
            unmake_link "$DOTFILES/vim/.vimrc" "$HOME/.vimrc"
            unmake_link "$DOTFILES/git/.gitconfig" "$HOME/.gitconfig"
            unmake_link "$DOTFILES/git/.gitignore_global" "$HOME/.gitignore_global"

            info "Uninstall complete"
            exit 0
            ;;
        --help|-h)
            usage
            exit 0
            ;;
        *)
            usage
            exit 0
            ;;
    esac
fi

usage

