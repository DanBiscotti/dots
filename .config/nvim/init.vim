" Plugins
call plug#begin()
Plug 'neovim/nvim-lsp'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/diagnostic-nvim'
Plug 'sbdchd/neoformat'

Plug 'easymotion/vim-easymotion'

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

" Unmap
nnoremap q <nop>

" Editing vimrc
nnoremap <Leader>ev :vsplit ~/.vimrc<CR>
nnoremap <Leader>sv :source ~/.vimrc<CR>

" Quitting and saving
nnoremap <C-w> :w<CR>
nnoremap <C-q> :conf q<CR>

" Navigating panes
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Toggle highlighted search
nnoremap <C-s> :set nohls!<CR>

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

" NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>

" Git
nnoremap <C-v> :GV<CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <C-b> :MerginalToggle<CR>
set updatetime=100 " git gutter

let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_italic=1
colorscheme gruvbox
highlight Normal ctermbg = black

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

let g:python3_host_prog='/usr/bin/python3.8'

     
let g:diagnostic_auto_popup_while_jump = 1
let g:diagnostic_show_sign = 0

" Autocmd
autocmd FileType cs setlocal sw=4 ts=4 sts=4
autocmd BufWritePre *.cs OmniSharpCodeFormat
autocmd FileType javascript setlocal sw=2 ts=2 sts=2
autocmd BufWritePre *.js Neoformat prettier
autocmd FileType typescript setlocal sw=2 ts=2 sts=2
autocmd BufWritePre *.ts Neoformat prettier

lua <<EOF
require'nvim_lsp'.tsserver.setup{}
require'nvim_lsp'.omnisharp.setup{}
EOF
