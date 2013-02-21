set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'clang-complete'
Bundle 'vim-scripts/molokai'
"Bundle 'klen/python-mode'
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

set ts=4 sts=4 sw=4 et

if has("autocmd")
    au FileType make setlocal ts=8 sts=8 sw=8 noet
    au FileType yaml setlocal ts=2 sts=2 sw=2 et
    au FileType html setlocal ts=2 sts=2 sw=2 et
    au FileType css setlocal ts=2 sts=2 sw=2 et

    au BufNewFile,BufRead *.go set filetype=go syntax=go

    autocmd BufNewFile *.html :0r ~/.vim/templates/template.html | :call cursor(5,12) "| startinsert
    autocmd BufNewFile *.{h,hpp} call <SID>insert_gates()
    autocmd BufNewFile *.py :0r ~/.vim/templates/template.py | :call cursor(4,1)
    autocmd BufNewFile {makefile,Makefile} :0r ~/.vimi/templates/template.make

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

nmap <F8> :TagbarToggle<CR>

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
    return expand('%:p:~')
endfunction

set laststatus=2
set statusline=\ 
set statusline+=%n:\                 " buffer number
set statusline+=%t                   " filename with full path
set statusline+=%m                   " modified flag
set statusline+=\ \ 
"set statusline+=%{tagbar#currenttag('[%s]\ ','')}
set statusline+=%{fugitive#statusline()}
set statusline+=\ \ 
set statusline+=%{&paste?'[paste]\ ':''}
set statusline+=%{&fileencoding}
set statusline+=\ \ %Y               " type of file
set statusline+=\ %3.3(%c%)          " column number
set statusline+=\ \ %3.9(%l/%L%)     " line / total lines
"set statusline+=\ \ %2.3p%%          " percentage through file in lines
set statusline+=\ \ %{FileSize()}
set statusline+=%<                   " where truncate if line too long
set statusline+=\ \ Dir:%{CurDir()}

set tags+=~/.vim/tags/cpp
set tags+=~/.vim/tags/gl
" build tags of your own project with F12
map <F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

if has('gui_running')
    colorscheme solarized
    set background=light
    set guioptions=
    "set guifont=Liberation\ Mono\ 18
    set guifont=Inconsolata\ 18
    "let g:solarized_termcolors=256
else
    set t_Co=256
    set background=dark
    colorscheme molokai
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
