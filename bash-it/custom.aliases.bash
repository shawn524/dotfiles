alias tmuxn='tmux new-session -s'
alias pgstart='postgres -D /usr/local/var/postgres'
alias mysqlstart='mysql.server start'

alias u='cd ../'
alias uu='cd ../../'
alias uuu='cd ../../../'
alias uuuu='cd ../../../../'
alias uuuuu='cd ../../../../../'

alias gaa='g add -A'
alias gcm='git checkout master'
alias gcmsg='git commit -v -m'
alias v='vim'
alias gs='git status'
alias bx='bundle exec'
alias rc='rails console'
alias rs='rails server'
alias bi='bundle install'
alias gsgd='git stash && git stash drop'

alias listening="lsof -Pan -i tcp -i udp"
alias code="cd ~/code"
alias rspec="rspec -fd"
alias ip='curl -4 http://icanhazip.com'
alias nl='npm list --depth=0'

alias dcrun='sudo docker-compose -f /home/admin/code/docker/docker-compose.yml '
alias dclogs='sudo docker-compose -f /home/admin/code/docker/docker-compose.yml logs -tf --tail="100" '

alias l='exa --long --git --all'
alias e='exa --long --git --all'

# Functions
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

function wttr {
    curl -H "Accept-Language: ${LANG%_*}" wttr.in/"${2:-Danbury}"
}

function emojibanner {
if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: emojibanner Lunch hamburger blank"
    return 1
 else
    figlet -f banner "${1}" | sed -e"s/#/:${2}:/g" | sed -e"s/ /:${3:-blank}:/g" | pbcopy
fi
}

# OSX
if [[ "$OSTYPE" == "darwin"* ]]; then
    alias afk='/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend'
    export PATH="/usr/local/opt/coreutils/libexec/gnubin:/usr/local/heroku/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/go/bin"
    export PATH="/usr/local/opt/node@8/bin:$PATH"
    export PATH="$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH"
    export AWS_DEFAULT_REGION=us-east-1
    export AWS_ACCOUNT_ID=882999641681
    export BASIN_DIR="/Users/admin/code/basin"

    function taillogs() {
        tail -f "$BASIN_DIR/log/fluentd.log" "$BASIN_DIR/src/manta/log/development.log" "$BASIN_DIR/src/manta/log/development_json.log" "$BASIN_DIR/src/snapper/log/development.log" "$BASIN_DIR/src/snapper/log/development_json.log" "$BASIN_DIR/src/bluefin/log/development.log" "$BASIN_DIR/src/bluefin/log/development_json.log" "/tmp/basin-nginx/nginx-error.log"
    }
fi
