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
set updatetime=500

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
  \ NextCharIsPair() ? "\<Right>" :
  \ CheckBackspace() ? "\<Tab>" :
  \ coc#refresh()

" Show type signatures / parameter info automatically while typing
autocmd CursorMovedI *.hs silent! call CocActionAsync('showSignatureHelp')

" Config for vim-which-key
let g:mapleader = "\<Space>"
let g:maplocalleader = ','
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>

let g:which_key_map = {}
let g:which_key_map['w'] = {
      \ 'name' : '+windows' ,
      \ 'w' : ['<C-W>w'     , 'other-window']          ,
      \ 'd' : ['<C-W>c'     , 'delete-window']         ,
      \ '-' : ['<C-W>s'     , 'split-window-below']    ,
      \ '|' : ['<C-W>v'     , 'split-window-right']    ,
      \ '2' : ['<C-W>v'     , 'layout-double-columns'] ,
      \ 'h' : ['<C-W>h'     , 'window-left']           ,
      \ 'j' : ['<C-W>j'     , 'window-below']          ,
      \ 'l' : ['<C-W>l'     , 'window-right']          ,
      \ 'k' : ['<C-W>k'     , 'window-up']             ,
      \ 'H' : ['<C-W>5<'    , 'expand-window-left']    ,
      \ 'J' : [':resize +5'  , 'expand-window-below']   ,
      \ 'L' : ['<C-W>5>'    , 'expand-window-right']   ,
      \ 'K' : [':resize -5'  , 'expand-window-up']      ,
      \ '=' : ['<C-W>='     , 'balance-window']        ,
      \ 's' : ['<C-W>s'     , 'split-window-below']    ,
      \ 'v' : ['<C-W>v'     , 'split-window-below']    ,
      \ '?' : ['Windows'    , 'fzf-window']            ,
      \ }
call which_key#register('<Space>', "g:which_key_map")
