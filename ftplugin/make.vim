if exists("b:did_ftplugin")
        finish
endif
let b:did_ftplugin = 1

setlocal tabstop=8
setlocal softtabstop=8
setlocal shiftwidth=8
setlocal textwidth=80
setlocal noexpandtab
setlocal smarttab
autocmd BufNewFile {makefile,Makefile} :0r ~/.vim/templates/template.make
