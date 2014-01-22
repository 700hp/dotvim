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

function! New_Class_C(cap_class_name, l_class_name)
   insert
#include "l_class_name.h"

cap_class_name::cap_class_name(
)
{
   ;
}

cap_class_name::~cap_class_name(
)
{
   ;
}
.
   %s/cap_class_name/\=a:cap_class_name/g
   %s/l_class_name/\=a:l_class_name/g
endfunction

function! New_Class_H(cap_class_name, u_class_name)
   insert
#ifndef u_class_name_H_
#define u_class_name_H_

class cap_class_name {
public:
   cap_class_name();
   ~cap_class_name();
};

#endif /* u_class_name_H_ */
.
   %s/u_class_name/\=a:u_class_name/g
   %s/cap_class_name/\=a:cap_class_name/g
endfunction

    "let gname = substitute(toupper(expand("%:t")), "\\.", "_", "g")
    "normal! ki

function! New_Class()
   let class_name = expand("%:r")
   let file_type = expand("%:e")
   let l_class_name = tolower(class_name)
   let u_class_name = toupper(class_name)
   let cap_class_name = substitute(class_name, "_", "", "g")

   if file_type =~# "c"
      call New_Class_C(cap_class_name, l_class_name)
   else
      call New_Class_H(cap_class_name, u_class_name)
   endif
endfunction
nmap <F11> :call New_Class()<CR>
