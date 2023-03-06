" Basic configurations
set number
set relativenumber
set tabstop=4
set shiftwidth=4
set expandtab
set hlsearch
set autoindent
set incsearch
set colorcolumn=80

" Plugin configurations
call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-commentary'
call plug#end()

" Key mappings
let mapleader = ","
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>u :tabnew<CR>
nnoremap <leader>c gcc
nnoremap <leader>u gggT

nnoremap <leader>n :NERDTreeToggle<CR>

" Search files in the current directory
nnoremap <leader>f :Files<CR>

" Search files recursively in the current directory
nnoremap <leader>F :Files --recursive<CR>

" Search for text in files in the current directory
nnoremap <leader>g :Rg<CR>

" Search for text in files recursively in the current directory
nnoremap <leader>G :Rg --hidden --follow --glob '!.git/*'<CR>

" Configure coc.nvim
let g:coc_global_extensions = [
    \ 'coc-tsserver',
    \ 'coc-json',
    \ 'coc-yaml',
    \ 'coc-html',
    \ 'coc-css',
    \ 'coc-python',
    \ 'coc-go',
    \ 'coc-jedi',
    \ ]
