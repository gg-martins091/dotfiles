set number
set relativenumber
set autoindent
set tabstop=2
set shiftwidth=2
set smarttab
set softtabstop=2
set mouse=a
set hidden
set nocompatible
set ssop-=options
set ignorecase
set smartcase
set keymodel=startsel,stopsel



if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin(stdpath('data') . '/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = ['coc-pyright', 'coc-eslint', 'coc-tslint-plugin', 'coc-tsserver', 'coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-yank', 'coc-prettier']
Plug 'morhetz/gruvbox'
Plug 'sheerun/vim-polyglot'
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-commentary'
Plug 'dhruvasagar/vim-prosession'
" Plug 'jiangmiao/auto-pairs'

call plug#end()

set termguicolors
syntax on
" colorscheme gruvbox

hi Pmenu guibg=#1d3357 guifg=white
hi PmenuSel guibg=gray guifg=black
hi PmenuThumb guibg=#585858
hi PmenuSbar guibg=#bcbcbc

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_theme='term'

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline_symbols.colnr = 'Col '
let g:airline_symbols.linenr = '  '

if airline#util#winwidth() > 79
  let g:airline_section_z = airline#section#create(['windowswap', 'obsession', 'linenr', 'maxlinenr', 'colnr'])
else
  let g:airline_section_z = airline#section#create(['obsession', 'linenr', 'colnr'])
endif

autocmd BufNew,BufRead *.asm set ft=nasm

let mapleader = ","

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
let g:NERDTreeChDirMode = 3

" NerdTree openning behaviour
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree | wincmd p
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Open buffer in new window, do not replace nerdtree with buffer
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

nnoremap <silent> <leader>nt :tabnew<CR>
nnoremap <silent> <leader>ct :tabclose<CR>

" Cycle through buffers (files)
nnoremap <silent> <Tab> :bnext<CR>
nnoremap <silent> <S-Tab> :bprevious<CR>

" Find files and find in files
nnoremap <silent> <Leader>f :Files<CR>
nnoremap <silent> <C-f> :Rg<CR>
nnoremap <silent> <Leader>b :Buffers<CR>

"let g:NERDTreeIndicatorMapCustom = {
    "\ "Modified"  : "✹",
    "\ "Staged"    : "✚",
    "\ "Untracked" : "✭",
    "\ "Renamed"   : "➜",
    "\ "Unmerged"  : "═",
    "\ "Deleted"   : "✖",
    "\ "Dirty"     : "✗",
    "\ "Clean"     : "✔︎",
    "\ 'Ignored'   : '☒',
    "\ "Unknown"   : "?"
    "\ }
"let g:gitgutter_sign_added = '✚'
"let g:gitgutter_sign_modified = '✹'
"let g:gitgutter_sign_removed = '-'
"let g:gitgutter_sign_removed_first_line = '-'
"let g:gitgutter_sign_modified_removed = '-'


" Coc configs
set updatetime=300
set shortmess+=c
inoremap <silent><expr> <c-space> coc#refresh()
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

nmap <leader>rn <Plug>(coc-rename)
nmap <leader>do <Plug>(coc-codeaction)
" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
nnoremap <silent> <leader>g :<C-u>CocList diagnostics<cr>

function! s:show_documentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Move line up and down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

noremap <silent> <leader>x :bp<cr>:bd #<cr>

map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

let g:prosession_dir = '~/.config/vim_sessions/'

" Insert new line and exit insert mode
" nmap <CR> o<Esc>

let g:AutoPairsFlyMode = 1

" Editing keybinds
" vmap <C-c> y<Esc>i
vmap <C-C> "+y
vmap <C-x> d<Esc>i
map <C-v> pi
imap <C-v> <Esc>pi
imap <C-z> <Esc>ui

" Esc to remove search highlight
map <esc> :noh <CR>
