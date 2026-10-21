" General settings
set nocompatible
set history=1000
set mouse=a
set hidden
filetype plugin indent on

" Visuals
syntax on
set background=dark
colorscheme slate
set number

" Tabs and indentation
set expandtab
set tabstop=4 
set shiftwidth=4
set autoindent

" Performance tweaks for coc.nvim
set updatetime=300

let g:tex_flavor = 'latex'
let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_method = 'latexmk'
let g:vimtex_compiler_latexmk_engines = {
    \ '_' : '-lualatex',
    \}
