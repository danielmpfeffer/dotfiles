set nocompatible
syntax on

filetype plugin indent on

set mouse=a
set number

set tabstop=4 
set shiftwidth=4
set expandtab

set hidden

let g:tex_flavor = 'latex'
let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_method = 'latexmk'

" Show matching parenthesis
set showmatch
