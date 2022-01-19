vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }

map("n", "<C-u>", "9k", opt)
map("n", "<C-d>", "9j", opt)