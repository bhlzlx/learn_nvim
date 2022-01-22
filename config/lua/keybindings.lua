vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }

map("n", "<C-u>", "9k", opt)
map("n", "<C-d>", "9j", opt)

map("n", "K", ":call LanguageClient#textDocument_hover()<CR>", opt)
map("n", "gd", ":call LanguageClient#textDocument_definition()<CR>", opt)
map("n", "<F2>", ":call LanguageClient#textDocument_rename()<CR>", opt)

-- map("i", "<C-k>", ":neosnippet_expand_or_jump")
-- map("s", "<C-k>", ":neosnippet_expand_or_jump")
-- map("x", "<C-k>", ":neosnippet_expand_target")