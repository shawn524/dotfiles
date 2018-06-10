alias tmuxn='tmux new-session -s'
alias pgstart='postgres -D /usr/local/var/postgres'
alias mysqlstart='mysql.server start'

alias u='cd ../'
alias uu='cd ../../'
alias uuu='cd ../../../'
alias uuuu='cd ../../../../'
alias uuuuu='cd ../../../../../'

alias gaa='g add -A'
alias v='vim'
alias gs='git status'
alias bx='bundle exec'
alias rc='rails console'
alias rs='rails server'
alias bi='bundle install'

alias wttr="curl -4 http://wttr.in/"
alias listening="lsof -Pan -i tcp -i udp"
alias code="cd ~/code"
alias rspec="rspec -fd"
alias afk='/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend'
alias subl='sublime'
alias ip='curl -4 http://icanhazip.com'
alias nl='npm list --depth=0'

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
