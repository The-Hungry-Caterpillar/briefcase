-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

-- easier escape
map("i", "jk", "<Esc>")

-- <leader>w to save changes
map("n", "<leader>w", vim.cmd.w)

-- pipe shortcut for R
map("i", "jj", " %>%")
-- map("i", "jj", " |>")

-- easier terminal escape
map("t", "<Esc>", "<C-\\><C-n>")
