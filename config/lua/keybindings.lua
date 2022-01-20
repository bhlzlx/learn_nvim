vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }

map("n", "<C-u>", "9k", opt)
map("n", "<C-d>", "9j", opt)

-- map("i", "<C-k>", ":neosnippet_expand_or_jump")
-- map("s", "<C-k>", ":neosnippet_expand_or_jump")
-- map("x", "<C-k>", ":neosnippet_expand_target")