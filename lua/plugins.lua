local utils = require('utils')
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()
local packer = utils.get_package('packer')

if not packer_bootstrap and not packer then
  return
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

if not packer then
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
  use 'L3MON4D3/LuaSnip' -- Snippets plugin 'neovim/nvim-lspconfig'
  use 'Xuyuanp/nerdtree-git-plugin'
  use 'christoomey/vim-tmux-navigator'
  use 'github/copilot.vim'
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'jwalton512/vim-blade'
  use 'lewis6991/gitsigns.nvim'
  use 'mhinz/vim-startify'
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  use 'numToStr/Comment.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-lua/popup.nvim'
  use 'nvim-lualine/lualine.nvim'
  use 'nvim-telescope/telescope-ui-select.nvim'
  use 'nvim-treesitter/nvim-treesitter'
  use 'preservim/nerdtree'
  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
  use 'tpope/vim-fugitive'
  use 'wbthomason/packer.nvim'
  use 'windwp/nvim-autopairs'

  -- Colorscheme
  use 'folke/tokyonight.nvim'
  use 'gruvbox-community/gruvbox'
  use 'jacoborus/tender.vim'
  use 'joshdick/onedark.vim'
  use 'kaplanz/deku.nvim'
  use 'marko-cerovac/material.nvim'
  use 'mhartington/oceanic-next'
  use 'overcache/NeoSolarized'
  use 'projekt0n/github-nvim-theme'
  use 'rebelot/kanagawa.nvim'
  use 'rktjmp/lush.nvim'
  use 'sainnhe/everforest'
  use 'tanvirtin/monokai.nvim'
  use 'thesimonho/kanagawa-paper.nvim'
  use 'tomasiser/vim-code-dark'
  use 'vigoux/oak'

  -- Plugins with options
  use {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    requires = {
      {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope-live-grep-args.nvim'},
    }
  }
  use {
    'akinsho/bufferline.nvim',
    requires = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('bufferline').setup({
        options = {
          numbers = 'ordinal',
        }
      })
    end
  }
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make',
  }
  use {
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  }
  use {
    'MeanderingProgrammer/render-markdown.nvim',
    after = { 'nvim-treesitter' },
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }, -- if you prefer nvim-web-devicons
    config = function()
        require('render-markdown').setup({})
    end,
  }

  local colorscheme = require('color')

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    packer.sync()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'PackerComplete',
      callback = function()
        vim.cmd('colorscheme ' .. colorscheme)
      end,
    })
  else
    vim.cmd('colorscheme ' .. colorscheme)
  end
end)
