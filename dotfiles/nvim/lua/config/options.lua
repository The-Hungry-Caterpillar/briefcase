-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.maplocalleader = ","
vim.g.r_indent_align_args = 0
vim.opt.wrap = true
vim.opt.scrolloff = 15
vim.g.foldmethod = "manual"
vim.opt.colorcolumn = "80"
vim.opt.cursorline = false
vim.go.background = "dark"
-- vim.o.tabstop = 4 -- A TAB character looks like 4 spaces
-- vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
-- vim.o.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.opt.shiftwidth = 2 -- Number of spaces inserted when indenting
vim.opt.smartindent = false
vim.g.autoformat = true
