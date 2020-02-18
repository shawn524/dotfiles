alias tmuxn='tmux new-session -s'
alias pgstart='postgres -D /usr/local/var/postgres'
alias mysqlstart='mysql.server start'

alias u='cd ../'
alias uu='cd ../../'
alias uuu='cd ../../../'
alias uuuu='cd ../../../../'
alias uuuuu='cd ../../../../../'

alias v='vim'
alias bx='bundle exec'
alias rc='rails console'
alias rs='rails server'
alias bi='bundle install'

alias listening="lsof -Pan -i tcp -i udp"
alias code="cd ~/code"
alias rspec="rspec -fd"
alias extip='curl -4 http://icanhazip.com'
alias nl='npm list --depth=0'

alias dcrun='sudo docker-compose -f /home/admin/code/docker-media-server/docker-compose.yml '
alias dclogs='sudo docker-compose -f /home/admin/code/docker-media-server/docker-compose.yml logs -tf --tail="100" '

alias l='exa --long --git --all -F'
alias e='exa --long --git --all -F'
alias r='ranger'

# git
alias gaa='g add -A'
alias gcm='git checkout master'
alias gcmsg='git commit -v -m'
alias gs='git status'
alias gsgd='git stash && git stash drop'
alias unstage='git reset HEAD'
alias gds="git diff --cached"
alias rebase-branch="git rebase -i `git merge-base master HEAD`"

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
    local request="wttr.in/${1-Danbury}"
    [ "$COLUMNS" -lt 125 ] && request+='?n'
    curl -H "Accept-Language: ${LANG%_*}" --compressed "$request"
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

function colortest {
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

function git-clean-repo {
    git checkout master &> /dev/null
    git fetch
    git remote prune origin
    git branch --merged origin/master | grep -v 'master$' | gsed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g" | xargs git branch -d

    # Now the same, but including remote branches.
    # MERGED_ON_REMOTE=`git branch -r --merged origin/master | sed 's/ *origin\///' | grep -v 'master$'`
    if [ "$MERGED_ON_REMOTE" ]; then
        echo "The following remote branches are fully merged and will be removed:"
        echo $MERGED_ON_REMOTE

        read -p "Continue (y/N)? "
        if [ "$REPLY" == "y" ]; then
            git branch -r --merged origin/master | sed 's/ *origin\///' \
                | grep -v 'master$' | xargs -I% git push origin :% 2>&1 \
                | grep --colour=never 'deleted'
            echo "Done!"
        fi
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
