" Taken from https://github.com/derekprior/vim-trimmer

if !exists('g:trimmer_repeated_lines_blacklist')
  let g:trimmer_repeated_lines_blacklist = []
endif

augroup vimTrimmer
  autocmd!
  autocmd BufWritePre * call s:Trim()
augroup END

function! s:Trim()
  let l:pos = getpos('.')
  call s:TrimTrailingWhitespace()
  if index(g:trimmer_repeated_lines_blacklist, &filetype) < 0
    call s:TrimRepeatedBlankLines()
  endif
  call setpos('.', l:pos)
endfunction

function! s:TrimTrailingWhitespace()
  %s/\s\+$//e
endfunction

function! s:TrimRepeatedBlankLines()
  %s/\n\{3,}/\r\r/e
  %s#\($\n\s*\)\+\%$##e
  if &filetype ==? 'ruby'
    " Remove blank lines between "end"s in ruby
    %s/end\n\n\(\s*end\)/end\r\1/e
  endif
endfunction
