" theme
colorscheme nord
set background=dark
let base16colorspace=256  " Access colors present in 256 colorspace"

" airline·
let g:airline_powerline_fonts = 1
set laststatus=2
let g:airline_theme='nord'

" cursor line
highlight Cursor guifg=white guibg=black
highlight iCursor guifg=white guibg=steelblue
set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait10

" Fix Cursor in TMUX
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Enable basic mouse behavior such as resizing buffers.
if exists('$TMUX')  " Support resizing in tmux
  set ttymouse=xterm2
endif

" devicons
set guifont=DroidSansMono_Nerd_Font:h11
