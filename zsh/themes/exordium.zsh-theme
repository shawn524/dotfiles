# Zsh options
setopt prompt_subst
autoload -U colors && colors

# Colors
BLACK=$'\033[0m'
GREEN=$'\033[38;5;148m'
BLUE=$'\033[38;5;117m'
DARK_BLUE='\033[38;5;4m'

current_git_branch() {
    git rev-parse --abbrev-ref HEAD 2> /dev/null | sed -e 's/\(.*\)/(\1)/g'
}

current_directory() {
    PROMPT_PATH=""
    CURRENT=`dirname ${PWD}`
    if [[ $CURRENT = / ]]; then
        PROMPT_PATH=""
    elif [[ $PWD = $HOME ]]; then
        PROMPT_PATH=""
    else
        GIT_REPO_PATH=$(git rev-parse --show-toplevel 2>/dev/null)
        if [[ -d $GIT_REPO_PATH ]]; then
            # We are in a git repo. Display the root in color, then the path
            # starting from the root.
            if [[ $PWD -ef $GIT_REPO_PATH ]]; then
                # We are at the root of the git repo.
                PROMPT_PATH=""
            else
                # We are not at the root of the git repo.
                BASE=$(basename $GIT_REPO_PATH)
                GIT_ROOT="%{$fg_bold[red]%}%{$DARK_BLUE%}${BASE}%{$reset_color%}"
                REAL_PWD=$PWD:A
                PATH_TO_CURRENT="${REAL_PWD#$GIT_REPO_PATH}"
                PATH_TO_CURRENT="%{$BLUE%}${PATH_TO_CURRENT%/*}%{$reset_color%}"
                PROMPT_PATH="${GIT_ROOT}${PATH_TO_CURRENT}/"
            fi
        else
            # We are not in a git repo.
            PATH_TO_CURRENT=$(print -P %3~)
            PATH_TO_CURRENT="%{$BLUE%}${PATH_TO_CURRENT%/*}%{$reset_color%}"
            PROMPT_PATH="${PATH_TO_CURRENT}/"
        fi
    fi
    echo "${PROMPT_PATH}%{$reset_color%}%{$fg_bold[red]%}%{$BLUE%}%1~%{$reset_color%}"
}

export PROMPT=$'$(current_directory) %{$GREEN%}$(current_git_branch)%{$BLACK%}%# '

