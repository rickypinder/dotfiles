
"                       $$\                 $$\
"                       \__|                $$ |
"    $$$$$$\   $$$$$$\  $$\ $$$$$$$\   $$$$$$$ | $$$$$$\   $$$$$$\
"   $$  __$$\ $$  __$$\ $$ |$$  __$$\ $$  __$$ |$$  __$$\ $$  __$$\
"   $$ |  \__|$$ /  $$ |$$ |$$ |  $$ |$$ /  $$ |$$$$$$$$ |$$ |  \__|
"   $$ |      $$ |  $$ |$$ |$$ |  $$ |$$ |  $$ |$$   ____|$$ |
"   $$ |      $$$$$$$  |$$ |$$ |  $$ |\$$$$$$$ |\$$$$$$$\ $$ |
"   \__|      $$  ____/ \__|\__|  \__| \_______| \_______|\__|
"             $$ |
"             $$ |  https://github.com/rpinder/dotfiles/
"             \__|

" Plugins {{{

" I want some plugins only when using a certain OS
if !exists("g:os")
    if has("win64") || has("win32") || has("win16")
        let g:os = "Windows"
    else
        let g:os = substitute(system('uname'), '\n', '', '')
    endif
endif

" Installs plug.vim automatically
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-commentary'
Plug 'vim-scripts/a.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install -all' }
Plug 'junegunn/fzf.vim'
    nnoremap <leader>f :Files<cr>
    nnoremap <leader>b :Buffers<cr>
Plug 'valloric/youcompleteme'
    let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
    let g:ycm_extra_conf_vim_data = ['&filetype']
    nnoremap <leader>g :YcmCompleter GoTo<CR>
Plug 'morhetz/gruvbox'
Plug 'jiangmiao/auto-pairs'

" MacOS Specific Keybinds
if g:os == "Darwin"
    Plug 'rizzatti/dash.vim'
        nmap <silent> <leader>d <Plug>DashSearch
endif

call plug#end()

" }}}

" Filetype {{{

filetype indent on                               " load filetype-specific ident files

if has('autocmd')
    augroup FileOptions
        autocmd!
        autocmd FileType c nnoremap <buffer> <localleader>ca :A<cr>
        autocmd FileType cpp nnoremap <buffer> <localleader>ca :A<cr>
        autocmd FileType python nnoremap <buffer> <localleader>cr :!python %<cr>
        autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
        autocmd FileType ruby setlocal tabstop=2 shiftwidth=2 softtabstop=2 " ruby files have 2 tabs
        autocmd FileType vim let b:AutoPairs = {'(':')', "'":"'", '[':']', '{':'}'}
        autocmd FileType crontab setlocal nobackup nowritebackup
    augroup END
end

" }}}

" Spaces & Tabs {{{
set tabstop=4                                    " number of visual spaces per TAB
set softtabstop=4                                " number of spaces in tab when editing
set expandtab                                    " tabs are spaces
set smarttab
set shiftwidth=4
" }}}

" UI Config {{{

function! GitBranch()                           " Fetch the Git branch of cwd
    let l:branchname = system("git rev-parse --abbrev-ref HEAD 2>/dev/null
                \ | tr -d '\n'")
    return strlen(l:branchname) > 0 ? l:branchname : ''
endfunction

set laststatus=2                                 " Always show statusline
set statusline=
set statusline=\   
set statusline+=%F
set statusline+=\  
set statusline+=%([%M%R]%)
set statusline+=%=
set statusline+=%{GitBranch()}
set statusline+=\  
set statusline+=col:%-3c
set statusline+=\  
set statusline+=line:%4l/%-4L 
set statusline+=\  

if has("gui_running")
    set guioptions+=c
    set guioptions+=R
    set guioptions-=m
    set guioptions-=r
    set guioptions-=b
    set guioptions-=T
    set guioptions-=R
    set guioptions-=L
    set guioptions-=e
    set guifont=Menlo:h14
endif

" Colors
if has("termguicolors")
    set termguicolors
endif
syntax enable                                    " enable symtax processing
colorscheme gruvbox

set number                                       " show line numbers
set relativenumber                               " Relative line numbers
set showcmd                                      " show command in bottom bar
set wildmenu                                     " visual autocomplete for command menu
set lazyredraw                                   " redraw only when we need to
set showmatch                                    " highlight matching [{()}]
highlight CursorLineNr ctermfg=yellow            " Current line number is yellow
set fillchars=stl:─,stlnc:─,vert:│,fold:─,diff:─
set encoding=utf8
set autoindent                                   " maintains indent of current line

" }}}

" Searching {{{
set incsearch                                    " search as characters are entered
set hlsearch                                     " highlist matches
" }}}

" Folding {{{
set foldenable                                   " enable folding
set foldlevelstart=1                            " open most folds by default
set foldnestmax=10                               " 10 nested fold max
set foldmethod=marker                            " fold based on indent level
" }}}

" Vim Files {{{

if exists('$SUDO_USER')
    set nobackup                                 " don't create root owned files
    set nowritebackup
else
    set backupdir=~/local/.vim/tmp/backup
    set backupdir+=~/.vim/tmp/backup             " keep backup files out of the way
    set backupdir+=.
endif

if exists('$SUDO_USER')
    set noswapfile                               " don't create root owned files
else
    set directory=~/local/.vim/tmp/swap//
    set directory+=~/.vim/tmp/swap//             " keep swap files out of the way
    set directory+=.
endif

if has('persistent_undo')
    if exists('$SUDO_USER')
        set noundofile                           " don't create root owned files
    else
        set undodir=~/local/.vim/tmp/undo
        set undodir+=~/.vim/tmp/undo             " keep undo files out of the way
        set undodir+=.
        set undofile                             " actually use undo files
    endif
endif

if has('viminfo')
    if exists('$SUDO_USER')
        set viminfo=                             " don't create root-owned files
    else
        if isdirectory('~/local/.vim/tmp')
            set viminfo=~/local/.vim/tmp/viminfo
        else
            "set viminfo=~/.vim/tmp/viminfo     " override ~/.viminfo default
        endif

        if !empty(glob('~/.vim/tmp/viminfo'))
            if !filereadable(expand('~/.vim/tmp/viminfo'))
                echoerr 'warning ~/.vim/tmp/viminfo exists but is not readable'
            endif
        endif
    endif
endif

if has('mksession')
    if isdirectory('~/local/.vim/tmp')
        set viewdir=~/local/.vim/tmp/view
    else
        set viewdir=~/.vim/tmp/view              " override ~/.vim/view default
    endif
    set viewoptions=cursor,folds                 " save/restore just these (with ':{mk, loadview#)
endif

" }}}

" Vanilla Keybinds {{{

" leader
map <space> <leader>

" keybinds
nnoremap <leader>w :w<cr>
nnoremap <leader><space> :nohlsearch<CR>
nnoremap j gj
nnoremap k gk
inoremap jk <Esc>
inoremap kj <Esc>
xnoremap jk <Esc>
xnoremap kj <Esc>

noremap <Up>    <Nop>
noremap <Down>  <Nop>
noremap <Left>  <Nop>
noremap <Right> <Nop>
inoremap <Up>    <Nop>
inoremap <Down>  <Nop>
inoremap <Left>  <Nop>
inoremap <Right> <Nop>

" }}}

" vim:foldmethod=marker:foldlevel=0
