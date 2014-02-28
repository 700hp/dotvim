if exists("b:did_ftplugin")
        finish
endif
let b:did_ftplugin = 1

let g:pymode_lint_write = 0
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal textwidth=80
setlocal smarttab
setlocal expandtab
setlocal nosmartindent
"autocmd BufNewFile *.py :0r ~/.vim/templates/template.py | :call cursor(4,1)
