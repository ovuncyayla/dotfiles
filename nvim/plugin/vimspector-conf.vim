fun! GotoWindow(id)
    call win_gotoid(a:id)
    MaximizerToggle
endfun

" Debugger remaps
nnoremap <leader>m :MaximizerToggle!<CR>
nnoremap <leader>qd :call vimspector#Launch()<CR>
nnoremap <leader>qc :call GotoWindow(g:vimspector_session_windows.code)<CR>
nnoremap <leader>qt :call GotoWindow(g:vimspector_session_windows.tagpage)<CR>
nnoremap <leader>qv :call GotoWindow(g:vimspector_session_windows.variables)<CR>
nnoremap <leader>qw :call GotoWindow(g:vimspector_session_windows.watches)<CR>
nnoremap <leader>qs :call GotoWindow(g:vimspector_session_windows.stack_trace)<CR>
nnoremap <leader>qo :call GotoWindow(g:vimspector_session_windows.output)<CR>
nnoremap <leader>qe :call vimspector#Reset()<CR>

nnoremap <leader>qtcb :call vimspector#CleanLineBreakpoint()<CR>

nmap <leader>ql <Plug>VimspectorStepInto
nmap <leader>qj <Plug>VimspectorStepOver
nmap <leader>qk <Plug>VimspectorStepOut
nmap <leader>q_ <Plug>VimspectorRestart
nnoremap <leader>q<space> :call vimspector#Continue()<CR>

nmap <leader>qrc <Plug>VimspectorRunToCursor
nmap <leader>qbb <Plug>VimspectorToggleBreakpoint
nmap <leader>qcbb <Plug>VimspectorToggleConditionalBreakpoint
