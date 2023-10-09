local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  }
  print 'Installing packer close and reopen Neovim...'
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require('packer.util').float { border = 'rounded' }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- Packer
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'

  -- Plugins with options
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end
  }
  use {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    requires = {
      {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope-live-grep-args.nvim'},
    }
  }
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  }
  use {
      'akinsho/bufferline.nvim',
      tag = 'v3.*',
      requires = 'nvim-tree/nvim-web-devicons'
  }
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make'
  }
  -- Plugins dependent on LSP
  use {
    'L3MON4D3/LuaSnip', -- Snippets plugin 'neovim/nvim-lspconfig',
    'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
    'hrsh7th/nvim-cmp', -- Autocompletion plugin
    'mfussenegger/nvim-lint', -- Linter plugin
    'neovim/nvim-lspconfig', -- Collection of configurations for built-in LSP client
    'saadparwaiz1/cmp_luasnip', -- Snippets source for nvim-cmp
    'williamboman/mason-lspconfig.nvim', -- Mason to lspconfig bridge
    'williamboman/mason.nvim', -- Mason configurator
  }
  use {
    'windwp/nvim-autopairs',
    config = function()
      require("nvim-autopairs").setup {}
    end
  }

  -- Colorscheme
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

  -- General
  use 'Xuyuanp/nerdtree-git-plugin'
  use 'christoomey/vim-tmux-navigator'
  use 'dense-analysis/ale'
  use 'jwalton512/vim-blade'
  use 'mattn/emmet-vim'
  use 'mhinz/vim-startify'
  use 'nvim-lualine/lualine.nvim'
  use 'posva/vim-vue'
  use 'preservim/nerdtree'
  use 'tpope/vim-fugitive'
  use 'windwp/nvim-autopairs'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end

  -- Default colorscheme
  vim.cmd [[colorscheme monokai]]
end)
