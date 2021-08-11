call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdtree'
call plug#end()

colorscheme gruvbox
syntax on

set shiftwidth=4
set tabstop=4
set expandtab
set softtabstop=4
set background=dark
set number
set mouse=a
set title
set encoding=utf-8

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
nnoremap <S-Tab> <<
nnoremap <Tab> >>
nnoremap <C-s> :w <cr>
nnoremap <C-q> :q <cr>
nnoremap <C-a> ggvG$
