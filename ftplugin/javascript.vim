runtime plugin/neomake-local-eslint.vim
let s:eslint_path = GetNpmBin('eslint')
let b:neomake_javascript_eslint_exe = substitute(s:eslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
