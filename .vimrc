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

" Tab completion and pairs (From: F.A.Q & Common Issues)
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction
 
function! NextCharIsPair() abort
  return index([')', ']', '}', '>', "'", '"', '`'], getline('.')[col('.') - 1]) >= 0
endfunction
 
inoremap <silent><expr> <Tab>
  \ coc#pum#visible() ? coc#pum#select_confirm() :
  \ coc#inline#visible() ? coc#inline#accept() :
  \ coc#expandableOrJumpable() ?
  \ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
  \ NextCharIsPair() ? "\<Right>" :
  \ CheckBackspace() ? "\<Tab>" :
  \ coc#refresh()
 
let g:coc_snippet_next = '<Tab>'
