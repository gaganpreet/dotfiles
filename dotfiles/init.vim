set encoding=utf-8

" Figure out the system Python for Neovim.
let g:python_host_prog=substitute(system("which python3"), "\n", '', 'g')
let g:python3_host_prog=substitute(system("which python3"), "\n", '', 'g')
let g:neomake_javascript_eslint_exe = $PWD .'/node_modules/.bin/eslint'

set nocompatible
set bs=2
set hidden
filetype off

call plug#begin('~/.local/share/nvim/plugged')

" Indentation related
set tabstop=4
set expandtab " Expand tab to spaces
set shiftwidth=4
set softtabstop=4
set autoindent

au FileType html setl sw=2 sts=2 ts=2 et
au FileType htmldjango setl sw=2 sts=2 ts=2 et
au FileType javascript setl sw=2 sts=2 ts=2 et
au FileType typescript setl sw=2 sts=2 ts=2 et
au FileType yaml setl sw=2 sts=2 ts=2 et
au FileType go setl sw=8 sts=8 ts=8 noet
au BufNewFile,BufRead *.py set textwidth=99
au BufNewFile,BufRead *.less set filetype=less
highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
let g:ale_completion_enabled = 1


" View related
syntax on

" Search related
set incsearch " Incremental search
set hlsearch " Highlight search
set ignorecase
set smartcase " Ignore ignorecase when uppercase characters are present

" Navigation related
set scrolloff=3 " Minimum number of lines to show below/above the cursor

" Persistent undo
set undofile
set undolevels=1000
set undoreload=1000

" Fold baby fold
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use

""" Plugins 
""" Language plugins
" Plug 'davidhalter/jedi-vim'
Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}
Plug 'groenewege/vim-less'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue'] }

" Utility
Plug 'Lokaltog/vim-easymotion'
Plug 'christoomey/vim-tmux-navigator'
Plug 'preservim/nerdcommenter'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'terryma/vim-multiple-cursors'
Plug 'machakann/vim-highlightedyank'
Plug 'tmhedberg/SimpylFold'

" Debugging and linters
Plug 'SkyLeach/pudb.vim'
" Plug 'w0rp/ale'
Plug 'psf/black', { 'branch': 'stable' }
Plug 'vim-vdebug/vdebug'

" Others
Plug 'majutsushi/tagbar'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tommcdo/vim-fubitive'
Plug 'shumphrey/fugitive-gitlab.vim'
" Plug 'stsewd/fzf-checkout.vim'
Plug 'vimlab/split-term.vim'
Plug 'voldikss/vim-floaterm'
Plug 'tpope/vim-rhubarb'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'christoomey/vim-system-copy'
Plug 'petobens/poet-v'
set noshowmode


call plug#end()
filetype plugin indent on

if executable('ag')
    let g:ackprg = 'ag'
endif

colorscheme dracula

autocmd FileType nerdtree setlocal nocursorcolumn
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:EasyMotion_leader_key = '<Leader>'

let g:airline_theme='base16'
let g:jedi#use_splits_not_buffers = "right"

set conceallevel=0
map <leader>cl :exec &conceallevel ? "set conceallevel=0" : "set conceallevel=1"<CR>

let g:jsx_ext_required = 0
let b:ale_fixers = ['prettier', 'eslint']
let g:ale_linters = {'javascript': ['eslint', 'flow']}                                                                                                                                   
let g:prettier#exec_cmd_async = 1
let NERDTreeIgnore = ['\.pyc$']


command! -bang -nargs=?  GFiles call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)
nnoremap <c-p> :GFiles<cr>

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

nmap <leader>ne :NERDTreeToggle<cr>
nmap <leader>nf :NERDTreeFind<cr>
nmap <leader>tt :TagbarToggle<CR>
nmap <leader>rf :Rg <c-r><c-w><cr>
nmap <leader>rg :RG <CR>
nnoremap <S-Tab>: lprev<CR>
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> pudb :let a='from pudb.remote import set_trace; set_trace(host="0.0.0.0", port=6899, term_size=(160, 48))'\|put=a<cr>

" coc.nvim suggested config
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
autocmd FileType python let b:coc_root_patterns = ['pyproject.toml']
autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')
"" End coc.nvim config

" Copy file name
nmap ,cfn :let @+=expand("%")<CR>
" Copy file path to clipboard
nmap ,cfp :let @+=expand("%:p")<CR>

let g:poetv_auto_activate=1
let g:poetv_executables = ['poetry']

set splitbelow
set splitright
