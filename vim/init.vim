""" OPTION """
set autoread
set autowrite
set background=dark
set clipboard^=unnamed,unnamedplus
set number
set cursorline
set relativenumber
set ruler
set nowrap
set expandtab
set noshowcmd
set shiftwidth=2
set softtabstop=2
set tabstop=2
set virtualedit=block
set termguicolors

""" KEYBINDINGS """
let g:mapleader = "\<Space>"
let g:maplocalleader = ','
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
imap jk <Esc>

""" AUTOCMD """
augroup disable_auto_comment
  autocmd!
  autocmd BufEnter * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup END
augroup auto_create_directory
  autocmd!
  autocmd BufWritePre * if expand('<afile>') !~# '^\w\w\+:[/\\][/\\]' && !isdirectory(expand('<afile>:p:h')) | call mkdir(expand('<afile>:p:h'), 'p') | endif
augroup END
augroup go_to_last_location
  autocmd!
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line('$') | execute 'normal! g`"' | endif
augroup END
augroup close_with_q
  autocmd!
  autocmd FileType help,startuptime setlocal nobuflisted | nnoremap <buffer> <silent> q <Cmd>execute 'silent! close ' . nr2char(124) . ' silent! bdelete! ' . bufnr('%')<CR>
augroup END

""" VIM-PLUG BOOTSTRAP """
let data_dir = has('win32') || has('win64') ? '$HOME\vimfiles' : '~/.vim'
if empty(glob(data_dir.'/autoload/plug.vim'))
  if has('win32') || has('win64')
    silent execute '!powershell -Command "New-Item -Path "'.data_dir.' -Name autoload -Type Directory -Force; Invoke-WebRequest -Uri https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -OutFile '.data_dir.'\autoload\plug.vim"'
  else
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  endif
  augroup bootstrap_vim_plug
    autocmd!
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  augroup END
endif

augroup automatically_install_plugin
  autocmd!
  autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)')) | PlugInstall --sync | source $MYVIMRC | endif
augroup END

call plug#begin()

Plug 'morhetz/gruvbox', { 'on': [] }
augroup load_gruvbox
  autocmd!
  autocmd BufReadPost * call plug#load('gruvbox')
        \| autocmd! load_gruvbox
        \| let g:gruvbox_contrast_dark = 'hard'
        \| colorscheme gruvbox
augroup END

Plug 'LunarWatcher/auto-pairs', { 'on': [] }
augroup load_auto_pairs
  autocmd!
  autocmd InsertEnter * call plug#load('auto-pairs')
        \| autocmd! load_auto_pairs
        \| call autopairs#AutoPairsTryInit()
augroup END

Plug 'machakann/vim-highlightedyank', { 'on': [] }
augroup load_highlightedyank
  autocmd!
  autocmd BufReadPost * call plug#load('vim-highlightedyank')
        \| autocmd! load_highlightedyank
        \| let g:highlightedyank_highlight_duration = 1000
augroup END

call plug#end()
