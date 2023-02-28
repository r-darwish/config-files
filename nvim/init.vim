call plug#begin()
Plug 'vim-airline/vim-airline'
Plug 'joshdick/onedark.vim'
Plug 'tpope/vim-surround'
Plug 'terryma/vim-expand-region'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }
Plug 'aymericbeaumet/vim-symlink'
Plug 'easymotion/vim-easymotion'
call plug#end()

filetype plugin indent on
syntax on

let mapleader=" "
let g:airline_powerline_fonts = 1
set clipboard+=unnamedplus
set autochdir
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set mouse=a
set ignorecase
set smartcase
let g:VM_maps = {}
let g:VM_maps["Add Cursor Down"] = '<M-j>'
let g:VM_maps["Add Cursor Up"] = '<M-k>'
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fr <cmd>Telescope oldfiles<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

syntax on
colorscheme onedark
set termguicolors
hi Normal guibg=NONE ctermbg=NONE
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)
