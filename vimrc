set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'itchyny/lightline.vim'
Bundle 'abolish.vim'
Bundle 'gmarik/vundle'
Bundle 'vim-scripts/molokai'
Bundle 'git://github.com/ervandew/supertab.git'
Bundle 'git://github.com/wikitopian/hardmode.git'
Bundle 'git://github.com/altercation/vim-colors-solarized.git'
Bundle 'git://github.com/scrooloose/nerdtree.git'
Bundle 'git://github.com/scrooloose/nerdcommenter.git'
Bundle 'git://github.com/majutsushi/tagbar'
Bundle 'git://github.com/mileszs/ack.vim.git'
Bundle 'git://github.com/troydm/easybuffer.vim.git'
Bundle 'git://github.com/tpope/vim-fugitive.git'
Bundle 'git://github.com/tpope/vim-surround.git'
Bundle 'git://github.com/tpope/vim-unimpaired.git'
Bundle 'git://github.com/tpope/vim-repeat.git'
nmap <C-Up> [e
nmap <C-Down> ]e
vmap <C-Up> [egv
vmap <C-Down> ]egv

Bundle 'git://github.com/scrooloose/syntastic.git'

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

set incsearch
set hlsearch
set ignorecase
set smartcase
set nu
set foldmethod=syntax
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

nmap <silent> <leader>s :set spell!<CR>
nmap <silent> <leader>l :set list!<CR>

function! s:insert_gates()
    let gname = substitute(toupper(expand("%:t")), "\\.", "_", "g")
    execute "normal! i#ifndef " . gname
    execute "normal! o#define " . gname
    execute "normal! o"
    execute "normal! o"
    execute "normal! Go#endif /* " . gname . " */"
    normal! ki
endfunction

set ts=4 sts=4 sw=4 noet

if has("autocmd")
    au FileType tex exec("setlocal dictionary+=".$HOME."/.vim/dictionaries/".expand('<amatch>'))
    set complete+=k
    au FileType python setlocal ts=4 sts=4 sw=4 et
    au FileType c setlocal ts=4 sts=4 sw=4 et
    au FileType make setlocal ts=8 sts=8 sw=8 noet
    au FileType yaml setlocal ts=2 sts=2 sw=2 et
    au FileType html setlocal ts=2 sts=2 sw=2 et
    au FileType css setlocal ts=2 sts=2 sw=2 et

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

nmap <leader>t :TagbarToggle<CR>

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

function! CurDir()
    return expand('%:p:h:t')
endfunction

set tags+=~/.vim/tags/cpp
set tags+=~/.vim/tags/gl
" build tags of your own project with F12
map <F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

if has('gui_running')
    set background=light
    set guioptions=
    set guifont=Droid\ Sans\ Mono\ 13
    colorscheme solarized
else
    set t_Co=256
    set background=light
    let g:solarized_termcolors=256
    colorscheme solarized
endif

inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>
vnoremap <Up> <NOP>
vnoremap <Down> <NOP>
vnoremap <Left> <NOP>
vnoremap <Right> <NOP>
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

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
