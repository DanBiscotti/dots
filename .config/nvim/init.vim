let $VIMUSERRUNTIME = fnamemodify($MYVIMRC, ':p:h')
" Auto install plug if not already
if empty(glob($VIMUSERRUNTIME . '/autoload/plug.vim'))
  silent !curl -fLo $VIMUSERRUNTIME/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
call plug#begin()

if has('nvim-0.5')
    Plug 'neovim/nvim-lsp'
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/completion-nvim'
    Plug 'nvim-lua/diagnostic-nvim'
endif

Plug 'sbdchd/neoformat'
Plug 'OmniSharp/omnisharp-vim'
Plug 'rust-lang/rust.vim'
"Plug 'mattn/emmet-vim' research more first

Plug 'easymotion/vim-easymotion'
Plug 'tmsvg/pear-tree'

Plug 'preservim/nerdtree'
Plug 'vimwiki/vimwiki'

Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'idanarye/vim-merginal'
Plug 'tpope/vim-rhubarb'

Plug 'morhetz/gruvbox'
Plug 'ryanoasis/vim-devicons'
Plug 'ap/vim-css-color'

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'sakhnik/nvim-gdb'
call plug#end()

set t_Co=256
set t_ut=
set t_ZH=[3m

let mapleader=' '

" Settings
set smartindent
set nowrap
set scrolloff=10
set sidescrolloff=10
set list
set listchars=tab:>-,trail:~,extends:>,precedes:<
set number relativenumber

" Unmap
nnoremap q <nop>

" Editing vimrc
nnoremap <Leader>ev :vsplit $MYVIMRC<CR>
nnoremap <Leader>sv :source $MYVIMRC<CR>

" Quitting and saving
nnoremap <C-w> :w<CR>
nnoremap <C-q> :conf q<CR>

" Redo
nnoremap U <C-r>

" Splitting window
nnoremap <C-s> :vsplit 
nnoremap <C-i> :split 

" Navigating panes
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Beginning/end of line
nnoremap { 0
nnoremap } $
vnoremap { 0
vnoremap } $

" Scrolling without moving cursor
nnoremap H zh
nnoremap L zl
nnoremap J <C-e>
nnoremap K <C-y>
vnoremap H zh
vnoremap L zl
vnoremap J <C-e>
vnoremap K <C-y>

" Newline normal mode
nnoremap <silent> <CR> :<C-u>call append(line("."),   repeat([""], v:count1))<CR>
nnoremap <silent> <BS> :<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>

" Moving lines in visual mode
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Moving in insert mode
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

" Page up/down
nnoremap m <C-d>
nnoremap M <C-u>

" Easy motion
nmap <Leader>w <Plug>(easymotion-overwin-w)

" Finding stuff
nnoremap <C-p> :Rg<CR>

" Search and replace
nnoremap <C-r> :%s/s/r/gc<Left><Left><Left><Left><Left><Left>

" Highlighting
nnoremap \ :set nohls!<CR>

" NERDTree
nnoremap <C-f> :NERDTreeToggle<CR>

" Git
nnoremap <C-c> :GV<CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <C-b> :MerginalToggle<CR>
set updatetime=100 " git gutter

let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_italic=1
colorscheme gruvbox
highlight Normal ctermbg = black

if has('nvim-0.5')
    " Use completion-nvim in every buffer
    autocmd BufEnter * lua require'completion'.on_attach()
    autocmd BufEnter * lua require'diagnostic'.on_attach()

    " Use <Tab> and <S-Tab> to navigate through popup menu
    inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

    " Set completeopt to have a better completion experience
    set completeopt=menuone,noinsert,noselect

    " Avoid showing message extra message when using completion
    set shortmess+=c
endif

let g:python3_host_prog='/usr/bin/python3.8'

     
" Diagnostics
nnoremap <C-n> :NextDiagnosticCycle<CR>
let g:diagnostic_auto_popup_while_jump = 1
let g:diagnostic_show_sign = 0

let g:neoformat_only_msg_on_error = 1

" defaults
set ts=2 sts=2 sw=2 expandtab

" Autocmd
autocmd FileType vim setlocal sw=4 ts=4 sts=4 expandtab
autocmd FileType cs setlocal sw=4 ts=4 sts=4 expandtab
"autocmd BufWritePre *.cs OmniSharpCodeFormat
autocmd BufEnter,BufNew *.cshtml setlocal sw=2 ts=2 sts=2 filetype=html expandtab
autocmd FileType javascript setlocal sw=2 ts=2 sts=2 expandtab
autocmd BufWritePre *.js Neoformat prettier
autocmd FileType html setlocal sw=2 ts=2 sts=2 expandtab
autocmd BufWritePre *.html Neoformat prettier
autocmd FileType css setlocal sw=2 ts=2 sts=2 expandtab
autocmd BufWritePre *.css Neoformat prettier
autocmd FileType json setlocal sw=2 ts=2 sts=2
autocmd BufWritePre *.json Neoformat prettier
autocmd FileType typescript setlocal sw=2 ts=2 sts=2 expandtab
autocmd BufWritePre *.ts Neoformat prettier
autocmd FileType sh setlocal sw=4 ts=4 sts=4 expandtab
autocmd FileType zsh setlocal sw=4 ts=4 sts=4 expandtab
autocmd FileType vim setlocal sw=2 ts=2 sts=2 expandtab
autocmd FileType cpp setlocal sw=2 ts=2 sts=2 expandtab
autocmd FileType yaml setlocal sw=2 ts=2 sts=2 expandtab

function! SetupLanguageServers()
lua <<EOF
require'nvim_lsp'.tsserver.setup{}
require'nvim_lsp'.omnisharp.setup{}
EOF
endfunction

if has('nvim-0.5')
    call SetupLanguageServers()
endif
