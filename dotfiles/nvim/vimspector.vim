let g:vimspector_enable_mappings = 'HUMAN'

nmap <leader>dd :call vimspector#Launch()<CR>
nmap <leader>dx :call VimspectorReset<CR>
nmap <leader>de :call VimspectorEval<CR>
nmap <leader>dw :call VimspectorWatch<CR>
nmap <leader>do :call VimspectorShowOutput<CR>
