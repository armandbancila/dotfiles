" if has('unix')
" :help feature-list
" general
set nocompatible " use vim defaults
set autoread " autoread from file
set updatetime=750 " faster response time when vim is inactive
if has("multi_byte")
	set encoding=utf-8
	set fileencoding=utf-8
endif
"" use the OS clipboard by default (on versions compiled with `+clipboard`)
if has("clipboard")
	set clipboard=unnamed,unnamedplus " always interact with the clipboard
endif
set nomodeline " because apparently 'ex: P' is a modeline
"" scrolling
set ttyfast " fix slow scrolling
set ttyscroll=3 " scroll 3 rows
set scrolloff=5 " number of lines to keep above / below the cursor
" set lazyredraw " don't update screen during macro or script execution
set nobackup " don't need ~ backup files
set noswapfile " unneeded
set history=1024
set undolevels=1024
set noshowmatch " don't jump to matching bracket
set nojoinspaces " don't insert 2 spaces after '.' '?' '!' with a join (J) command

" kb and mouse input
"" enable mouse
if has("mouse")
  set mouse=a
endif
"" key remap
""" autocomplete in insert mode with tab
"""" inoremap <Tab> <C-X><C-F>
""" remap useless keys
"""" :help
nnoremap <F1> <nop>
"""" Ex mode
"""" nnoremap Q <nop>
map Q @q
"""" brings man page about word under cursor
nnoremap K <nop>
"""" inconsistency, yank from cursor till end
nnoremap Y y$

" searching
set ignorecase
set infercase " ignore in autocompletion
set smartcase " ignore case only when lowercase search
if has("extra_search")
	set incsearch " incremental search
	set hlsearch " highlight all matches of search
endif
"" use rg for grepping
if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" autocomplete
"" enhance command-line completion
if has("wildmenu")
	set wildmenu
	set wildmode=longest,list
	set wildignore+=*.a,*.o
	set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
	set wildignore+=.DS_Store,.git,.hg,.svn
	set wildignore+=*~,*.swp,*.tmp
endif
set showcmd " show the (partial) command as it's being typed

" tabs, spaces, autoindent
set expandtab " expand tab into spaces
set tabstop=4 " visually 4 spaces wide
set softtabstop=4 " when equal to tabstop, vim will always use tabs and not add spaces when hitting tab in insert mode
set shiftwidth=4 " how many columns text is indented with when using << and >>
set autoindent " apply indentation of current line to next (o, O, [i]enter)
if has("smartindent")
	set smartindent " adapt to the indentation style of file
endif
if has("autocmd")
	autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4 " 1 tab = 4 spaces for python
	autocmd Filetype scala setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2 " 1 tab = 2 spaces for scala
endif
set list " visible tabs and trailing spaces
set listchars=tab:<->
set listchars+=trail:~
set listchars+=nbsp:+
set backspace=indent,eol,start " backspace through everything

" visual changes
"" new split to right and bottom
if has("wiundows")
	set splitbelow
	set splitright
endif
"" don't change the title permanently
if has("title")
	set title
	set titleold=
endif
set showmode " display current mode
set shortmess+=I " disable the startup message in empty files
set number " line numbers
"" text
set wrap " wrap text
if has("linebreak")
	set linebreak " make wrap preserve words
endif
if has("folding")
	set foldmethod=marker " set default folding for text
endif
"" syntax highlighting
if has("syntax")
	syntax on " enable syntax highlighting
	set synmaxcol=512 " don't color too many columns, for performance
	let g:gruvbox_contrast_dark='medium' " medium contrast for theme
	colorscheme gruvbox
	set background=dark " use dark theme
	set cursorline " highlight current line, may cause slowdown
	hi cursorline cterm=NONE
	hi cursorlinenr ctermfg=yellow
endif
if has("autocmd")
	autocmd BufEnter * :syntax sync fromstart " do syntax highlight syncing from the start
endif
"" stop cursorline from highlighting tabs and trailing spaces
if has("autocmd")
	au VimEnter * call matchadd('SpecialKey', '^\s\+', -1)
	au VimEnter * call matchadd('SpecialKey', '\s\+$', -1)
endif
set t_Co=256 " make vim use 256 colors
"" statusline
if has("statusline")
	" set statusline=%F\ %m " full path and file modified marker
	set laststatus=2 " always show statusline
	" use xterm colors
	"" blue bg
	hi User1 ctermfg=235 ctermbg=4
	"" dark yellow bg
	hi User2 ctermfg=235 ctermbg=3
	"" yellow bg
	hi User3 ctermfg=235 ctermbg=11
	"" red bg
	hi User4 ctermfg=235 ctermbg=9
	"" black bg
	hi User5 ctermfg=15 ctermbg=235
	" colored statusline
	set statusline=
	set statusline+=%3*\ %n\ %*     " buffer number
	set statusline+=%2*\ %{&ff}%*   " file format
	set statusline+=%2*%y\ %*       " file type
	set statusline+=%1*\ %<%F\ %*   " full path
	set statusline+=%4*%m%*         " modified flag
	set statusline+=%5*\ %=%5l\ %*  " current line
	set statusline+=%5*/\ %L\ %*    " total lines
	set statusline+=%2*\ %4v\ %*    " virtual column number
	set statusline+=%3*\ 0x%04B\ %* " character under cursor
endif

fun! TrimWhitespace()
    let l:save = winsaveview()
    %s/\s\+$//e
    call winrestview(l:save)
endfun
command! TrimWhitespace call TrimWhitespace()

