" ========================================
" Vim plugin configuration
" ========================================
"
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

source ~/.vim/plugins/appearance.plug
source ~/.vim/plugins/git.plug
source ~/.vim/plugins/improvements.plug
source ~/.vim/plugins/languages.plug
source ~/.vim/plugins/search.plug

call plug#end()
