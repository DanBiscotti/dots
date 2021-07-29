vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10

vim.opt.list = true -- whitespace
vim.opt.listchars.tab = ">-"
vim.opt.listchars.trail = "~"
vim.opt.listchars.extends = ">"
vim.opt.listchars.precedes = "<"

local indent = 2
vim.opt.tabstop = indent
vim.opt.shiftwidth = indent
vim.opt.softtabstop = indent
vim.opt.expandtab = true

vim.opt.termguicolors = true
vim.opt.background = 'dark'
vim.cmd([[colorscheme gruvbox]])
vim.g.gruvbox_contrast_dark = 'hard'
vim.cmd('syntax enable')

vim.g.python3_host_prog='usr/bin/python3'
