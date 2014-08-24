set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
set nocompatible
syntax enable
filetype off

set showmatch
set matchtime=2
set incsearch
set hlsearch
set ignorecase
set smartcase
set t_kD=^?
set backspace=indent,eol,start
set number
set ruler
set hidden
set noswapfile
set autoread
set encoding=utf8
set fileencoding=utf-8
set ignorecase
set smartcase
set history=100
highlight ZenkakuSpace cterm=underline ctermfg=blue
set ruf=%45(%12f%=\ %m%{'['.(&fenc!=''?&fenc:&enc).']'}\ %l-%v\ %p%%\ [%02B]%)
set statusline=%f:%{substitute(getcwd(),'.*/','','')}\ %m%=%{(&fenc!=''?&fenc:&enc).':'.strpart(&ff,0,1)}\ %l-%v\ %p%%\ %02B
set showcmd
set cmdheight=1
set laststatus=2
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%

nnoremap <Space>.  :<C-u>edit $MYVIMRC<Enter>
nnoremap <Space>s. :<C-u>source $MYVIMRC<Enter>

inoremap <expr> ,df strftime('%Y-%m-%dT%H:%M:%S')
inoremap <expr> ,dd strftime('%Y-%m-%d')
inoremap <expr> ,dt strftime('%H:%M:%S')

nnoremap gc `[v`]
vnoremap gc :<C-u>normal gc<Enter>
onoremap gc :<C-u>normal gc<Enter>

"http://itcweb.cc.affrc.go.jp/affrit/faq/tips/vim-enc
":set encoding=utf-8
":set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
":set fileformats=unix,dos,mac
" gocode
set rtp+=$GOROOT/misc/vim
"golint
exe "set rtp+=" . globpath($GOPATH, "src/github.com/golang/lint/misc/vim")

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

"vunlde.vimで管理してるpluginを読み込む
source ~/dotfiles_private/.vimrc.bundle

"" Go
filetype plugin indent on
syntax on
auto BufWritePre *.go Fmt
autocmd FileType go setlocal noexpandtab shiftwidth=4 tabstop=4 softtabstop=4 nolist

" 隠しファイルを表示する
let NERDTreeShowHidden = 1
"  引数なしで実行したとき、NERDTreeを実行する
let file_name = expand("%:p")
if has('vim_starting') &&  file_name == ""
  autocmd VimEnter * execute 'NERDTree ./'
endif

" ターミナルでマウスを使用できるようにする
set mouse=a
set guioptions+=a
set ttymouse=xterm2
