" -------------------------------------------------------------------- General
" don't bother about VI compatibility
set nocompatible
" avoid 'Hit return to continue' message
set shortmess=a
" No annoying beeps: use visualbell (t_vb= for no delay)
set vb  t_vb=
set noerrorbells
" redraw smartly when using long running macros (perf+)
set lazyredraw
" wildmenu for command completion.
set wildmenu
set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,*.jpg,*.gif,*.png,.git*,*.sw?
set wildmode=list:longest
" default is 50
set history=256
set undolevels=256
" no need for backups
set nobackup
" set noswapfile ' someday, maybe

" ------------------------------------------------------------ Enable pathogen
" installed with mkdir -p ~/.vim/autoload ~/.vim/bundle; \
" curl -so ~/.vim/autoload/pathogen.vim https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim
call pathogen#infect()

" --------------------------------------------------------------------- Source
" tabspace to 2 spaces
set ts=2
" don't keep tabs
set expandtab
set shiftwidth=2
set shiftround
" No linefeed forced ever
set tw=0
" and wrap at the end of window (no horizontal scrollbar)
set wrap
" show 80 col marker
set colorcolumn=80
" Unix files
set fileformat=unix
" do not allow actual rendering of html tags content
let html_no_rendering=1
" ident control
set autoindent
set smartindent
" I want to see matching parenthesis
set showmatch
" backspace control
set bs=indent,eol,start
" automatic syntax coloring
if version >= 600
  syntax enable
else
  set syntax=on
endif
" line numbers everywere
set number
set list " we do what to show tabs, to ensure we get them out of my files
"set listchars=trail:-,nbsp:%
set listchars=tab:▶▹,nbsp:␣,extends:…,trail:•
" scroll context
set scrolloff=7
" utf-8 is nice, BOM is not
set encoding=utf-8
setglobal fileencoding=utf-8
set nobomb
set termencoding=utf-8
set fileencodings=utf-8,iso-8859-15

" ---------------------------------------------------------------- status line
" also see colorscheme in tgo.vim
" status line looks like
" filename modified readonly type buffernum,modified line,column percentinfile hexofcharundercursor
set statusline=%-5t%-1m%r%y%=[%n%M]\ %l,%c\ %p%%\ 0x%B
" always show the status
set laststatus=2

" ------------------------------------------------------------------ Searching
" search incrementaly and smartly
set smartcase
set incsearch
" highlight search results
set hlsearch
" !!! REMEMBER the * key searches for whatever is under the cursor

" ------------------------------------------------------------------- Key Maps
" Set map leaders
let mapleader = ","
let g:mapleader = ","

" Disable highlight on leader-space
map <leader><space> :nohl<CR>

" ,e/,w to open/save a file in the same directory as the currently edited file
if has("unix")
  map <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
  map <leader>w :w <C-R>=expand("%:p:h") . "/" <CR>
  map <leader>r :r <C-R>=expand("%:p:h") . "/" <CR>
  " <leader>f creates a filesystem tree starting at the current directory
  map <leader>f :exe CreateMenuPath(expand("%:p:h"),"Tgo&Path") <CR>
else
  map <leader>e :e <C-R>=expand("%:p:h") . "\\"<CR>
  map <leader>w :w <C-R>=expand("%:p:h") . "/" <CR>
  map <leader>r :r <C-R>=expand("%:p:h") . "/" <CR>
endif

" move among splits and buffers.  We use command key on mac, ctrl on other OSes
if has("gui_macvim")
  " macvim has a gvimrc and vimrc file located in
  " /Applications/MacVim.app/Contents/Resources/vim which set a bunch of
  " stuff *after* the ~/vimrc is read.  It offers some bypass option, though.
  let macvim_skip_cmd_opt_movement=1
  " we want cmd-left/right to allow us to move among splits
  nnoremap <D-left> <C-w>W
  nnoremap <D-right> <C-w>w
  " and among buffers if shift is used
  nnoremap <D-S-left> :bp<cr>
  nnoremap <D-S-right> :bn<cr>
else
  " we want ctrl-left/right to allow us to move among splits
  nnoremap <C-left> <C-w>W
  nnoremap <C-right> <C-w>w
  " and among buffers if shift is used (we use CTRL on other OSes
  nnoremap <C-S-left> :bp<cr>
  nnoremap <C-S-right> :bn<cr>
endif

" -------------------------------------------------------------- Abbreviations
abbr sop( System.out.println(

" ------------------------------------------ Colorscheme and other color stuff
if (v:version >= 600)
  colorscheme solarized
  set background=light
  set guifont=Courier\ New:h12
  set cursorline
  " override colorscheme for SpecialKey to see listchars better
  hi! SpecialKey guifg=DarkRed guibg=LightRed    
  hi! NonText guifg=DarkRed
endif

" -------------------------------------------------------------- Auto Commands
" Remember everything (position, folds, etc)
au BufWinLeave * mkview
au BufWinEnter * silent loadview
" let terminal resize scale the internal windows
" (from http://vimrcfu.com/snippet/186)
au VimResized * :wincmd =
au! bufwritepost .vimrc source %

" ---------------------------------------------------------------- Experiments
" doing this make yank selections go to OS clipboard
set clipboard=unnamed
" Move visual block (from http://vimrcfu.com/snippet/77)
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
let g:jshintconfig = "~/.jshintrc"

" --- mapping for javascript formatter. Assumes npm install -g esformatter
" and ~.esformatter config being available
" same combo for visual and non visual mode
map <leader>f :%!esformatter<CR>
vmap <leader>f :!esformatter<CR>
