
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

set backspace=indent,eol,start

" Plugins {{{

" Installs plug.vim automatically
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Colorscheme
Plug 'ewilazarus/preto'

" Intellisense engine
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" COC setup {{{ 
set hidden
set updatetime=300
set shortmess+=c
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand','editor.action.organizeImport')

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <leader>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <leader>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <leader>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <leader>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <leader>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <leader>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <leader>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <leader>p  :<C-u>CocListResume<CR>
" }}}

call plug#end()

" }}}

" Filetype {{{

filetype indent on                               " load filetype-specific ident files

if has('autocmd')
    augroup FileOptions
        autocmd!
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

" Colors
set t_Co=256
syntax enable                                    " enable symtax processing
colorscheme preto

set number                                       " show line numbers
set relativenumber                               " Relative line numbers
set showcmd                                      " show command in bottom bar
set wildmenu                                     " visual autocomplete for command menu
set showmatch                                    " highlight matching [{()}]
set encoding=utf8
set autoindent                                   " maintains indent of current line

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
set statusline+=\  
set statusline+=%{coc#status()}%{get(b:,'coc_current_function','')}
set statusline+=\  
set statusline+=%{GitBranch()}
set statusline+=\  
set statusline+=col:%-3c
set statusline+=\  
set statusline+=line:%4l/%-4L 
set statusline+=\  

highlight StatusLine ctermbg=137 ctermfg=White

set cursorline
highlight CursorLine ctermbg=234

let g:netrw_banner = 0
nnoremap - :E<CR>


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
    set backupdir=~/.local/vim/tmp/backup
    set backupdir+=~/.vim/tmp/backup             " keep backup files out of the way
    set backupdir+=.
endif

if exists('$SUDO_USER')
    set noswapfile                               " don't create root owned files
else
    set directory=~/.local/vim/tmp/swap//
    set directory+=~/.vim/tmp/swap//             " keep swap files out of the way
    set directory+=.
endif

if has('persistent_undo')
    if exists('$SUDO_USER')
        set noundofile                           " don't create root owned files
    else
        set undodir=~/.local/vim/tmp/undo
        set undodir+=~/.vim/tmp/undo             " keep undo files out of the way
        set undodir+=.
        set undofile                             " actually use undo files
    endif
endif

if has('viminfo')
    if exists('$SUDO_USER')
        set viminfo=                             " don't create root-owned files
    else
        if isdirectory('~/.local/vim/tmp')
            set viminfo=~/.local/vim/tmp/viminfo
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
    if isdirectory('~/.local/vim/tmp')
        set viewdir=~/.local/vim/tmp/view
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
nnoremap <leader>b :ls<CR>:b 
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

" comment function
function! Commenting()
    let comment_char = split(&commentstring, '%s')[0]
    call inputsave()
    let start = input('Enter start: ')
    let end = input('Enter end: ')
    call inputrestore()
    :execute  start . "," . end . "s/^/" . comment_char . " /"
endfunction

" }}}

" vim:foldmethod=marker:foldlevel=0

