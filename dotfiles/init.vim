set encoding=utf-8

" Figure out the system Python for Neovim.
let g:python3_host_prog=substitute(system("which python3"), "\n", '', 'g')
let g:neomake_javascript_eslint_exe = $PWD .'/node_modules/.bin/eslint'

set nocompatible
set bs=2
set hidden
filetype off

" Vundle
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
"set cursorline " Highlight cursor line set showmatch " Match brackets
syntax on

" Search related
set incsearch " Incremental search
set hlsearch " Highlight search
set ignorecase
set smartcase " Ignore ignorecase when uppercase characters are present

" Navigation related
set scrolloff=3 " Minimum number of lines to show below/above the cursor

" Shortcuts
set pastetoggle=<F2>

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
" Python autocomplete
"Plug 'Valloric/YouCompleteMe'
Plug 'davidhalter/jedi-vim'
Plug 'srcery-colors/srcery-vim'
"Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
"Plug 'wokalski/autocomplete-flow'
" For func argument completion
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
let g:deoplete#enable_at_startup = 1
let g:neosnippet#enable_completed_snippet = 1

"inoremap <silent> <expr> <Tab> pumvisible() ? "\<C-n>" : deoplete#mappings#manual_complete()
"let g:deoplete#sources#ternjs#docs = 1
"let g:deoplete#sources#ternjs#filetypes = [
"                \ 'jsx',
"                \ 'javascript.jsx',
"                \ 'vue',
"                \ ]

Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'Lokaltog/vim-easymotion'
let g:EasyMotion_leader_key = '<Leader>'
Plug 'christoomey/vim-tmux-navigator'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fugitive'
Plug 'tommcdo/vim-fubitive'
Plug 'tpope/vim-rhubarb'

Plug 'groenewege/vim-less'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'yardnsm/vim-import-cost', { 'do': 'npm install' }
"Plug 'mxw/vim-jsx'
Plug 'Vimjas/vim-python-pep8-indent'

" Plug 'zxqfl/tabnine-vim'

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'make release',
    \ }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

Plug 'junegunn/fzf'
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {}
            "\ 'javascript': ['/usr/bin/javascript-typescript-stdio']
            "\ }
if executable('javascript-typescript-stdio')
  let g:LanguageClient_serverCommands.javascript = ['/usr/bin/javascript-typescript-stdio', '-t', '-l', '/tmp/javascript-typescript-studio.log']
  " Use LanguageServer for omnifunc completion
  autocmd FileType javascript setlocal omnifunc=LanguageClient#complete completefunc=LanguageClient#complete
else
  echo "javascript-typescript-stdio not installed!\n"
  :cq
endif


Plug 'Shougo/denite.nvim'

Plug 'Shougo/echodoc.vim'
Plug 'prettier/vim-prettier'
Plug 'w0rp/ale'
Plug 'majutsushi/tagbar'
Plug 'altercation/vim-colors-solarized'

Plug 'mileszs/ack.vim'
if executable('rg')
    let g:ackprg = 'rg'
endif

Plug 'vim-airline/vim-airline'

Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue'] }

Plug 'ambv/black'
let g:black_linelength=79
set noshowmode

call plug#end()
filetype plugin indent on

autocmd FileType nerdtree setlocal nocursorcolumn

let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files . -co --exclude-standard']

let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_flow = 1
let g:javascript_conceal_function             = "ƒ"
let g:javascript_conceal_null                 = "ø"
let g:javascript_conceal_this                 = "@"
let g:javascript_conceal_return               = "⇚"
let g:javascript_conceal_undefined            = "¿"
let g:javascript_conceal_NaN                  = "ℕ"
let g:javascript_conceal_prototype            = "¶"
let g:javascript_conceal_static               = "•"
let g:javascript_conceal_super                = "Ω"
let g:javascript_conceal_arrow_function       = "⇒"
let g:javascript_conceal_noarg_arrow_function = "🞅"
let g:javascript_conceal_underscore_arrow_function = "🞅"

set conceallevel=0
map <leader>cl :exec &conceallevel ? "set conceallevel=0" : "set conceallevel=1"<CR>

let g:jsx_ext_required = 0
"let g:ycm_enable_diagnostic_highlighting = 1
"let g:ycm_enable_diagnostic_signs = 1
let g:python_host_prog='/usr/bin/python3'
let b:ale_fixers = ['prettier', 'eslint']
let g:ale_linters = {'javascript': ['eslint', 'flow']}                                                                                                                                   
"let g:ale_lint_on_text_changed = 'never'
"let g:neomake_javascript_enabled_makers = ['eslint']
let g:prettier#exec_cmd_async = 1
"call neomake#configure#automake('rw', 1000)
"call deoplete#enable()
"call deoplete#enable_logging('DEBUG', '/tmp/deoplete.log')

nnoremap <leader>jd :YcmCompleter GoTo<CR>
nmap <leader>ne :NERDTreeToggle<cr>
nmap <leader>nf :NERDTreeFind<cr>
nmap <leader>tt :TagbarToggle<CR>
nmap <leader>ak :Ack <cword><CR>
nnoremap <c-p> :FZF<cr>
nnoremap <S-Tab>: lprev<CR>
nnoremap <F5> :call LanguageClient_contextMenu()<CR>

set splitbelow
set splitright
" colorscheme srcery
