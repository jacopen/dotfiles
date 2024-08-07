""*****************************************************************************
""" NeoBundle core
""*****************************************************************************
"if has('vim_starting')
"  set nocompatible               " Be iMproved
"
"  " Required:
"  set runtimepath+=~/.vim/bundle/neobundle.vim/
"endif
"
"let neobundle_readme=expand('~/.vim/bundle/neobundle.vim/README.md')
"
"if !filereadable(neobundle_readme)
"  echo "Installing NeoBundle..."
"  echo ""
"  silent !mkdir -p ~/.vim/bundle
"  silent !git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim/
"endif
"
"" Required:
"call neobundle#begin(expand('~/.vim/bundle/'))
"
"" Let NeoBundle manage NeoBundle
"" Required:
"NeoBundleFetch 'Shougo/neobundle.vim'
"
""*****************************************************************************
""" NeoBundle install packages
""*****************************************************************************
"NeoBundle 'scrooloose/nerdtree'
"NeoBundle 'jistr/vim-nerdtree-tabs'
"NeoBundle 'tpope/vim-commentary'
"NeoBundle 'tpope/vim-fugitive'
"NeoBundle 'kien/ctrlp.vim'
"NeoBundle 'bling/vim-airline'
"NeoBundle 'airblade/vim-gitgutter'
"NeoBundle 'sheerun/vim-polyglot'
"NeoBundle 'vim-scripts/grep.vim'
"NeoBundle 'vim-scripts/CSApprox'
"NeoBundle 'Shougo/vimproc.vim', {
"      \ 'build' : {
"      \     'windows' : 'tools\\update-dll-mingw',
"      \     'cygwin' : 'make -f make_cygwin.mak',
"      \     'mac' : 'make -f make_mac.mak',
"      \     'unix' : 'make -f make_unix.mak',
"      \    },
"      \ }
""" NeoBundle 'Shougo/vimshell.vim'
"
""" Snippets
""NeoBundle 'SirVer/ultisnips'
"NeoBundle 'honza/vim-snippets'
"
"
""" Custom bundles
"
""" Go Lang Bundle
""" NeoBundle "majutsushi/tagbar"
""" NeoBundle "fatih/vim-go"
"
"
""" Python Bundle
"NeoBundle "davidhalter/jedi-vim"
"NeoBundle "scrooloose/syntastic"
"NeoBundle "majutsushi/tagbar"
"NeoBundle "Yggdroot/indentLine"
"
"
""" HTML Bundle
""" NeoBundle 'amirh/HTML-AutoCloseTag'
"NeoBundle 'hail2u/vim-css3-syntax'
"NeoBundle 'gorodinskiy/vim-coloresque'
"NeoBundle 'tpope/vim-haml'
"
"
""" Ruby Bundle
""" NeoBundle "tpope/vim-rails"
""" NeoBundle "tpope/vim-rake"
""" NeoBundle "tpope/vim-projectionist"
""" NeoBundle "thoughtbot/vim-rspec"
""" NeoBundle "majutsushi/tagbar"
"
"
""" Javascript Bundle
""" NeoBundle "scrooloose/syntastic"
"
"
"
"call neobundle#end()
"
"" Required:
"filetype plugin indent on
"
"" If there are uninstalled bundles found on startup,
"" this will conveniently prompt you to install them.
"NeoBundleCheck
"
""*****************************************************************************
""" Basic Setup
""*****************************************************************************"
""" Encoding
"set encoding=utf-8
"set fileencoding=utf-8
"set fileencodings=utf-8
"
""" Fix backspace indent
"set backspace=indent,eol,start
"
""" allow plugins by file type
"filetype on
"filetype plugin on
"
""" Tabs. May be overriten by autocmd rules
"set expandtab
"set tabstop=2
"set softtabstop=2
"set shiftwidth=2
"
""" Map leader to ,
"let umapleader=','
"
""" Enable hidden buffers
"set hidden
"
""" Searching
"set hlsearch
"set incsearch
"set ignorecase
"set smartcase
"
""" Encoding
"set bomb
"set ttyfast
"set binary
"
""" Directories for swp files
"set nobackup
"set noswapfile
"
"set fileformats=unix,dos,mac
"set backspace=indent,eol,start
"set showcmd
"set shell=/bin/sh
"
""*****************************************************************************
""" Visual Settigns
""*****************************************************************************
"syntax on
"set ruler
"set number
"
"let no_buffers_menu=1
"highlight BadWhitespace ctermbg=red guibg=red
"
"set mousemodel=popup
"set t_Co=256
"set nocursorline
"set guioptions=egmrti
"set gfn=Monospace\ 8
"
"if has("gui_running")
"  if has("gui_mac") || has("gui_macvim")
"    set guifont=Menlo:h12
"    set transparency=7
"  endif
"else
"  let g:CSApprox_loaded = 1
"
"  if $COLORTERM == 'gnome-terminal'
"    set term=gnome-256color
"  else
"    if $TERM == 'xterm'
"      set term=xterm-256color
"    endif
"  endif
"endif
"
"if &term =~ '256color'
"  set t_ut=
"endif
"
""" Disable the blinking cursor.
"set gcr=a:blinkon0
"set scrolloff=3
"
""" Status bar
"set laststatus=2
"
""" allow backspacing over everything in insert mode
"set backspace=indent,eol,start
"
""" Use modeline overrides
"set modeline
"set modelines=10
"
"set title
"set titleold="Terminal"
"set titlestring=%F
"
""set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\ %{fugitive#statusline()}
"
"let g:airline_theme = 'powerlineish'
"let g:airline_enable_branch = 1
"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'
"
""*****************************************************************************
""" Abbreviations
""*****************************************************************************
""" no one is really happy until you have this shortcuts
"cab W! w!
"cab Q! q!
"cab Wq wq
"cab Wa wa
"cab wQ wq
"cab WQ wq
"cab W w
"cab Q q
"
""" NERDTree configuration
"let NERDTreeChDirMode=2
"let NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
"let NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
"let NERDTreeShowBookmarks=1
"let g:nerdtree_tabs_focus_on_files=1
"let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
"let g:NERDTreeWinSize = 20
"set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
"nnoremap <silent> <F2> :NERDTreeFind<CR>
"noremap <F3> :NERDTreeToggle<CR>
"
"" grep.vim
"nnoremap <silent> <leader>f :Rgrep<CR>
"let Grep_Default_Options = '-IR'
"
"" vimshell
"let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
"let g:vimshell_prompt =  '$ '
"nnoremap <silent> <leader>sh :VimShellCreate<CR>
"
""*****************************************************************************
""" Functions
""*****************************************************************************
"function s:setupWrapping()
"  set wrap
"  set wm=2
"  set textwidth=79
"endfunction
"
"function TrimWhiteSpace()
"  let @*=line(".")
"  %s/\s*$//e
"  ''
"endfunction
"
""*****************************************************************************
""" Autocmd Rules
""*****************************************************************************
""" The PC is fast enough, do syntax highlight syncing from start
"autocmd BufEnter * :syntax sync fromstart
"
""" Remember cursor position
"autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
"
""" txt
"au BufRead,BufNewFile *.txt call s:setupWrapping()
"
""" make/cmake
"au FileType make set noexpandtab
"autocmd BufNewFile,BufRead CMakeLists.txt setlocal ft=cmake
"
"if has("gui_running")
"  autocmd BufWritePre * :call TrimWhiteSpace()
"endif
"
"set autoread
"
""*****************************************************************************
""" Mappings
""*****************************************************************************
""" Split
"noremap <Leader>h :<C-u>split<CR>
"noremap <Leader>v :<C-u>vsplit<CR>
"
""" Git
"noremap <Leader>ga :!git add .<CR>
"noremap <Leader>gc :!git commit -m '<C-R>="'"<CR>
"noremap <Leader>gsh :!git push<CR>
"noremap <Leader>gs :Gstatus<CR>
"noremap <Leader>gb :Gblame<CR>
"noremap <Leader>gd :Gvdiff<CR>
"noremap <Leader>gr :Gremove<CR>
"
""" Tabs
"nmap <Tab> gt
"nmap <S-Tab> gT
"nnoremap <silent> <S-t> :tabnew<CR>
"
""" Set working directory
"nnoremap <leader>. :lcd %:p:h<CR>
"
""" Opens an edit command with the path of the currently edited file filled in
"noremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
"
""" Opens a tab edit command with the path of the currently edited file filled
"noremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>
"
""" ctrlp.vim
"set wildmode=list:longest,list:full
"set wildignore+=*.o,*.obj,.git,*.rbc,.pyc,__pycache__
"let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn|tox)$'
"let g:ctrlp_user_command = "find %s -type f | grep -Ev '"+ g:ctrlp_custom_ignore +"'"
"let g:ctrlp_use_caching = 0
"cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>
"noremap <leader>b :CtrlPBuffer<CR>
"let g:ctrlp_map = ',e'
"let g:ctrlp_open_new_file = 'r'
"
"" snippets
"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<tab>"
"let g:UltiSnipsJumpBackwardTrigger="<c-b>"
"let g:UltiSnipsEditSplit="vertical"
"
"" syntastic
"let g:syntastic_always_populate_loc_list=1
"let g:syntastic_error_symbol='✗'
"let g:syntastic_warning_symbol='⚠'
"let g:syntastic_style_error_symbol = '✗'
"let g:syntastic_style_warning_symbol = '⚠'
"let g:syntastic_auto_loc_list=1
"let g:syntastic_aggregate_errors = 1
"
"" vim-airline
"let g:airline_enable_syntastic = 1
"
""" Remove trailing whitespace on <leader>S
"nnoremap <silent> <leader>S :call TrimWhiteSpace()<cr>:let @/=''<CR>
"
""" Copy/Paste/Cut
"noremap YY "+y<CR>
"noremap P "+gP<CR>
"noremap XX "+x<CR>
"
"if has('macunix')
"  " pbcopy for OSX copy/paste
"  vmap <C-x> :!pbcopy<CR>
"  vmap <C-c> :w !pbcopy<CR><CR>
"endif
"
""" Buffer nav
"noremap ,z :bp<CR>
"noremap ,q :bp<CR>
"noremap ,x :bn<CR>
"noremap ,w :bn<CR>
"
""" Close buffer
"noremap ,c :bd<CR>
"
""" Clean search (highlight)
"nnoremap <silent> <leader><space> :noh<cr>
"
""" Vmap for maintain Visual Mode after shifting > and <
"vmap < <gv
"vmap > >gv
"
""" Open current line on GitHub
"noremap ,o :!echo `git url`/blob/`git rev-parse --abbrev-ref HEAD`/%\#L<C-R>=line('.')<CR> \| xargs open<CR><CR>
""" Custom configs
"
"" Tagbar
"nmap <silent> <F4> :TagbarToggle<CR>
"let g:tagbar_autofocus = 1
"
"let g:tagbar_type_go = {
"    \ 'ctagstype' : 'go',
"    \ 'kinds'     : [  'p:package', 'i:imports:1', 'c:constants', 'v:variables',
"        \ 't:types',  'n:interfaces', 'w:fields', 'e:embedded', 'm:methods',
"        \ 'r:constructor', 'f:functions' ],
"    \ 'sro' : '.',
"    \ 'kind2scope' : { 't' : 'ctype', 'n' : 'ntype' },
"    \ 'scope2kind' : { 'ctype' : 't', 'ntype' : 'n' },
"    \ 'ctagsbin'  : 'gotags',
"    \ 'ctagsargs' : '-sort -silent'
"    \ }
"
"
"" vim-python
"autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8 colorcolumn=79
"    \ formatoptions+=croq softtabstop=4 smartindent
"    \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
"
"" jedi-vim
"let g:jedi#popup_on_dot = 0
"let g:jedi#goto_assignments_command = "<leader>g"
"let g:jedi#goto_definitions_command = "<leader>d"
"let g:jedi#documentation_command = "K"
"let g:jedi#usages_command = "<leader>n"
"let g:jedi#rename_command = "<leader>r"
"let g:jedi#show_call_signatures = "0"
"let g:jedi#completions_command = "<C-Space>"
"
"" syntastic
"let g:syntastic_python_checkers=['python', 'flake8']
"
"" vim-airline
"let g:airline#extensions#virtualenv#enabled = 1
"let g:airline#extensions#tagbar#enabled = 1
"
"" Tagbar
"nmap <silent> <F4> :TagbarToggle<CR>
"let g:tagbar_autofocus = 1
"
"
"
"
"let g:rubycomplete_buffer_loading = 1
"let g:rubycomplete_classes_in_global = 1
"let g:rubycomplete_rails = 1
"
"au BufNewFile,BufRead *.rb,*.rbw,*.gemspec set filetype=ruby
"autocmd Filetype ruby setlocal expandtab ts=2 sts=2 sw=2
"
"" Tagbar
"nmap <silent> <F4> :TagbarToggle<CR>
"let g:tagbar_autofocus = 1
"
"let g:tagbar_type_ruby = {
"    \ 'kinds' : [
"        \ 'm:modules',
"        \ 'c:classes',
"        \ 'd:describes',
"        \ 'C:contexts',
"        \ 'f:methods',
"        \ 'F:singleton methods'
"    \ ]
"\ }
"
"
"let g:javascript_enable_domhtmlcss = 1
"
"
""" Include user's local vim config
"if filereadable(expand("~/.vimrc.local"))
"  source ~/.vimrc.local
"endif
"
"" 隠しファイルを表示する
"let NERDTreeShowHidden = 1
""  引数なしで実行したとき、NERDTreeを実行する
"let file_name = expand("%:p")
"if has('vim_starting') &&  file_name == ""
"  autocmd VimEnter * execute 'NERDTree ./'
"endif
"
"" ターミナルでマウスを使用できるようにする
"set mouse=a
"set guioptions+=a
"set ttymouse=xterm2
"set ttym=xterm2
"set list
"set listchars=tab:>.,trail:_,eol:↲,extends:>,precedes:<,nbsp:%
"
"
"autocmd Filetype coffee setlocal expandtab ts=2 sts=2 sw=2
"autocmd Filetype javascript setlocal expandtab ts=2 sts=2 sw=2
"
"let g:nerdtree_tabs_open_on_console_startup=1
"
"" set paste自動化
"if &term =~ "xterm"
"    let &t_ti .= "\e[?2004h"
"    let &t_te .= "\e[?2004l"
"    let &pastetoggle = "\e[201~"
"
"    function XTermPasteBegin(ret)
"        set paste
"        return a:ret
"    endfunction
"
"    noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
"    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
"    cnoremap <special> <Esc>[200~ <nop>
"    cnoremap <special> <Esc>[201~ <nop>
"endif
