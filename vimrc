filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'Raimondi/delimitMate.git'
Bundle 'sjl/badwolf'
Bundle 'sjl/gundo.vim'
Bundle 'LaTeX-Box'
Bundle 'LaTeX-Suite-aka-Vim-LaTeX'
Bundle 'itchyny/lightline.vim'
Bundle 'vim-scripts/molokai'
Bundle 'wikitopian/hardmode.git'
Bundle 'altercation/vim-colors-solarized.git'
Bundle 'scrooloose/nerdcommenter.git'
Bundle 'majutsushi/tagbar'
Bundle 'mileszs/ack.vim.git'
Bundle 'troydm/easybuffer.vim.git'
Bundle 'tpope/vim-abolish'
Bundle 'tpope/vim-fugitive.git'
Bundle 'tpope/vim-surround.git'
Bundle 'tpope/vim-unimpaired.git'
Bundle 'tpope/vim-repeat.git'
Bundle 'tpope/vim-vinegar.git'
Bundle 'Valloric/YouCompleteMe'
Bundle 'scrooloose/syntastic.git'

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

set ts=4 sts=4 sw=4 et
nmap <leader>q 0yt=A<C-r>=<C-r>"<CR><Esc>
nmap <leader>e :EasyBufferToggle<CR>
nmap <leader>t :TagbarToggle<CR><C-w><C-w>
nmap <leader>u :GundoToggle()<CR>
nmap <silent> <leader>s :set spelllang=ru<CR>:set spell!<CR>
nmap <silent> <leader>l :set list!<CR>

set clipboard=unnamedplus
set laststatus=2

if has("autocmd")
    set complete+=k
    autocmd! bufwritepost .vimrc source $MYVIMRC
endif

if getfsize(expand("%:p")) > 100 * 1024
	set ttyfast 
	set ttyscroll=3
	set lazyredraw 
	set synmaxcol=128
elseif getfsize(expand("%:p")) > 500 * 1024 
	syntax off
endif

set tags+=~/.vim/tags/cpp
set tags+=~/.vim/tags/gl
" build tags of your own project with F12
map <F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

if has('gui_running')
    set background=dark
    set guioptions=
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
            \ 'separator': { 'left': '▶', 'right': '◀' },
            \ 'subseparator': { 'left': '▷', 'right': '◁' }
            \ }
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
