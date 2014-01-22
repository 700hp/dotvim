set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'sjl/badwolf'
Bundle 'sjl/gundo.vim'
Bundle 'LaTeX-Box'
Bundle 'LaTeX-Suite-aka-Vim-LaTeX'
Bundle 'itchyny/lightline.vim'
Bundle 'gmarik/vundle'
Bundle 'vim-scripts/molokai'
Bundle 'wikitopian/hardmode.git'
Bundle 'altercation/vim-colors-solarized.git'
Bundle 'scrooloose/nerdtree.git'
Bundle 'scrooloose/nerdcommenter.git'
Bundle 'majutsushi/tagbar'
Bundle 'mileszs/ack.vim.git'
Bundle 'troydm/easybuffer.vim.git'
Bundle 'tpope/vim-abolish'
Bundle 'tpope/vim-fugitive.git'
Bundle 'tpope/vim-surround.git'
Bundle 'tpope/vim-unimpaired.git'
Bundle 'tpope/vim-repeat.git'
Bundle 'Valloric/YouCompleteMe'
nmap <C-Up> [e
nmap <C-Down> ]e
vmap <C-Up> [egv
vmap <C-Down> ]egv

Bundle 'scrooloose/syntastic.git'

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

let g:LatexBox_latexmk_options = "-pvc -pdfps"
let g:surround_{char2nr('c')} = "\\\1command\1{\r}"
let g:clang_user_options='|| exit 0'
let mapleader = ","

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

nnoremap <silent> <Esc><Esc> :nohlsearch<CR><Esc>
nnoremap K :Man <cword><CR>
nnoremap <Space> za

nmap <silent> <leader>s :set spelllang=ru<CR>:set spell!<CR>
nmap <silent> <leader>l :set list!<CR>
nmap <leader>u :GundoToggle()<CR>

function! s:insert_gates()
    let gname = substitute(toupper(expand("%:t")), "\\.", "_", "g")
    execute "normal! i#ifndef " . gname
    execute "normal! o#define " . gname
    execute "normal! o"
    execute "normal! o"
    execute "normal! Go#endif /* " . gname . " */"
    normal! ki
endfunction

set ts=4 sts=4 sw=4 et

if has("autocmd")
    au FileType tex exec("setlocal dictionary+=".$HOME."/.vim/dictionaries/".expand('<amatch>'))
    set complete+=k
    au FileType python setlocal ts=4 sts=4 sw=4 et
    au FileType c setlocal ts=4 sts=4 sw=4 et
    au FileType cpp setlocal ts=4 sts=4 sw=4 et
    au FileType make setlocal ts=8 sts=8 sw=8 noet
    au FileType yaml setlocal ts=2 sts=2 sw=2 et
    au FileType html setlocal ts=2 sts=2 sw=2 et
    au FileType css setlocal ts=2 sts=2 sw=2 et
    au FileType javascript setlocal ts=2 sts=2 sw=2 et
    au FileType no-ft setlocal ts=2 sts=2 sw=2 et

    au BufNewFile,BufRead *.go set filetype=go syntax=go
	au BufRead,BufNewFile *.rc set filetype=rc 
    autocmd BufNewFile,BufRead profile,wmsetup setf infsh
    autocmd BufNewFile,BufRead * if getline(1) =~ '^#!/dis/sh' || getline(1) =~ '^load ' || getline(2) =~ '^load ' | setlocal ft=infsh | endif
 
    autocmd BufNewFile,BufRead mk*          if expand("<afile>") !~ '\.' | setf mkfile | endif
    autocmd BufNewFile,BufRead *.[bm]          setf limbo

    autocmd BufNewFile *.html :0r ~/.vim/templates/template.html | :call cursor(5,12) "| startinsert
    autocmd BufNewFile *.{h,hpp} call <SID>insert_gates()
    autocmd BufNewFile *.py :0r ~/.vim/templates/template.py | :call cursor(4,1)
    autocmd BufNewFile {makefile,Makefile} :0r ~/.vim/templates/template.make
    autocmd BufRead,BufNewFile *.md setlocal textwidth=80

	"autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()

    autocmd! bufwritepost .vimrc source $MYVIMRC
    "au BufNewFile,BufRead *.cpp set syntax=cpp11
    "let c_no_curly_error=1
endif

set autochdir
let NERDTreeChDirMode=2
nmap <Bs> :NERDTreeToggle<CR>
nmap <Home> :NERDTree .<CR>
let NERDTreeShowBookmarks=0
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=0
let NERDTreeKeepInNewTab=0

inoremap {<CR> {<CR>}<Esc>ko
inoremap (<CR> (<CR>)<Esc>ko
inoremap [<CR> [<CR>]<Esc>ko

nmap <leader>t :TagbarToggle<CR><C-w><C-w>

function! FileSize()
    let bytes = getfsize(expand("%:p"))
    if bytes <= 0
        return ""
    endif
    if bytes < 1024
        return bytes . "B"
    else
        return (bytes / 1024) . "K"
    endif
endfunction

if getfsize(expand("%:p")) > 100 * 1024
	set ttyfast 
	set ttyscroll=3
	set lazyredraw 
	set synmaxcol=128
elseif getfsize(expand("%:p")) > 500 * 1024 
	syntax off
endif

function! CurDir()
    return expand('%:p:h:t')
endfunction

set tags+=~/.vim/tags/cpp
set tags+=~/.vim/tags/gl
" build tags of your own project with F12
map <F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

if has('gui_running')
    set background=dark
    set guioptions=
    "set guifont=Droid\ Sans\ Mono\ 13
    set guifont=Inconsolata\ 16
    colorscheme solarized
else
    set t_Co=256
    set background=light
    let g:solarized_termcolors=256
    colorscheme solarized
endif

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

set clipboard=unnamedplus
nmap <leader>q 0yt=A<C-r>=<C-r>"<CR><Esc>
set laststatus=2
let g:lightline = {
            \ 'colorscheme': 'wombat',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
            \ },
            \ 'component': {
            \   'readonly': '%{&filetype=="help"?"":&readonly?"⭤":""}',
            \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
            \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
            \ },
            \ 'component_visible_condition': {
            \   'readonly': '(&filetype!="help"&& &readonly)',
            \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
            \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
            \ },
            \ 'separator': { 'left': '>', 'right': '<' },
            \ 'subseparator': { 'left': '|>', 'right': '<|' }
            \ }
nmap <leader>e :EasyBufferToggle<CR>
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'


function! CapKeywords()
	redir => lst
	silent syntax list sqlKeyword sqlStatement
	redir END
	"for i in split(lst)[6:]
	for i in split(lst)
		:exe '%s/\<' . i . '\>/' . toupper(i) . '/ge'
	endfor
endfunction

nnoremap <leader>h :call CapKeywords()<CR>
