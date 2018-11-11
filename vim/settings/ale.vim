let g:ale_sign_error = '✖'
hi ALEErrorSign guifg=#DF8C8C
let g:ale_sign_warning = '●'
hi ALEWarningSign guifg=#F2C38F

let g:ale_lint_on_enter = 0
let g:ale_fix_on_save = 0

let g:ale_linters = {
\   'javascript': ['eslint'],
\   'ruby' : ['rubocop']
\}

let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'ruby' : ['rubocop']
\}

nmap <leader>af <Plug>(ale_fix)
nmap <silent> <leader>aj :ALENext<cr>
nmap <silent> <leader>ak :ALEPrevious<cr>
nmap <leader>at :ALEToggle<cr>
