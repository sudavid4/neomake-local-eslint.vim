function! CreateTernProjectIfNeeded(dir)
    call system('[ ! -f '.a:dir.'/.tern-project ] && echo -e ''{\n'.
                \'  "ecmaVersion": 8,\n'.
                \'  "libs": [\n'.
                \'      "browser",\n'.
                \'      "ecma6"\n'.
                \'  ],\n'.
                \'  "plugins": {\n'.
                \'    "node": {},\n'.
                \'    "modules": {},\n'.
                \'    "es_modules": {},\n'.
                \'    "node_resolve": {},\n'.
                \'    "CommonJS": {},\n'.
                \'    "doc_comment": {\n'.
                \'      "fullDocs": true\n'.
                \'    }\n'.
                \'  }\n'.
                \'}\n'' > '.a:dir.'/.tern-project')
endfunction
function! LocalEslint(dirname)
    if exists('b:neomake_javascript_eslint_exe')
        return
    endif
    " convert windows paths to unix style
    let l:curDir = substitute(a:dirname, '\\', '/', 'g')

    let l:eslintFile = a:dirname . '/node_modules/.bin/eslint'
    if filereadable(l:eslintFile) 
        let b:neomake_javascript_eslint_exe = l:eslintFile
        let b:neomake_javascript_fixlint_exe = l:eslintFile
        call CreateTernProjectIfNeeded(a:dirname)
    else
        " walk to the top of the dir tree
        let l:parentDir = strpart(l:curDir, 0, strridx(l:curDir, '/'))
        if isdirectory(l:parentDir)
            call LocalEslint(l:parentDir)
        endif
    endif
endfunction
call LocalEslint(expand('%:p:h'))
" probably useless
if !exists('b:neomake_javascript_eslint_exe')
    let g:eslint_path = system('PATH=$(npm bin):$PATH && which eslint')
    let b:neomake_javascript_eslint_exe = substitute(g:eslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
endif
