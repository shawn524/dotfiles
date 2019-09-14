let g:fzf_command_prefix = 'Fzf'
let g:fzf_buffers_jump = 1


nnoremap <silent> ,ff :FzfFiles<CR>

" Additional mapping for buffer search
nnoremap <silent> ,fb :FzfBuffers<cr>
nnoremap <silent> ,fh :FzfHistory<cr>
nnoremap <silent> ,fl :FzfLines<cr>

" Idea from : http://www.charlietanksley.net/blog/blog/2011/10/18/vim-navigation-with-lustyexplorer-and-lustyjuggler/
" Rails
map ,ja :FzfFiles app/assets<CR>
map ,jm :FzfFiles app/models<CR>
map ,jc :FzfFiles app/controllers<CR>
map ,jv :FzfFiles app/views<CR>
map ,jh :FzfFiles app/helpers<CR>
map ,jl :FzfFiles lib<CR>
map ,jp :FzfFiles public<CR>
map ,js :FzfFiles spec<CR>
map ,jf :FzfFiles fast_spec<CR>
map ,jd :FzfFiles db<CR>
map ,jC :FzfFiles config<CR>
map ,jV :FzfFiles vendor<CR>
map ,jF :FzfFiles factories<CR>
map ,jT :FzfFiles test<CR>

" Stingray
map ,fn :FzfFiles frontend<CR>
