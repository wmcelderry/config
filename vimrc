set background=dark
set number
set nowrap
set cindent

set tabstop=2
set shiftwidth=2
set noexpandtab

" git bindings?
" bindings?
" retabulate on Ctl-Space

nnoremap	<C-@> :%retab!

set autochdir

"useful: autocmd! bufwritepost .vimrc source %


" nnoremap <Leader>s :let @x=@" \| let @"=@a \| let @a=@b \| let @b=@x<CR>
" nnoremap <Leader>s :let @x=@" \| let @"=@a \| let @a=@b \| let @b=@x<CR>
" move the data in " to z
" delete the movement command, past the data in z.
nnoremap _a :let @z=@"
nnoremap _b dw"zP

" Easier working with tabs.
nnoremap tn :tabn<CR>
nnoremap tp :tabp<CR>
