filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'altercation/vim-colors-solarized.git'
Bundle 'gmarik/vundle'
Bundle 'itchyny/lightline.vim'
Bundle 'LaTeX-Box'
Bundle 'LaTeX-Suite-aka-Vim-LaTeX'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'kien/ctrlp.vim'
Bundle 'majutsushi/tagbar'
Bundle 'mileszs/ack.vim.git'
Bundle 'Raimondi/delimitMate.git'
Bundle 'scrooloose/nerdcommenter.git'
Bundle 'scrooloose/syntastic.git'
Bundle 'sjl/badwolf'
Bundle 'sjl/gundo.vim'
Bundle 'troydm/easybuffer.vim.git'
Bundle 'tpope/vim-abolish'
Bundle 'tpope/vim-fugitive.git'
Bundle 'tpope/vim-surround.git'
Bundle 'tpope/vim-unimpaired.git'
Bundle 'tpope/vim-repeat.git'
Bundle 'tpope/vim-vinegar.git'
Bundle 'vim-scripts/Conque-GDB'
Bundle 'vim-scripts/molokai'
Bundle 'Valloric/YouCompleteMe'
Bundle 'wikitopian/hardmode.git'

nmap <C-Up> [e
nmap <C-Down> ]e
vmap <C-Up> [egv
vmap <C-Down> ]egv

filetype plugin indent on
runtime ftplugin/man.vim

set smartindent
set autoindent
set backspace=indent,eol,start
set cursorline
set cursorcolumn
set fileencodings=utf-8,cp1251

set wildmode=list:longest,full
set wildmenu
set wildignore+=.hg,.git,.svn
set lazyredraw

set incsearch
set hlsearch
set ignorecase
set smartcase
set nu
set foldmethod=syntax
set foldlevelstart=10
set foldnestmax=10
set completeopt=menu,menuone
set pumheight=20

if version >= 703
    set colorcolumn=80
end
syntax enable
if version >= 700
    set undolevels=128
    set undodir=~/.vim/undodir/
    set undofile
    set undolevels=1000
    set undoreload=10000
end
set backup
set backupdir=/var/tmp,/tmp
set backupskip=/tmp/*
set directory=/var/tmp,/tmp
set writebackup

let g:LatexBox_latexmk_options = "-pvc -pdfps"
let g:surround_{char2nr('c')} = "\\\1command\1{\r}"
let g:clang_user_options='|| exit 0'
let g:solarized_termcolors=256
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_always_populate_location_list = 1
let mapleader = ","
let g:delimitMate_expand_cr = 2

set mouse=
function! ToggleMouse()
    if &mouse == 'a'
        set mouse=
        echo "Mouse usage disabled"
    else
        set mouse=a
        echo "Mouse usage enabled"
    endif
endfunction
nnoremap <leader>m :call ToggleMouse()<CR>

set pastetoggle=<leader>p
set clipboard=unnamedplus " http://vim.wikia.com/wiki/Accessing_the_system_clipboard

function! Replace()
    let s:word = input("Replace " . expand('<cword>') . " with:")
    :exe 'bufdo! %s/\<' . expand('<cword>') . '\>/' . s:word . '/gce'
    :unlet! s:word
endfunction
map <Leader>r :call Replace()<CR>
nnoremap <leader>a :%s//<left>

nmap <leader>q 0yt=A<C-r>=<C-r>"<CR><Esc>
nmap <leader>e :EasyBufferToggle<CR>
nmap <leader>t :TagbarToggle<CR><C-w><C-w>
nmap <leader>u :GundoToggle<CR>
nnoremap <Space> za
nnoremap <silent> <Esc><Esc> :nohlsearch<CR><Esc>
nmap <silent> <leader>s :set spelllang=ru<CR>:set spell!<CR>
nmap <silent> <leader>l :set list!<CR>

" Global settings, can be override in ftplugin
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set clipboard=unnamedplus
set laststatus=2

if has("autocmd")
    set complete+=k
    autocmd! bufwritepost .vimrc source $MYVIMRC
endif

set tags+=~/.vim/tags/cpp
set tags+=~/.vim/tags/gl
" build tags of your own project with F12
map <F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

set t_Co=256
set background=light
colorscheme solarized

if has("cscope")
    set csprg=/usr/bin/cscope
    set csto=0
    set cst
    set nocsverb
    if filereadable("cscope.out")
        cs add cscope.out
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    set csverb
endif

let g:lightline = {
            \ 'colorscheme': 'wombat',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ],
            \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
            \ },
            \ 'component_function': {
            \   'fugitive': 'MyFugitive',
            \   'filename': 'MyFilename',
            \   'fileformat': 'MyFileformat',
            \   'filetype': 'MyFiletype',
            \   'fileencoding': 'MyFileencoding',
            \   'mode': 'MyMode',
            \ },
            \ 'component_expand': {
            \   'syntastic': 'SyntasticStatuslineFlag',
            \ },
            \ 'component_type': {
            \   'syntastic': 'error',
            \ },
            \ 'subseparator': { 'left': '|', 'right': '|' }
            \ }

function! MyModified()
    return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
    return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! MyFilename()
    let fname = expand('%:t')
    return fname == '__Tagbar__' ? g:lightline.fname :
                \ fname =~ '__Gundo' ? '' :
                \ ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
                \ ('' != fname ? fname : '[No Name]') .
                \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
    try
        if expand('%:t') !~? 'Tagbar\|Gundo' && &ft !~? 'vimfiler' && exists('*fugitive#head')
            let mark = ''  " edit here for cool mark
            let _ = fugitive#head()
            return strlen(_) ? mark._ : ''
        endif
    catch
    endtry
    return ''
endfunction

function! MyFileformat()
    return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
    return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
    let fname = expand('%:t')
    return fname == '__Tagbar__' ? 'Tagbar' :
                \ fname == '__Gundo__' ? 'Gundo' :
                \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
                \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
    return lightline#statusline(0)
endfunction

augroup AutoSyntastic
    autocmd!
    autocmd BufWritePost *.c,*.cpp call s:syntastic()
augroup END
function! s:syntastic()
    SyntasticCheck
    call lightline#update()
endfunction
