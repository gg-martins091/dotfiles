set number
set autoindent
set tabstop=2
set shiftwidth=2
set smarttab
set softtabstop=2
set mouse=a
"set paste

if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin(stdpath('data') . '/plugged')
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
let g:coc_global_extensions = ['coc-tslint-plugin', 'coc-tsserver', 'coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-yank', 'coc-prettier']
Plug 'ianks/vim-tsx'
Plug 'leafgarland/typescript-vim'
Plug 'dikiaap/minimalist'
Plug 'preservim/nerdtree'

call plug#end()


set t_Co=256
syntax on
colorscheme minimalist

let mapleader = ","
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

nnoremap <leader>nt :tabnew<CR>

" Cycle through buffers (files)
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" Coc bindings
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>do <Plug>(coc-codeaction)
nnoremap <silent> <space>d :<C-u>CocList diagnostics<cr>

