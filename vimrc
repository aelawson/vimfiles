set nocompatible        "This must be first, because it changes other options as a side effect.
scriptencoding utf-8    "Set scriptencoding to utf-8 (listchars)

" Add NeoBundle to runtimepath
set runtimepath+=~/.vim/bundle/neobundle.vim/

" Initialize neobundle
call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" Plugins
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'jeetsukumaran/vim-filesearch'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'jiangmiao/auto-pairs'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'bling/vim-airline'
NeoBundle 'duff/vim-bufonly'
NeoBundle 'gregsexton/MatchTag'
NeoBundle 'kris89/vim-multiple-cursors'
NeoBundle 'kris89/vim-hybrid'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'othree/html5.vim'
NeoBundle 'xsbeats/vim-blade'
NeoBundle 'elzr/vim-json'
NeoBundle 'evidens/vim-twig'
NeoBundle 'jelera/vim-javascript-syntax'
NeoBundle 'joshtronic/php.vim'
NeoBundle 'cakebaker/scss-syntax.vim'
NeoBundle "kchmck/vim-coffee-script"

filetype plugin indent on

" Call NeoBundle command for checking bundles
NeoBundleCheck

" Change leader to a comma because the backslash is too far away
let mapleader = ","

" ================ GUI options ====================

set guioptions-=m                       "remove menu bar
set guioptions-=T                       "remove toolbar
set guioptions-=L                       "remove left scrollbar when vertical split
set guioptions-=l                       "remove left scrollbar
set linespace=10                        "Set lineheight in gvim

" ================ General Config ====================

set t_Co=256                            "Set 256 colors
set title                               "change the terminal's title
set number                              "Line numbers are good
set backspace=indent,eol,start          "Allow backspace in insert mode
set history=500                         "Store lots of :cmdline history
set showcmd                             "Show incomplete cmds down the bottom
set noshowmode                          "Hide showmode because of the powerline plugin
set gdefault                            "Set global flag for search and replace
set gcr=a:blinkon0                      "Disable cursor blink
set noerrorbells                        "No error bells
set cursorline                          "Highlight current line
set visualbell                          "No sounds
set autoread                            "Reload files changed outside vim
set smartcase                           "Smart case search if there is uppercase
set ignorecase                          "case insensitive search
set hlsearch                            "Highlight search term
set incsearch                           "Jump to found term while searching
set showmatch                           "Highlight matching bracket
set mouse=a                             "Enable mouse
set nostartofline                       "Jump to first non-blank character
set timeoutlen=1000 ttimeoutlen=200     "Reduce Command timeout for faster escape and O
set laststatus=2                        "Show statusbar
set fileencoding=utf-8 encoding=utf-8   "Set utf-8 encoding on write
set conceallevel=2 concealcursor=i      "Setup for snippets markers
set wrap                                "Enable word wrap
set linebreak                           "Wrap lines at convenient points
set tags=tags;/                         "ctags file location, searches to root until it founds it
set listchars=tab:\ \ ,trail:·          "Set trails for tabs and spaces
set list                                "Enable listchars
set completeopt-=preview                "Disable preview for autocomplete
set background=dark                     "Set background to dark
set hidden                              "Hide buffers in background

" Set customized version of hybrid color scheme
colorscheme hybrid_reverse

"turn on syntax highlighting
syntax on

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================

" Keep undo history across sessions, by storing in file.
silent !mkdir ~/.vim/backups > /dev/null 2>&1
set undodir=~/.vim/backups
set undofile

" ================ Indentation ======================

set smarttab
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
set nofoldenable

" ================ Auto commands ======================

" Auto-remove trailing spaces
autocmd BufWritePre * :call StripTrailingWhitespaces()

" Remove unused markers for snippets
autocmd InsertLeave * NeoSnippetClearMarkers

" load yaml syntax on buffread ( Fixes old slow loading )
autocmd BufNewFile,BufRead *.yaml,*.yml source ~/.vim/after/syntax/yaml.vim

" If no file is selected, execute Nerdtree plugin
autocmd vimenter * if !argc() | NERDTree | endif

" ================ Completion =======================

set wildmode=list:full
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*vendor/**
set wildignore+=*node_modules/**
set wildignore+=*DS_Store*
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ Custom mappings ========================

" Comment map
map <Leader>c <c-_><c-_>
" Map save to Ctrl + S
map <c-s> :w<CR>

" Easier window navigation
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
" Trigger easy align with Vim movement
nmap <Leader>a <Plug>(EasyAlign)
" Delete all buffers
nmap <silent> <Leader>da :exec "1," . bufnr('$') . "bd"<cr>

" Trigger omnicomplete with Ctrl + space
imap <c-space> <c-x><c-o>
" Map save to ctrl+s
imap <c-s> <C-o>:w<CR>

" Expand snippets on tab if snippets exists, otherwise do autocompletion
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
" If popup window is visible do autocompletion from back
imap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-Tab>"

"Fix for jumping over placeholders for neosnippet
smap <expr><TAB> neosnippet#jumpable() ?
\ "\<Plug>(neosnippet_jump)"
\: "\<TAB>"

" Map for Escape key
inoremap jj <Esc>
" Paste from system clipboard with Ctrl + v
inoremap <C-v> <Esc>"+p

" Down is really the next line
nnoremap j gj
nnoremap k gk
" Yank to the end of the line
nnoremap Y y$
" Also save with ,w
nnoremap <Leader>w :w<CR>
" Clear search highlight
nnoremap <Leader><space> :noh<CR>
" Open NERDTree
nnoremap <Leader>n :NERDTreeToggle<CR>
" Toggle between last 2 buffers
nnoremap <leader><tab> <c-^>
" Switch jump half page to Ctrl-f so multiple cursors can be bind to Ctrl-d ( Sublime text like )
nnoremap <C-f> <C-d>
"Auto change directory to match current file
nnoremap <Leader>dc :cd %:p:h<CR>:pwd<CR>
" Paste from system clipboard with Ctrl + v
nnoremap <C-v> "+p
" Paste from yank register
nnoremap <Leader>p "0p
" Filesearch plugin map for searching in whole folder
nnoremap <Leader>f :Fsgrep /
" Toggle buffer list
nnoremap <Leader>b :CtrlPBuffer<CR>
" Ctrlp plugin fuzzy search tags
nnoremap <Leader>t :CtrlPBufTag<CR>
nnoremap <Leader>T :CtrlPBufTagAll<CR>
" Open tag in another tab
nnoremap <Leader>] :tab tag <c-r><c-w><cr>
" Build ctags
nnoremap <Leader>BT :call BuildCtags()<CR>
" Maps for indentation in normal mode
nnoremap <tab> >>
nnoremap <s-tab> <<
" Fugitive commands
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gc :call GitCommit()<CR>
nnoremap <Leader>gp :call GitPush()<CR>

"Trigger easy plugin in visual mode
vmap <Leader>a <Plug>(EasyAlign)

" Move to the end of yanked text after yank
vnoremap y y']
" Copy to system clipboard
vnoremap <C-c> "+y
" Indenting in visual mode
xnoremap <s-tab> <gv
xnoremap <tab> >gv

" ================ Abbreviations ========================

cnoreabbrev Wq wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qa qa
cnoreabbrev Bd bd
cnoreabbrev bD bd
cnoreabbrev wrap set wrap
cnoreabbrev nowrap set nowrap
cnoreabbrev bda BufOnly
cnoreabbrev t tabe
cnoreabbrev T tabe

" ================ plugins setups ========================

let g:ctrlp_match_window = 'bottom,order:ttb,min:1,max:25,results:25'   "Ctrlp window setup
let g:ctrlp_buffer_func = { 'enter': 'MyCtrlPMappings' }                "Ctrlp function for deleting buffers from buffer window

let g:airline_powerline_fonts = 1                           "Enable powerline fonts
let g:airline_theme = "powerlineish"                        "Set theme to powerline default theme
let g:airline_section_y = '%{(&fenc == "" ? &enc : &fenc)}'                       "set encoding type info
let g:airline_section_z = '%{substitute(getcwd(), expand("$HOME"), "~", "g")}'    "Set relative path
let g:airline_section_c = '%<%f %#__accent_red#%m%#__restore__# %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#' "Adds red modified
let g:airline#extensions#whitespace#enabled = 0             "Disable whitespace extension

let g:gitgutter_realtime = 0                                "Disable gitgutter in realtime
let g:gitgutter_eager = 0                                   "Disable gitgutter to eager load on tab or buffer switch

let g:user_emmet_expandabbr_key = '<c-e>'                   "Change trigger emmet key
let g:user_emmet_next_key = '<c-n>'                         "Change trigger jump to next for emmet

let g:NERDTreeChDirMode = 2                                 "NERDTree change directory only on root change
let g:NERDTreeShowHidden = 1                                "Show hidden files in NERDTree

let g:filesearch_viewport_split_policy = "T"                "Filesearch plugin window appears on top
let g:filesearch_autoexpand_on_split = 0                    "Prevent Filesearch plugin to expand gvim window
let g:filesearch_split_size = 20                            "Filesearch window size
let g:filesearch_autodismiss_on_select = 0                  "Filesearch window stay open


let g:syntastic_quiet_messages = {'level': 'warnings'}      "Syntastic ignore warnings
let g:syntastic_auto_loc_list = 1                           "Show syntastic window when there are errors, otherwise close
let g:syntastic_always_populate_loc_list = 1                "Always popuplate syntastic error list
let g:syntastic_php_checkers = ['php']                      "Enable only basic syntax checking for php

let g:multi_cursor_use_default_mapping = 0                  "Disable default mappings for multiple cursors
let g:multi_cursor_next_key = '<C-d>'                       "Set start and next multiple cursor to Ctrl-d ( Sublime text like  )
let g:multi_cursor_prev_key = '<C-r>'                       "Set prev multiple cursor
let g:multi_cursor_skip_key = '<C-x>'                       "Set skip cursor
let g:multi_cursor_quit_key = '<Esc>'                       "Exit multiple cursor mode

let g:neocomplete#enable_at_startup = 1                     "Enable autocomplete
let g:neocomplete#enable_smart_case = 1                     "Use smartcase.
let g:neocomplete#data_directory = '~/.vim/.neocomplete'    "Folder where neocomplete saves cache

let g:vim_json_syntax_conceal = 0                           "Disable setting quotes for json syntax

let g:neosnippet#snippets_directory = '~/.vim/neosnippets'  "Tell Neosnippet about the snippets folder

let g:indentLine_color_term = '236'                         "Indent line colors for terminal
let g:indentLine_color_gui = '#333333'                      "Indent line colors for gvim

" ================ Functions ========================

" Build ctags
function! BuildCtags()
    exe '!ctags --languages=PHP,JavaScript -R .'
    if filereadable('tags')
        echo "Build successfully!"
    else
        echo "Error! Please try again!"
    endif
endfunction

" Set proper font depending on OS
function! SetFont()
    if has('gui_macvim')
        set guifont=Inconsolata\ for\ Powerline:h14              "Mac OS
    elseif has('win16') || has('win32')
        set guifont=Inconsolata\ for\ Powerline:h12:cANSI        "Windows
    else
        set guifont=Inconsolata\ for\ Powerline\ 12              "Other(Linux)
    endif
endfunction

" Disable autocomplete before multiple cursors to avoid conflict
function! Multiple_cursors_before()
    exe 'NeoCompleteLock'
endfunction

" Enable autocomplete after multiple cursors
function! Multiple_cursors_after()
    exe 'NeoCompleteUnlock'
endfunction

" Git commit function with prompt
function! GitCommit()
    call inputsave()
    let commitMessage = input('Commit message: ')
    call inputrestore()
    if !empty(commitMessage)
        exe 'Gcommit -m "'.commitMessage.'"'
    endif
endfunction

" Git push to choosen branch
function! GitPush()
    call inputsave()
    let branch = input('What branch to push on: ')
    call inputrestore()
    if !empty(branch)
        exe "Git push origin ".branch
    endif
endfunction

" Remove trailing spaces on save
function! StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfunction

" Function to bind custom ctrlp mappings
function! MyCtrlPMappings()
    nnoremap <buffer> <silent> <c-@> :call <sid>DeleteBuffer()<cr>
endfunction

" Ctrlp function to delete buffers from buffers window
function! s:DeleteBuffer()
    let line = getline('.')
    let bufid = line =~ '\[\d\+\*No Name\]$' ? str2nr(matchstr(line, '\d\+'))
        \ : fnamemodify(line[2:], ':p')
    exec "bd" bufid
    exec "norm \<F5>"
endfunction

" ================ Function calls ========================

:call SetFont()                                             "Set font depending on OS

" Include local vimrc if exists
if filereadable(glob("$HOME/.vimrc.local"))
    source $HOME/.vimrc.local
endif
