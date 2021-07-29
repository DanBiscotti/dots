-- need a map method to handle the different kinds of key maps

local function map(mode, combo, mapping, opts)
   local options = {noremap = true}
   if opts then
     options = vim.tbl_extend('force', options, opts)
   end
   vim.api.nvim_set_keymap(mode, combo, mapping, options)
end

vim.g.mapleader = ' '

-- unmap
map('n', 'q', '<nop>', {noremap = true})

-- map
map('n', '<Leader>ev', ':vsplit $MYVIMRC<CR>', {noremap = true}) -- edit vim
map('n', '<Leader>sv', ':source $MYVIMRC<CR>', {noremap = true}) -- source vim

map('n', '<C-w>', ':w<CR>', {noremap = true}) -- save
map('n', '<C-q>', ':conf q<CR>', {noremap = true}) -- quit

map('n', 'U', '<C-r>', {noremap = true}) -- undo

map('n', '<C-s>', ':vsplit ', {noremap = true}) -- vertical split
map('n', '<C-i>', ':split ', {noremap = true}) -- horizontal split

map('n', '<C-j>', '<C-w>j', {noremap = true}) -- move to pane below
map('n', '<C-k>', '<C-w>k', {noremap = true}) -- move to pane above
map('n', '<C-h>', '<C-w>h', {noremap = true}) -- move to pane on right
map('n', '<C-l>', '<C-w>l', {noremap = true}) -- move to pane on left

map('n', 'J', '<C-e>', {noremap = true}) -- scoll up
map('n', 'K', '<C-y>', {noremap = true}) -- scoll down
map('n', 'H', 'zh', {noremap = true}) -- scroll left
map('n', 'L', 'zl', {noremap = true}) -- scroll right
map('v', 'J', '<C-e>', {noremap = true}) -- scoll up
map('v', 'K', '<C-y>', {noremap = true}) -- scoll down
map('v', 'H', 'zh', {noremap = true}) -- scroll left
map('v', 'L', 'zl', {noremap = true}) -- scroll right

map('n', 'm', '<C-d>', {noremap = true}) -- page down
map('n', 'M', '<C-u>', {noremap = true}) -- page up

map('n', '<CR>', ':<C-u>call append(line("."),   repeat([""], v:count1))<CR>', {noremap = true, silent = true}) -- add line below
map('n', '<BS>', ':<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>', {noremap = true, silent = true}) -- add line above

map('v', '<C-j>', ':m \'>+1<CR>gv=gv', {noremap = true}) -- move lines up
map('v', '<C-k>', ':m \'<-2<CR>gv=gv', {noremap = true}) -- move lines down

map('i', '<C-j>', '<Up>', {noremap = true}) -- move up
map('i', '<C-k>', '<Down>', {noremap = true}) -- move down
map('i', '<C-h>', '<Left>', {noremap = true}) -- move left
map('i', '<C-l>', '<Right>', {noremap = true}) -- move right

map('n', '<C-p>', ':Rg<CR>', {noremap = true}) -- fuzzy finder

map('n', '<C-r>', ':%s/s/r/gc<Left><Left><Left><Left><Left><Left>', {noremap = true}) -- search/replace

map('n', '<C-f>', ':NERDTreeToggle<CR>', {noremap = true}) -- file explorer

map('n', '\\', ':set nohls!<CR>', {noremap = true}) -- search highlighting

map('n', '<C-c>', ':GV<CR>', {noremap = true}) -- git commit history
map('n', '<Leader>gs', ':Gstatus<CR>', {noremap = true}) -- git status
map('n', '<C-c>', ':MerginalToggle<CR>', {noremap = true}) -- git branch explorer
