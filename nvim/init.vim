call plug#begin()
Plug 'junegunn/fzf' 
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-surround'
Plug 'terryma/vim-expand-region'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'jremmen/vim-ripgrep'
call plug#end()

filetype plugin indent on
syntax on

let g:airline_powerline_fonts = 1
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
set clipboard+=unnamedplus
set autochdir
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set mouse=a
let g:VM_maps = {}
let g:VM_maps["Add Cursor Down"] = '<M-j>'
let g:VM_maps["Add Cursor Up"] = '<M-k>'

nnoremap <C-b> :History<CR>
nnoremap <C-p> :Commands<CR>
