" Always show statusline
set laststatus=2

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256

" Colors
colorscheme jellybeans " use jellybeans colorscheme
syntax enable " enable symtax processing

" Spaces & Tabs
set tabstop=2 " number of visual spaces per TAB
set softtabstop=2 " number of spaces in tab when editing
set expandtab "tabs are spaces
set smarttab 
set shiftwidth=2

" UI Config
set number " show line numbers
set showcmd " show command in bottom bar
set cursorline " highlight current line
filetype indent on " load filetype-specific ident files
set wildmenu " visual autocomplete for command menu
set lazyredraw " redraw only when we need to
set showmatch " highlight matching [{()}]

" Searching
set incsearch " search as characters are entered
set hlsearch " highlist matches
nnoremap <leader><space> :nohlsearch<CR>

" Folding  
set foldenable " enable folding
set foldlevelstart=10 " open most folds by default
set foldnestmax=10 " 10 nested fold max
nnoremap <space> za
set foldmethod=indent " fold based on indent level

" Movement
" move vertically by visual line
nnoremap j gj 
nnoremap k gk

execute pathogen#infect()
