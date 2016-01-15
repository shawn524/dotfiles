#  _              _                        __ _ _
# | |__  __ _ ___| |__    _ __  _ __ ___  / _(_) | ___
# | '_ \ / _` / __| '_ \  | '_ \| '__/ _ \| |_| | |/ _ \
# | |_) | (_| \__ \ | | | | |_) | | | (_) |  _| | |  __/
# |_.__/ \__,_|___/_| |_| | .__/|_|  \___/|_| |_|_|\___|
#                         |_|


# =================
# Path
# =================

# A list of all directories in which to look for commands,
# scripts and programs
PATH="$HOME/.rbenv/bin:$PATH"                              # RBENV
PATH="/usr/local/share/npm/bin:$PATH"                      # NPM
PATH="/usr/local/bin:/usr/local/sbin:$PATH"                # Homebrew
PATH="/usr/local/heroku/bin:$PATH"                         # Heroku Toolbelt
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"       # Coreutils
MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH" # Manual pages

# =================
# Settings
# =================

# Prefer US English
export LC_ALL="en_US.UTF-8"
# use UTF-8
export LANG="en_US"

# =================
# History
# =================

# http://jorge.fbarr.net/2011/03/24/making-your-bash-history-more-efficient/
# Larger bash history (allow 32³ entries; default is 500)
export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE

# don't put duplicate lines in the history.
export HISTCONTROL=ignoredups

# ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# Make some commands not show up in history
export HISTIGNORE="h"

# ====================
# Aliases
# ====================

## 'ls' lists information about files.
# By default, show slashes for directories.
alias ls='ls -F'

# Enhanced ls, grouping directories and using colors.
alias lf='ls --color -h --group-directories-first -F'

# Long list format including hidden files and file information.
alias ll='ls --color -h --group-directories-first -Fla'

# List ACLs (finer-grained permissions that can be inherited).
# ACLs are a necessary part of OSX fs since 10.6; see
# - ACLs on OSX: https://goo.gl/PhkcA2
# - OSX chmod manpage: https://goo.gl/vJqgZ9
#
# Note: The default ls on 10.7+ OSX is the GNU coreutils version at:
# /usr/local/opt/coreutils/libexec/gnubin/ls; in order to see the
# ACL permissions, we must use the BSD version available at: /bin/ls
alias lacl='/bin/ls -GFlae'

# History lists your previously entered commands
alias h='history'

# If we make a change to our bash profile we need to reload it
alias reload="clear; source ~/.bash_profile"

# Execute verbosely
alias cp='cp -v'
alias mv='mv -v'
alias rm='rm -v'
alias mkdir='mkdir -pv'

# =================
# Change System Settings
# =================

# Hide/show all desktop icons (useful when presenting)
alias hide_desktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias show_desktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# Hide/show hidden files in Finder
alias hide_files="defaults write com.apple.finder AppleShowAllFiles FALSE && killall Finder"
alias show_files="defaults write com.apple.finder AppleShowAllFiles TRUE && killall Finder"

# ================
# Application Aliases
# ================

alias chrome='open -a "Google Chrome"'

# =================
# rbenv
# =================

# start rbenv (our Ruby environment and version manager) on open
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# =================
# nvm (load io.js as node)
# =================

export NVM_DIR=~/.nvm
source ~/.nvm/nvm.sh
# nvm use stable > /dev/null # PJ: using .nvmrc to set this... uncomment if not working

# =================
# Functions
# =================

#######################################
# Set ACL permissions to inherit and
# allow read, write and update actions.
#
# Arguments:
#   1. Group Name
#   2. Directory Path
#######################################

allow_group() {
  local GROUP_NAME="$1"
  local TARGET_DIR="$2"
  local PERMISSIONS="read,write,delete,add_file,add_subdirectory"
  local INHERITANCE="file_inherit,directory_inherit"

  sudo mkdir -p "$TARGET_DIR"
  sudo /bin/chmod -R -N "$TARGET_DIR"
  sudo /bin/chmod -R +a "group:$GROUP_NAME:allow $PERMISSIONS,$INHERITANCE" "$TARGET_DIR"
}

#######################################
# Start an HTTP server from a directory
# Arguments:
#  Port (optional)
#######################################

server() {
  local port="${1:-8000}"
  (sleep 2 && open "http://localhost:${port}/")&

  # Simple Pythong Server:
  # python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"

  # Simple Ruby Webrick Server:
  ruby -e "require 'webrick';server = WEBrick::HTTPServer.new(:Port=>${port},:DocumentRoot=>Dir::pwd );trap('INT'){ server.shutdown };server.start"
}

#######################################
# List any open internet sockets on
# several popular ports. Useful if a
# rogue server is running.
# - http://www.akadia.com/services/lsof_intro.html
# - http://en.wikipedia.org/wiki/List_of_TCP_and_UDP_port_numbers
#
# No Arguments.
#######################################

rogue() {
  # add or remove ports to check here!
  local PORTS="3000 4567 6379 8000 8888 27017"
  local MESSAGE="> Checking for processes on ports"
  local COMMAND="lsof"

  for PORT in $PORTS; do
    MESSAGE="${MESSAGE} ${PORT},"
    COMMAND="${COMMAND} -i TCP:${PORT}"
  done

  echo "${MESSAGE%?}..."
  local OUTPUT="$(${COMMAND})"

  if [ -z "$OUTPUT" ]; then
    echo "> Nothing running!"
  else
    echo "> Processes found:"
    printf "\n$OUTPUT\n\n"
    echo "> Use the 'kill' command with the 'PID' of any process you want to quit."
    echo
  fi
}


# bash/zsh completion support for core Git.
if [ -f ~/.git-completion.bash ]; then
  source ~/.git-completion.bash
fi

# ====================================
# Environmental Variables and API Keys
# ====================================

# Below here is an area for other commands added by outside programs or
# commands. Attempt to reserve this area for their use!
##########################################################################

export HOMEBREW_EDITOR=nano
export NODE_REPL_HISTORY_FILE=~/.node_repl_history

if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi
