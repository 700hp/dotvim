if exists("b:did_ftplugin")
        finish
endif
let b:did_ftplugin = 1

setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal textwidth=80
setlocal expandtab
setlocal smarttab
autocmd BufNewFile *.html :0r ~/.vim/templates/template.html | :call cursor(5,12) "| startinsert
