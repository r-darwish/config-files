call plug#begin()
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}
Plug 'junegunn/fzf' 
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
call plug#end()

filetype plugin indent on
syntax on

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'

nnoremap <C-b> :History<CR>
nnoremap <C-p> :Commands<CR>


lua << EOF

vim.g.coq_settings = {
  auto_start = 'shut-up'
}

local coq = require("coq")
EOF
