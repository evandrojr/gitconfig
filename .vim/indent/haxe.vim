" Vim indent file
" Language:	haXe
" Maintainer:	None!  Wanna improve this?
" Last Change:	2007 Jan 22

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
   finish
endif
let b:did_indent = 1

" C indenting is not too bad.
setlocal cindent

let b:undo_indent = "setl cin<"