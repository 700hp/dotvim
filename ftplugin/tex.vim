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

exec("setlocal dictionary+=".$HOME."/.vim/dictionaries/".expand('<amatch>'))
