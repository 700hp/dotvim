if exists("b:did_ftplugin")
        finish
endif
let b:did_ftplugin = 1

setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal textwidth=80
setlocal expandtab
setlocal smarttab
setlocal keywordprg=help
nnoremap K :help <C-R><C-W><CR>
