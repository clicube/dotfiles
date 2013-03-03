" http://vimwiki.net/?OptionList

"----------------
" ui, color
"----------------
syntax on
set background=dark
"colorscheme desert
"colorscheme molokai
"colorscheme jellybeans
colorscheme solarized
set number
set cursorline
"set cursorcolumn
set wildmenu
set nowrap
set ruler
set nocompatible
set title
set showcmd
"set laststatus=2
"set whichwrap=b,s,h,l,>,>,[,]
set mouse=a
set modeline
set modelines=5

"----------------
" search
"----------------
set ignorecase
set smartcase
set wrapscan
set hlsearch
set incsearch
nmap <Esc><Esc> :noh<CR>

"----------------
" tab
"----------------
set ts=2
set sw=2
set sts=2
set expandtab
autocmd FileType ruby setlocal sw=2 sts=2 ts=2 expandtab


"----------------
" edit
"----------------
set autoindent
set cindent
set smartindent
set showmatch
set backspace=indent,eol,start
set clipboard=unnamed
filetype on
filetype indent on
filetype plugin on

"----------------
" use "set paste" when pasted from clipboard
" http://ttssh2.sourceforge.jp/manual/ja/usage/tips/vim.html#Bracketed
"----------------
if &term =~ "xterm"
	let &t_ti .= "\e[?2004h"
	let &t_te .= "\e[?2004l"
	let &pastetoggle = "\e[201~"

	function XTermPasteBegin(ret)
		set paste
		return a:ret
	endfunction

	noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
	inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
	cnoremap <special> <Esc>[200~ <nop>
	cnoremap <special> <Esc>[201~ <nop>
endif

"----------------
" back a cursor when inputting ()s
" http://www.e2esound.com/wp/2010/11/07/add_vimrc_settings/
"----------------
"inoremap {} {}<Left>
"inoremap [] []<Left>
"inoremap () ()<Left>
"inoremap "" ""<Left>
"inoremap '' ''<Left>
"inoremap <> <><Left>


"----------------
" disable cursor keys
" http://lists.debian.or.jp/debian-users/200703/msg00095.html
"----------------
noremap <Left> <Nop>
noremap <Right> <Nop>
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap! <Left> <Nop>
noremap! <Right> <Nop>
noremap! <Up> <Nop>
noremap! <Down> <Nop>


