# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/kali/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git tmux fzf command-not-found jsontools python rails sudo nvm)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshrc='vim ~/.zshrc'
alias tmuxn='tmux new-session -s'
# alias v='vim'

alias u='cd ../'
alias uu='cd ../../'
alias uuu='cd ../../../'
alias uuuu='cd ../../../../'
alias uuuuu='cd ../../../../../'

alias bx='bundle exec'
alias rc='rails console'
alias rs='rails server'
alias bi='bundle install'

alias listening='lsof -Pan -i tcp -i udp'
alias rspec='rspec -fd'
alias extip='curl -4 http://icanhazip.com'
alias nl='npm list --depth=0'

alias l='exa --long --git --all -F'
alias open='thunar'

# git
alias gaa='g add -A'
alias gcm='git checkout master'
alias gcmsg='git commit -v -m'
alias gs='git status'
alias gsgd='git stash && git stash drop'
alias unstage='git reset HEAD'
alias gds='git diff --cached'
alias rebase-branch='git rebase -i `git merge-base master HEAD`'

mcd() {
    if [ ! -n "$1" ]; then
        echo "Enter a directory name"
    elif [ -d $1 ]; then
        echo "\`$1' already exists"
    else
        mkdir $1 && cd $1
    fi
}
colortest() {
    T='gYw'   # The test text
    echo -e "\n                 40m     41m     42m     43m     44m     45m     46m     47m";
    for FGs in '    m' '   1m' '  30m' '1;30m' '  31m' '1;31m' '  32m' '1;32m' '  33m' '1;33m' '  34m' '1;34m' '  35m' '1;35m' '  36m' '1;36m' '  37m' '1;37m';
    do FG=${FGs// /}
        echo -en " $FGs \033[$FG  $T  "
        for BG in 40m 41m 42m 43m 44m 45m 46m 47m;
        do echo -en "$EINS \033[$FG\033[$BG  $T \033[0m\033[$BG \033[0m";
        done
        echo;
    done
    echo
}
# z() {
#   local dir
#   dir="$(fasd -Rdl "$1" | fzf -1 -0 --no-sort +m)" && cd "${dir}" || return 1
# }

if which fasd >/dev/null; then
    # install fasd hooks and basic aliases in the shell
    eval "$(fasd --init auto)"

    # if there is fzf available use it to search fasd results
    if which fzf >/dev/null; then

        alias v >/dev/null && unalias v
        alias vd >/dev/null && unalias vd
        alias z >/dev/null && unalias z

        # edit given file or search in recently used files
        function v {
            local file
            # if arg1 is a path to existing file then simply open it in the editor
            test -e "$1" && $EDITOR "$@" && return
            # else use fasd and fzf to search for recent files
            file="$(fasd -Rfl "$*" | fzf -1 -0 --no-sort +m)" && $EDITOR "${file}" || $EDITOR "$@"
        }

        # cd into the directory containing a recently used file
        function vd {
            local dir
            local file
            file="$(fasd -Rfl "$*" | fzf -1 -0 --no-sort +m)" && dir=$(dirname "$file") && cd "$dir"
        }

        # cd into given dir or search in recently used dirs
        function z {
            [ $# -eq 1 ] && test -d "$1" && cd "$1" && return
            local dir
            dir="$(fasd -Rdl "$*" | fzf -1 -0 --no-sort +m)" && cd "${dir}" || return 1
        }
    fi
fi
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte-2.91.sh
fi
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
PATH="$(python3 -m site --user-base)/bin:${PATH}"
