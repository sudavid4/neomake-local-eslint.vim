function! GetNpmBin(binname)
  let dir = getcwd()
  while ! isdirectory(dir . '/node_modules')
    let dir = fnamemodify(dir, ':h')
    if dir == '/'
      break
    end
  endwhile

  let binpath = ''
  if dir != '/'
    let binpath = dir . '/node_modules/.bin/' . a:binname
    if ! filereadable(binpath)
      let binpath = ''
    end
  endif

  if empty(binpath)
    let binpath = system('echo -n $(npm bin)') . '/' . a:binname
  endif

  return binpath
endfunction
