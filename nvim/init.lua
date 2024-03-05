-- Basic settings
vim.o.number = true
vim.o.relativenumber = true
vim.o.autoindent = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.smarttab = true
vim.o.softtabstop = 2
vim.o.mouse = 'a'
vim.o.hidden = true
vim.opt.sessionoptions:remove("options")
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.keymodel = 'startsel,stopsel'

-- Terminal GUI colors and syntax highlighting
vim.o.termguicolors = true
vim.cmd('syntax on')

-- Airline configurations
vim.g.airline_powerline_fonts = 1
vim.g.airline_theme = 'term'
vim.g['airline#extensions#tabline#enabled'] = 1
vim.g['airline#extensions#tabline#formatter'] = 'unique_tail'

-- Popup menu colors
vim.cmd [[
hi Pmenu guibg=#1d3357 guifg=white
hi PmenuSel guibg=gray guifg=black
hi PmenuThumb guibg=#585858
hi PmenuSbar guibg=#bcbcbc
]]

-- Leader key
vim.g.mapleader = ","

-- NERDTree mappings
vim.api.nvim_set_keymap('n', '<leader>n', ':NERDTreeFocus<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-n>', ':NERDTree<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-t>', ':NERDTreeToggle<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-f>', ':NERDTreeFind<CR>', {noremap = true})
vim.g.NERDTreeChDirMode = 3

-- Tab management
vim.api.nvim_set_keymap('n', '<leader>nt', ':tabnew<CR>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '<leader>ct', ':tabclose<CR>', {silent = true, noremap = true})

-- Buffer navigation
vim.api.nvim_set_keymap('n', '<Tab>', ':bnext<CR>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '<S-Tab>', ':bprevious<CR>', {silent = true, noremap = true})

-- File and buffer search
vim.api.nvim_set_keymap('n', '<leader>f', ':Files<CR>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '<C-f>', ':Rg<CR>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '<leader>b', ':Buffers<CR>', {silent = true, noremap = true})

-- Moving lines
vim.api.nvim_set_keymap('n', '<A-j>', ':m .+1<CR>==', {noremap = true})
vim.api.nvim_set_keymap('n', '<A-k>', ':m .-2<CR>==', {noremap = true})
vim.api.nvim_set_keymap('i', '<A-j>', '<Esc>:m .+1<CR>==gi', {noremap = true})
vim.api.nvim_set_keymap('i', '<A-k>', '<Esc>:m .-2<CR>==gi', {noremap = true})
vim.api.nvim_set_keymap('v', '<A-j>', ":m '>+1<CR>gv=gv", {noremap = true})
vim.api.nvim_set_keymap('v', '<A-k>', ":m '<-2<CR>gv=gv", {noremap = true})

-- Close buffer
vim.api.nvim_set_keymap('n', '<leader>x', ':bp<CR>:bd #<CR>', {silent = true, noremap = true})

-- Disable arrow keys
vim.api.nvim_set_keymap('', '<up>', '<nop>', {noremap = true})
vim.api.nvim_set_keymap('', '<down>', '<nop>', {noremap = true})
vim.api.nvim_set_keymap('', '<left>', '<nop>', {noremap = true})
vim.api.nvim_set_keymap('', '<right>', '<nop>', {noremap = true})

-- AutoCmds
vim.cmd [[
autocmd BufNew,BufRead *.asm set ft=nasm

" NERDTree auto open
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree | wincmd p
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
]]

-- Editing improvements
vim.api.nvim_set_keymap('v', '<C-c>', '"+y', {noremap = true})
vim.api.nvim_set_keymap('v', '<C-x>', 'd<Esc>i', {noremap = true})
vim.api.nvim_set_keymap('', '<C-v>', 'pi', {noremap = true})
vim.api.nvim_set_keymap('i', '<C-v>', '<Esc>pi', {noremap = true})
vim.api.nvim_set_keymap('i', '<C-z>', '<Esc>u', {noremap = true})

-- Clear search highlighting with ESC
vim.api.nvim_set_keymap('', '<esc>', ':noh<CR>', {noremap = true, silent = true})


local vim_plug_path = vim.fn.stdpath('data') .. '/site/autoload/plug.vim'
if vim.fn.empty(vim.fn.glob(vim_plug_path)) > 0 then
  vim.fn.system({
    'curl', '-fLo', vim_plug_path, '--create-dirs',
    'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  })
  vim.cmd [[ autocmd VimEnter * PlugInstall | source $MYVIMRC ]]
end


vim.cmd [[
call plug#begin(stdpath('data') . '/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'morhetz/gruvbox'
Plug 'sheerun/vim-polyglot'
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'bluz71/vim-nightfly-colors', { 'as': 'nightfly' }
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
" Add more plugins as needed

call plug#end()
]]

-- Lua initialization file
vim.cmd [[colorscheme nightfly]]
require('plugins')
