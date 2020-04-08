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
Plug 'davidhalter/jedi-vim'
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
Plug 'mileszs/ack.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'terryma/vim-multiple-cursors'
Plug 'machakann/vim-highlightedyank'
Plug 'tmhedberg/SimpylFold'

" Debugging and linters
Plug 'SkyLeach/pudb.vim'
Plug 'w0rp/ale'
Plug 'ambv/black'  " replace with ale?
Plug 'vim-vdebug/vdebug'

" Others
Plug 'majutsushi/tagbar'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tommcdo/vim-fubitive'
Plug 'tpope/vim-rhubarb'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-airline/vim-airline'
set noshowmode

call plug#end()
filetype plugin indent on

if executable('ag')
    let g:ackprg = 'ag'
endif


autocmd FileType nerdtree setlocal nocursorcolumn

let g:EasyMotion_leader_key = '<Leader>'
let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files . -co --exclude-standard']

let g:airline_theme='base16'
let g:jedi#use_splits_not_buffers = "right"

set conceallevel=0
map <leader>cl :exec &conceallevel ? "set conceallevel=0" : "set conceallevel=1"<CR>

let g:jsx_ext_required = 0
let b:ale_fixers = ['prettier', 'eslint']
let g:ale_linters = {'javascript': ['eslint', 'flow']}                                                                                                                                   
let g:prettier#exec_cmd_async = 1
let NERDTreeIgnore = ['\.pyc$']

nnoremap <leader>jd :YcmCompleter GoTo<CR>
nmap <leader>ne :NERDTreeToggle<cr>
nmap <leader>nf :NERDTreeFind<cr>
nmap <leader>tt :TagbarToggle<CR>
nmap <leader>ak :Ack <cword><CR>
nnoremap <c-p> :FZF<cr>
nnoremap <S-Tab>: lprev<CR>
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> pudb :let a='from pudb.remote import set_trace; set_trace(host="0.0.0.0", port=6899, term_size=(160, 48))'\|put=a<cr>

" coc.nvim suggested config
set cmdheight=2
set updatetime=300
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
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
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

"" End coc.nvim config

" Copy file name
nmap ,cfn :let @+=expand("%")<CR>
" Copy file path to clipboard
nmap ,cfp :let @+=expand("%:p")<CR>

set splitbelow
set splitright
