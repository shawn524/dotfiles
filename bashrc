#[ -n "$PS1" ] && source ~/.bash_profile

alias tmuxn='tmux new-session -s'
alias tmuxc=tmuxc
alias pgstart='postgres -D /usr/local/var/postgres'

alias bx='bundle exec'
alias g='git'
alias gaa='g add -A'
alias gcm='g commit -m'
alias gs='g status'
alias gcb='g checkout -b'
alias gfu='g fetch upstream'
alias gm='g merge'
alias rc='rails console'
alias rs='rails server'
alias bi='bundle install'
alias v='vim'
alias mysqlstart='mysql.server start'
alias u='cd ../'
alias uu='cd ../../'
alias uuu='cd ../../../'
alias uuuu='cd ../../../../'
alias uuuuu='cd ../../../../../'

function _update_ps1() {
    PS1="$(~/.bash_extensions/powerline-shell/powerline-shell.py --cwd-max-depth 4 $? 2> /dev/null)"
}

if [ "$TERM" != "linux" ]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

export EDITOR='vim'
