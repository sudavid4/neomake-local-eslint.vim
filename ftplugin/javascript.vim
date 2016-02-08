let s:eslint_path = system('PATH=$(npm bin):$PATH && which eslint')
let s:stylelint_path = system('PATH=$(npm bin):$PATH && which stylelint')
let b:neomake_javascript_eslint_exe = substitute(s:eslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
let b:neomake_css_stylelint_exe = substitute(s:stylelint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
