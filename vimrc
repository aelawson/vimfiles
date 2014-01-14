set nocompatible        "This must be first, because it changes other options as a side effect.
scriptencoding utf-8    "Set scriptencoding to utf-8 (listchars)

" Add NeoBundle to runtimepath
set runtimepath+=~/.vim/bundle/neobundle.vim/

" Initialize neobundle
call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" Plugins
NeoBundle 'L9'
NeoBundle 'tomtom/tlib_vim'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'MarcWeber/vim-addon-mw-utils'
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
NeoBundle 'bling/vim-airline'
NeoBundle 'duff/vim-bufonly'
NeoBundle 'gregsexton/MatchTag'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'othree/html5.vim'
NeoBundle 'xsbeats/vim-blade'
NeoBundle 'elzr/vim-json'
NeoBundle 'evidens/vim-twig'
NeoBundle 'jelera/vim-javascript-syntax'
NeoBundle 'joshtronic/php.vim'
NeoBundle 'cakebaker/scss-syntax.vim'

filetype plugin indent on

" Call NeoBundle command for checking bundles
NeoBundleCheck

" Set initial folder depending on OS
if !argc()
     if isdirectory("/Users/kristijanhusak/Sites/")
        cd ~/Sites
    elseif isdirectory("/var/www")
        cd /var/www
    elseif isdirectory("c:/xampp/htdocs")
        cd c:/xampp/htdocs
    endif
endif

" Change leader to a comma because the backslash is too far away
let mapleader=","

" ================ GUI options ====================
set guioptions-=m                       "remove menu bar
set guioptions-=T                       "remove toolbar
set guioptions-=L                       "remove left scrollbar when vertical split
set guioptions-=l                       "remove left scrollbar
set linespace=4                         "Set lineheight in gvim

" ================ General Config ====================

set t_Co=256                    "Set 256 colors
set title                       "change the terminal's title
set number                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=500                 "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set noshowmode                  "Hide showmode because of the powerline plugin
set gdefault                    "Set global flag for search and replace
set gcr=a:blinkon0              "Disable cursor blink
set noerrorbells                "No error bells
set cursorline                  "Highlight current line
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim
set smartcase                   "Smart case search if there is uppercase
set ignorecase                  "case insensitive search
set hlsearch                    "Highlight search term
set incsearch                   "Jump to found term while searching
set showmatch                   "Highlight matching bracket
set mouse=a                     "Enable mouse
set nostartofline               "Jump to first non-blank character
set laststatus=2                "Show statusbar
set fileencoding=utf-8          "Set utf-8 encoding on write
set encoding=utf-8              "Set utf-8 encoding on read
set wrap                        "Enable word wrap
set linebreak                   "Wrap lines at convenient points
set tags=tags;/                 "ctags file location, searches to root until it founds it
set listchars=tab:\ \ ,trail:·  "Set trails for tabs and spaces
set list                        "Enable listchars
set completeopt-=preview        "Disable preview for autocomplete
set background=dark             "Set background to dark

colorscheme hybrid_custom

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

"turn on syntax highlighting
syntax on

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.

silent !mkdir ~/.vim/backups > /dev/null 2>&1
set undodir=~/.vim/backups
set undofile

" ================ Indentation ======================

" Tab setup
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
set smartindent
set autoindent

" ================ Auto commands ======================

" call php specific setup function on buff open
autocmd filetype php call SetPhpOptions()

" load yaml syntax on buffread ( Fixes old slow loading )
autocmd BufNewFile,BufRead *.yaml,*.yml source ~/.vim/after/syntax/yaml.vim

" Set compass file to .scss instead of css.scss
autocmd BufRead,BufNewFile *.scss	set filetype=scss

" If no file is selected, execute Nerdtree plugin
autocmd vimenter * if !argc() | NERDTree | endif


" ================ Folds ============================

set foldmethod=marker
set foldmarker={{{,}}}
set nofoldenable        "dont fold by default

" ================ Completion =======================

set wildmode=list:longest
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

" ================ Window size and other setup ========================

if has("gui_running")
    if has("gui_macvim")            "On mac big screen we dont need fullscreen
        set lines=65 columns=200
    else
        set lines=999 columns=999
    endif
endif

" Reduce Command timeout for faster escape and O
set timeoutlen=1000
set ttimeoutlen=200

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
" Delete all buffers
nmap <silent> <Leader>da :exec "1," . bufnr('$') . "bd"<cr>

" Trigger omnicomplete with Ctrl + space
imap <c-space> <c-x><c-o>

" Map for Escape key
inoremap jj <Esc>
" Twig tag autocomplete
inoremap {%<Space> {%<Space><Space>%}<Esc><Left><Left><Insert>


" Trigger easy align with Vim movement
nmap <Leader>a <Plug>(EasyAlign)

" Clear search highlight
nnoremap <Leader><space> :noh<CR>
" Open NERDTree
nnoremap <Leader>n :NERDTreeToggle<CR>
" Toggle between last 2 buffers
nnoremap <leader><tab> <c-^>
" Switch jump half page to Ctrl-f so multiple cursors can be bind to Ctrl-d ( Sublime text like )
nnoremap <C-f> <C-d>
" Copy and paste from clipboard
nnoremap <Leader>y "+y
nnoremap <Leader>v "+p
" Filesearch plugin map for searching in whole folder
nnoremap <Leader>f :Fsgrep /
" Ctrlp plugin fuzzy search files
nnoremap <Leader>p :CtrlP<CR>
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

"Trigger easy plugin in visual mode
vmap <Leader>a <Plug>(EasyAlign)

" Copy to system clipboard
vnoremap <Leader>y "+y
" Maps for indentation in visual mode
vnoremap <tab> >
vnoremap <s-tab> <

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"
imap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

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

" ================ plugins setups ========================

let g:airline_powerline_fonts = 1       "Enable powerline fonts
let g:airline_theme="powerlineish"      "Set theme to powerline default theme
let g:airline_section_y='%{(&fenc == "" ? &enc : &fenc)}'                       "set encoding type info
let g:airline_section_z='%{substitute(getcwd(), expand("$HOME"), "~", "g")}'    "Set relative path
let g:airline_section_c = '%<%f %#__accent_red#%m%#__restore__# %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#' "Adds red modified
let g:airline#extensions#whitespace#enabled = 0     "Disable whitespace extension

let g:user_emmet_expandabbr_key = '<c-e>'           "Change trigger emmet key
let g:user_emmet_next_key = '<c-n>'                 "Change trigger jump to next for emmet

let g:NERDTreeChDirMode=2                           "NERDTree change directory only on root change
let NERDTreeShowHidden=1                            "Show hidden files in NERDTree

let g:filesearch_viewport_split_policy="T"          "Filesearch plugin window appears on top
let g:filesearch_autoexpand_on_split=0              "Prevent Filesearch plugin to expand gvim window
let g:filesearch_split_size=20                      "Filesearch window size
let g:filesearch_autodismiss_on_select=0            "Filesearch window stay open

let g:ctrlp_match_window = 'bottom,order:ttb,min:1,max:25,results:25' "Ctrlp window setup

let g:syntastic_quiet_messages = {'level': 'warnings'}  "Syntastic ignore warnings
let g:syntastic_auto_loc_list=1                         "Show syntastic window when there are errors, otherwise close
let g:syntastic_always_populate_loc_list=1              "Always popuplate syntastic error list

let g:neocomplete#enable_at_startup = 1                 "Enable autocomplete
let g:neocomplete#enable_smart_case = 1                 "Use smartcase.
let g:neocomplete#enable_auto_select = 1                "AutoCompPop behavior

let g:vim_json_syntax_conceal = 0                   "Disable setting quotes for json syntax

let g:neosnippet#enable_snipmate_compatibility = 1      "Enable snipMate compatibility feature.
let g:neosnippet#snippets_directory='~/.vim/snippets'   " Tell Neosnippet about the other snippets

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
        set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h12              "Mac OS
    elseif has('win16') || has('win32')
        set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h10:cANSI        "Windows
    else
        set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 10              "Other(Linux)
    endif
endfunction

" Php specific indent options
function! SetPhpOptions()
    setlocal autoindent
    setlocal smartindent
endfunction

" ================ Function calls ========================

:call SetFont()                                             "Set font depending on OS

" Include local vimrc if exists
if filereadable(glob("$HOME/.vimrc.local")) 
    source $HOME/.vimrc.local
endif
