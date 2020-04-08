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
Plug 'davidhalter/jedi-vim'
Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'Lokaltog/vim-easymotion'
Plug 'christoomey/vim-tmux-navigator'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fugitive'
Plug 'tommcdo/vim-fubitive'
Plug 'tpope/vim-rhubarb'
Plug 'groenewege/vim-less'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'junegunn/fzf'
Plug 'w0rp/ale'
Plug 'majutsushi/tagbar'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'mileszs/ack.vim'
Plug 'SkyLeach/pudb.vim'
Plug 'vim-airline/vim-airline'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue'] }
Plug 'ambv/black'
Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}
Plug 'vim-vdebug/vdebug'
Plug 'preservim/nerdcommenter'
set noshowmode

call plug#end()
filetype plugin indent on

if executable('ag')
    let g:ackprg = 'ag'
endif


autocmd FileType nerdtree setlocal nocursorcolumn

let g:EasyMotion_leader_key = '<Leader>'
let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files . -co --exclude-standard']

set conceallevel=0
map <leader>cl :exec &conceallevel ? "set conceallevel=0" : "set conceallevel=1"<CR>

let g:jsx_ext_required = 0
let b:ale_fixers = ['prettier', 'eslint']
let g:ale_linters = {'javascript': ['eslint', 'flow']}                                                                                                                                   
let g:prettier#exec_cmd_async = 1
let NERDTreeIgnore = ['\.pyc$']

set pastetoggle=<F2>
nnoremap <leader>jd :YcmCompleter GoTo<CR>
nmap <leader>ne :NERDTreeToggle<cr>
nmap <leader>nf :NERDTreeFind<cr>
nmap <leader>tt :TagbarToggle<CR>
nmap <leader>ak :Ack <cword><CR>
nnoremap <c-p> :FZF<cr>
nnoremap <S-Tab>: lprev<CR>
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> pudb :let a='from pudb.remote import set_trace; set_trace(host="0.0.0.0", port=6899, term_size=(160, 48))'\|put=a<cr>

" Copy file name
nmap ,cfn :let @+=expand("%")<CR>
" Copy file path to clipboard
nmap ,cfp :let @+=expand("%:p")<CR>

set splitbelow
set splitright
