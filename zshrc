# Load tmux at start
if [ "$TMUX" = "" ]; then 
  tmux; 
fi

# Path to your oh-my-zsh installation.
export ZSH=/Users/admin/.oh-my-zsh
export EDITOR='vim'

# load Z
. ~/.dotfiles/zsh/z.sh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="shawn"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

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
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git github brew rails docker npm bower osx z aws)

# User configuration

export PATH="/usr/local/opt/coreutils/libexec/gnubin:/usr/local/heroku/bin:/usr/local/heroku/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/go/bin"
eval "$(rbenv init - zsh)"


export AWS_DEFAULT_REGION=us-east-1
export AWS_ACCOUNT_ID=882999641681

# export MANPATH="/usr/local/man:$MANPATH"
# export NVM_DIR=~/.nvm
#   . $(brew --prefix nvm)/nvm.sh

source $ZSH/oh-my-zsh.sh

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

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias ohmyzsh="mate ~/.oh-my-zsh"
#


alias zshrc="vim ~/.zshrc"
alias vimrc="vim ~/.vimrc"
alias reload=". ~/.zshrc && echo 'zshrc reloaded'"
alias tmuxn='tmux new-session -s'
alias pgstart='postgres -D /usr/local/var/postgres'
alias v='mvim -v'
alias vim='mvim -v'

alias gs='git status'
alias bx='bundle exec'
alias rc='rails console'
alias rs='rails server'
alias bi='bundle install'
alias mysqlstart='mysql.server start'
alias u='cd ../'
alias uu='cd ../../'
alias uuu='cd ../../../'
alias uuuu='cd ../../../../'
alias uuuuu='cd ../../../../../'
export GOPATH='/Users/admin/code/go'

alias wttr="curl -4 http://wttr.in/"
alias listening="lsof -Pan -i tcp -i udp"
alias code="cd ~/code"
alias rspec="rspec -fd"
alias afk='/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend'
alias subl='sublime'
alias ip='curl -4 http://icanhazip.com'
alias nl='npm list --depth=0'
alias gedit="vim -p $(git status --porcelain | awk '{print $2}')"

##########################################
############### Functions ################
##########################################

#Docker
function dockload() {
  eval "$(docker-machine env default)"
}

function gitme() {
  local url=$1
  local pathname=$2
  # replace tree/master with trunk
  svn checkout ${url/tree\/master/trunk} $pathname
  # remove the svn folder
  if [ -z "$2" ]; then
    rm -rf "$(basename $url)/.svn"
  else
    rm -rf "$pathname/.svn"
    echo "deleting $pathname/.svn"
  fi
}

function mcd {
  if [ ! -n "$1" ]; then
    echo "Enter a directory name"
  elif [ -d $1 ]; then
    echo "\`$1' already exists"
  else
    mkdir $1 && cd $1
  fi
}

function taillogs() {
   tail -f "$BASIN_DIR/log/fluentd.log" "$BASIN_DIR/src/manta/log/development.log" "$BASIN_DIR/src/manta/log/development_json.log" "$BASIN_DIR/src/snapper/log/development.log" "$BASIN_DIR/src/snapper/log/development_json.log" "$BASIN_DIR/src/bluefin/log/development.log" "$BASIN_DIR/src/bluefin/log/development_json.log" "/tmp/basin-nginx/nginx-error.log"
}

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh
export PATH="/usr/local/opt/node@8/bin:$PATH"
