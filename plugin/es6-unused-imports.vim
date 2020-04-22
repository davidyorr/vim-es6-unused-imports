
if exists('g:loaded_es6_unused_imports')
  finish
endif
let g:loaded_es6_unused_imports = 1

if !exists('g:es6_imports_cterm_fg_color')
  let g:es6_imports_cterm_fg_color = 'blue'
endif

if !exists('g:es6_imports_cterm_bg_color')
  let g:es6_imports_cterm_bg_color = 'darkred'
endif

if !exists('g:es6_imports_gui_fg_color')
  let g:es6_imports_gui_fg_color = 'blue'
endif

if !exists('g:es6_imports_gui_bg_color')
  let g:es6_imports_gui_bg_color = 'darkred'
endif

if !exists('g:es6_imports_excludes')
  let g:es6_imports_excludes = ['']
endif

function! s:highlight_unused_imports()
  call s:clear_highlights()
  execute 'highlight unusedimport ctermfg='.g:es6_imports_cterm_fg_color.' guifg='.g:es6_imports_gui_fg_color.' ctermbg='.g:es6_imports_cterm_bg_color.' guibg='.g:es6_imports_gui_bg_color

  let matches = []
  let origStartLine = line('.')
  let origStartCol = line('.')
  call cursor(1, 1)

  " search for the first line that is not blank, a comment, or an import statement
  let startLine = search('\v(^\s*([\/]{2,})?\s*import\s+(.+)\s+from\s+(.+)?|^\s*$)@<!$') - 1

  let currentLine = 0
  while currentLine < startLine
    let currentLine += 1
    let line = getline(currentLine)
    " skip empty lines
    if empty(line)
      continue
    endif
    " skip commented out lines
    if line =~ '\v^\s*\/\/'
      continue
    endif
    let import_str = matchstr(line, '\v(^\s*([\/]{2,})?\s*import\zs.*\zefrom)')
    " delete all curly braces, commas, and '<keyword or asterisk> as '
    let import_str = substitute(import_str, '{\|}\|,\|\n\|\(\k\|\*\)\+\s\+as\s\+', '', 'g')
    let sp = split(import_str)

    for word in sp
      " don't search if the word is in the excludes list
      if (index(g:es6_imports_excludes, word) >= 0)
        continue
      endif
      call cursor(startLine, 1)
      let match_found = search('\v(//.*)@<!<' . word . '>', 'nW')
      if match_found == 0
        call add(matches, matchadd('unusedimport', '^' . line . '$'))
      endif
    endfor
  endwhile

  " reset the cursor to its original position
  call cursor(origStartLine, origStartCol)
endfunction

function! s:clear_highlights()
  call clearmatches()
endfunction

command! ES6ImportsHighlight call s:highlight_unused_imports()
command! ES6ImportsClear call s:clear_highlights()
