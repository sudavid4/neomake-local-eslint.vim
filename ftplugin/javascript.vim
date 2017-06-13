function! LocalEslint(dirname)
    echom a:dirname
    if exists('b:neomake_javascript_eslint_exe')
        return
    endif
    " convert windows paths to unix style
    let l:curDir = substitute(a:dirname, '\\', '/', 'g')

    let l:eslintFile = a:dirname . '/node_modules/.bin/eslint'
    if filereadable(l:eslintFile) 
        let b:neomake_javascript_eslint_exe = l:eslintFile
    else
        " walk to the top of the dir tree
        let l:parentDir = strpart(l:curDir, 0, strridx(l:curDir, '/'))
        if isdirectory(l:parentDir)
            call LocalEslint(l:parentDir)
        endif
    endif
endfunction
call LocalEslint(expand('%:p:h'))
if !exists('b:neomake_javascript_eslint_exe')
    let g:eslint_path = system('PATH=$(npm bin):$PATH && which eslint')
    let b:neomake_javascript_eslint_exe = substitute(g:eslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
endif
