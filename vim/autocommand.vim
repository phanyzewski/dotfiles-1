filetype plugin indent on
syntax on

" on opening the file, clear search-highlighting
autocmd BufReadCmd set nohlsearch

augroup myfiletypes
  autocmd!
  " Include ! as a word character, so dw will delete all of e.g. gsub!,
  " and not leave the "!"
  au FileType ruby,eruby,yaml set iskeyword+=!,?
  au FileType ruby,eruby,yaml set isfname=_,-,48-57,A-Z,a-z,/

  " treat extra files like ruby
  au BufRead,BufNewFile *.ru,Gemfile,Guardfile,.simplecov setf ruby

  " It's Markdown, not modula2, you infernal machine
  au BufRead,BufNewFile *.md set syntax=markdown filetype=markdown

  " Highlight words to avoid in tech writing
  " http://css-tricks.com/words-avoid-educational-writing/
  highlight TechWordsToAvoid ctermbg=red ctermfg=white
  match TechWordsToAvoid /\cobviously\|basically\|simply\|of\scourse\|clearly\|just\|everyone\sknows\|however\|so,\|easy/
  autocmd BufWinEnter *.md match TechWordsToAvoid /\cobviously\|basically\|simply\|of\scourse\|clearly\|just\|everyone\sknows\|however,\|so,\|easy/
  autocmd InsertEnter *.md match TechWordsToAvoid /\cobviously\|basically\|simply\|of\scourse\|clearly\|just\|everyone\sknows\|however,\|so,\|easy/
  autocmd InsertLeave *.md match TechWordsToAvoid /\cobviously\|basically\|simply\|of\scourse\|clearly\|just\|everyone\sknows\|however,\|so,\|easy/
  autocmd BufWinLeave *.md call clearmatches()

  au BufRead,BufNewFile *.coffee set syntax=coffee

  au BufRead,BufNewFile *.go setf go

  " .gitconfig and gitconfig are the same
  au BufRead,BufNewFile gitconfig set syntax=gitconfig

  au BufNewFile,BufRead .tmux.conf*,tmux.conf* setf tmux

  au BufRead /usr/share/file/magic/* set syntax=magic
augroup END

" When editing a file, always jump to the last known cursor position.
autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif
