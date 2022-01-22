vim.cmd [[packadd packer.nvim]]

return require('packer').startup(
    function()
        -- Packer can manage itself
        use 'wbthomason/packer.nvim'
        use { 'kyazdani42/nvim-tree.lua',
            requires = 'kyazdani42/nvim-web-devicons'
        }
        use 'Shougo/neosnippet.vim'
        use 'Shougo/neosnippet-snippets' 
        use 'Shougo/deoplete.nvim'
        use 'autozimu/LanguageClient-neovim'
        use { 'nvim-treesitter/nvim-treesitter', run = 'TSUpdate' }
        use { 'Yggdroot/LeaderF', run = 'LeaderfInstallCExtension' }
    end
)