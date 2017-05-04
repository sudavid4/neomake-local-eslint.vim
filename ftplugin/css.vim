runtime plugin/neomake-local-eslint.vim
let s:stylelint_path = GetNpmBin('stylelint')
let b:neomake_css_stylelint_exe = substitute(s:stylelint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
