return require('packer').startup(function()
    -- packer
    use 'wbthomason/packer.nvim'

    -- colorscheme
    use 'folke/tokyonight.nvim'
    use 'gruvbox-community/gruvbox'
    use 'jacoborus/tender.vim'
    use 'joshdick/onedark.vim'
    use 'mhartington/oceanic-next'
    use 'overcache/NeoSolarized'
    use 'sainnhe/everforest'
    use 'tanvirtin/monokai.nvim'
    use 'tomasiser/vim-code-dark'
    use 'tribela/vim-transparent'
    use 'vigoux/oak'
    use { "bluz71/vim-nightfly-colors", as = "nightfly" }

	-- general
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
        local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
        ts_update()
        end,
    }
    use {
        'nvim-telescope/telescope.nvim', branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use 'christoomey/vim-tmux-navigator'
    use 'hashivim/vim-terraform'
    use 'mattn/emmet-vim'
    use 'mhinz/vim-startify'
    use 'nvim-lualine/lualine.nvim'
    use 'phpactor/phpactor'
    use 'posva/vim-vue'
    use 'preservim/nerdcommenter'
    use 'preservim/nerdtree'
    use 'tpope/vim-fugitive'
    use 'vimwiki/vimwiki'
    use 'windwp/nvim-autopairs'
    use "nvim-lua/plenary.nvim"
    use 'neovim/nvim-lspconfig'
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use 'jwalton512/vim-blade'
end)
