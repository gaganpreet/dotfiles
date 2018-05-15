set encoding=utf-8

" Figure out the system Python for Neovim.
if exists("$VIRTUAL_ENV")
    let g:python3_host_prog=substitute(system("which -a python3 | head -n2 | tail -n1"), "\n", '', 'g')
else
    let g:python3_host_prog=substitute(system("which python3"), "\n", '', 'g')
endif

set nocompatible
set bs=2
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
au FileType yaml setl sw=2 sts=2 ts=2 et
au FileType go setl sw=8 sts=8 ts=8 noet
au BufNewFile,BufRead *.py set textwidth=99
au BufNewFile,BufRead *.less set filetype=less
highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/


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
Plug 'Valloric/YouCompleteMe'
Plug 'davidhalter/jedi-vim'

Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'Lokaltog/vim-easymotion'
let g:EasyMotion_leader_key = '<Leader>'
Plug 'christoomey/vim-tmux-navigator'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

Plug 'groenewege/vim-less'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'Vimjas/vim-python-pep8-indent'

Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }

Plug 'junegunn/fzf'
Plug 'Shougo/denite.nvim'

Plug 'Shougo/echodoc.vim'
Plug 'prettier/vim-prettier'
Plug 'neomake/neomake'
Plug 'majutsushi/tagbar'
Plug 'altercation/vim-colors-solarized'

Plug 'mileszs/ack.vim'
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

Plug 'vim-airline/vim-airline'
set noshowmode

call plug#end()
filetype plugin indent on

autocmd FileType nerdtree setlocal nocursorcolumn

let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files . -co --exclude-standard']

let g:jsx_ext_required = 0
let g:ycm_enable_diagnostic_highlighting = 1
let g:ycm_enable_diagnostic_signs = 1
let g:python_host_prog='/usr/bin/python3'
let g:neomake_javascript_enabled_makers = ['eslint']
call neomake#configure#automake('rw', 1000)

nnoremap <leader>jd :YcmCompleter GoTo<CR>
nmap <leader>ne :NERDTreeToggle<cr>
nmap <leader>tt :TagbarToggle<CR>
nmap <leader>ak :Ack <cword><CR>
nnoremap <c-p> :FZF<cr>
nnoremap <Tab> :lnext<CR>
nnoremap <S-Tab>: lprev<CR>
