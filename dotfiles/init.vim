set encoding=utf-8
set nocompatible
set bs=2
set hidden
set noshowmode
set termguicolors
filetype off

" Indentation related
set tabstop=4
set expandtab " Expand tab to spaces
set shiftwidth=4
set softtabstop=4
set mouse=a
set autoindent

set dictionary+=/usr/share/dict/words

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

set splitbelow
set splitright
set signcolumn=auto:2 " https://github.com/neoclide/coc.nvim/wiki/F.A.Q#sign-of-diagnostics-not-shown
set conceallevel=0

au FileType html setl sw=2 sts=2 ts=2 et
au FileType htmldjango setl sw=2 sts=2 ts=2 et
au FileType javascript setl sw=2 sts=2 ts=2 et
au FileType typescript setl sw=2 sts=2 ts=2 et
au FileType yaml setl sw=2 sts=2 ts=2 et
au FileType go setl sw=8 sts=8 ts=8 noet
au BufNewFile,BufRead *.less set filetype=less
au BufNewFile,BufRead *.kt set filetype=kotlin
au BufNewFile,BufRead Dockerfile* set filetype=dockerfile
highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Figure out the system Python for Neovim.
let g:python_host_prog=substitute(system("which python3"), "\n", '', 'g')
let g:python3_host_prog=substitute(system("which python3"), "\n", '', 'g')
let g:neomake_javascript_eslint_exe = $PWD .'/node_modules/.bin/eslint'
let g:jedi#auto_initialization = 0   " Use jedi only for refactoring code
let g:jedi#rename_command = "<leader>rj"
let g:disable_key_mappings=1
let g:Hexokinase_highlighters = [ 'backgroundfull' ]
let g:poetv_auto_activate=1
let g:poetv_executables = ['poetry']
let g:EasyMotion_leader_key = '<Leader>'
let g:airline_theme='base16'
let g:jedi#use_splits_not_buffers = "right"
let g:jsx_ext_required = 0
let b:ale_fixers = ['prettier', 'eslint']
let g:ale_linters = {'javascript': ['eslint', 'flow']}                                                                                                                                   
let g:prettier#exec_cmd_async = 1
let NERDTreeIgnore = ['\.pyc$']


if has('nvim')
  let $GIT_EDITOR = 'nvr -cc split --remote-wait'
  autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete
endif

call plug#begin('~/.local/share/nvim/plugged')

" Restore last position
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

""" Plugins 
""" Language plugins
Plug 'davidhalter/jedi-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'groenewege/vim-less'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue'] }
Plug 'sillybun/vim-repl'
Plug 'python-rope/ropevim'
Plug 'yardnsm/vim-import-cost', { 'do': 'npm install' }
Plug 'udalov/kotlin-vim'

" Utility
Plug 'justinmk/vim-sneak'
Plug 'machakann/vim-sandwich'
Plug 'preservim/nerdcommenter'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'terryma/vim-multiple-cursors'
Plug 'machakann/vim-highlightedyank'
Plug 'michaelb/sniprun', {'do': 'bash install.sh'}
Plug 'APZelos/blamer.nvim'

" Debugging and linters
Plug 'SkyLeach/pudb.vim'
Plug 'puremourning/vimspector'

" Others
Plug 'majutsushi/tagbar'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tommcdo/vim-fubitive'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'vimlab/split-term.vim'
Plug 'voldikss/vim-floaterm'
Plug 'tpope/vim-rhubarb'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'christoomey/vim-system-copy'
Plug 'alfredodeza/coveragepy.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'vim-scripts/IndexedSearch'
Plug 'tpope/vim-surround'
Plug 'szw/vim-maximizer'
Plug 'wakatime/vim-wakatime'
call plug#end()
filetype plugin indent on

colorscheme dracula

autocmd FileType nerdtree setlocal nocursorcolumn
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

map <leader>cl :exec &conceallevel ? "set conceallevel=0" : "set conceallevel=1"<CR>

inoremap <expr> <c-x><c-f> fzf#vim#complete#path('fd --type f --hidden --follow --exclude .git -X stat --printf="%Y\t%n\n"')
command! -bang -nargs=?  Files call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)
nnoremap <c-p> :Files<cr>

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
let $FZF_DEFAULT_OPTS = "--bind ctrl-q:select-all+accept "

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

nmap <leader>ne :NERDTreeToggle<cr>
nmap <leader>nf :NERDTreeFind<cr>
nmap <leader>tt :TagbarToggle<CR>
nmap <leader>qr :Rg <c-r><c-w><cr>
noremap <Leader>bf :Buffers<CR>
noremap <Leader>bl :BLines<CR>
noremap <c-s> :RG<CR>
noremap <c-h> :Tags<CR>
noremap <c-_> :GBranches<CR>
noremap <Leader>hi :History<CR>

nnoremap <S-Tab>: lprev<CR>
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> pudb :let a='from pudb.remote import set_trace; set_trace(host="0.0.0.0", port=6899, term_size=(160, 48))'\|put=a<cr>

" Copy file name
nmap ,cfn :let @+=expand("%")<CR>
" Copy file path to clipboard
nmap ,cfp :let @+=expand("%:p")<CR>

" https://vim.fandom.com/wiki/Shifting_blocks_visually
vnoremap > >gv
vnoremap < <gv
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

inoremap <leader>gt <Esc>gt
tnoremap <leader>gt <C-\><C-n>gt
nnoremap <leader>tt <Esc>:TTerm<CR>
nnoremap <leader>ut <Esc>:Term<CR>
nnoremap <leader>vt <Esc>:VTerm<CR>
nnoremap <C-Tab> :bn<CR>
nnoremap <C-S-Tab> :bp<CR>
" Search and replace word under cursor
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/
nnoremap <leader>mt :MaximizerToggle<CR>

""" Terminal mode mappings
tnoremap <Esc> <C-\><C-n>
" To quit float term with esc
autocmd FileType fzf tnoremap <buffer> <Esc> <c-c>
" Alt+[hjkl] to navigate through windows in insert mode
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l

" Alt+[hjkl] to navigate through windows in normal mode
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

inoremap <A-h> <C-w>h
inoremap <A-j> <C-w>j
inoremap <A-k> <C-w>k
inoremap <A-l> <C-w>l

let g:blamer_enabled = 1
let g:blamer_delay = 1000
let g:blamer_date_format = '%Y/%m/%d %H:%M'

let g:UltiSnipsExpandTrigger="<c-U>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

source $HOME/dotfiles/dotfiles/nvim/coc.vim
source $HOME/dotfiles/dotfiles/nvim/vimspector.vim
