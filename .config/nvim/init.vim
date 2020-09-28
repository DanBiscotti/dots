" Plugins
call plug#begin()
Plug 'sbdchd/neoformat'
Plug 'easymotion/vim-easymotion'
Plug 'OmniSharp/omnisharp-vim'
Plug 'cespare/vim-toml'
Plug 'preservim/nerdtree'
Plug 'vimwiki/vimwiki'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'idanarye/vim-merginal'
Plug 'morhetz/gruvbox'
Plug 'ryanoasis/vim-devicons'
Plug 'itchyny/lightline'
Plug 'neoclide/coc.nvim'
Plug 'ap/vim-css-color'
Plug 'tpope/vim-rhubarb'
call plug#end()

set t_Co=256
set t_ut=
set t_ZH=[3m

let mapleader=' '

" Settings
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

" coc tab completion
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
	  \ pumvisible() ? "\<C-n>" :
	  \ <SID>check_back_space() ? "\<TAB>" :
	  \ coc#refresh()

let g:python3_host_prog='/usr/bin/python3.8'

" Omnisharp
let g:OmniSharp_highlighting = 0

" Autocmd
autocmd BufWritePre,TextChanged,InsertLeave *.js Neoformat
autocmd BufWritePre,TextChanged,InsertLeave *.cs OmniSharpCodeFormat
