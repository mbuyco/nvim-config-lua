return {
  'L3MON4D3/LuaSnip',
  'Xuyuanp/nerdtree-git-plugin',
  'christoomey/vim-tmux-navigator',
  'github/copilot.vim',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/nvim-cmp',
  'jwalton512/vim-blade',
  'lewis6991/gitsigns.nvim',
  'neovim/nvim-lspconfig',
  'numToStr/Comment.nvim',
  'nvim-lua/plenary.nvim',
  'nvim-lua/popup.nvim',
  'nvim-telescope/telescope-ui-select.nvim',
  'saadparwaiz1/cmp_luasnip',
  'tpope/vim-fugitive',

  -- Colorschemes
  'folke/tokyonight.nvim',
  'gruvbox-community/gruvbox',
  'jacoborus/tender.vim',
  'joshdick/onedark.vim',
  'kaplanz/deku.nvim',
  'marko-cerovac/material.nvim',
  'mhartington/oceanic-next',
  'overcache/NeoSolarized',
  'projekt0n/github-nvim-theme',
  'rebelot/kanagawa.nvim',
  'rktjmp/lush.nvim',
  'sainnhe/everforest',
  'tanvirtin/monokai.nvim',
  'thesimonho/kanagawa-paper.nvim',
  'tomasiser/vim-code-dark',
  'vigoux/oak',

  {
    'windwp/nvim-autopairs',
    opts = {
      map_cr = true,
    },
  },

  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope-live-grep-args.nvim'},
    },
    opts = {
      defaults = {
        file_ignore_patterns = {
          "%node_modules",
          "%vendor",
          ".git",
        },
        vimgrep_arguments = {
          'rg',
          '--vimgrep',
          '--smart-case',
          '--hidden',
          '--fixed-strings',
          '-j1',
        },
        mappings = {
          i = {
            ["<C-h>"] = "which_key",
            ["<C-j>"] = "cycle_history_next",
            ["<C-k>"] = "cycle_history_prev",
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      },
    },
    config = function()
      local telescope = require('telescope')
      local builtin = require('telescope.builtin')

      telescope.load_extension('fzf')
      telescope.load_extension('live_grep_args')
      telescope.load_extension('ui-select')

      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fg', require('telescope').extensions.live_grep_args.live_grep_args, {})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
    end,
  },

  {
    'akinsho/bufferline.nvim',
    dependencies = {'nvim-tree/nvim-web-devicons'},
    opts = {
      options = {
        numbers = 'ordinal',
      },
    },
  },

  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  {
    'MeanderingProgrammer/render-markdown.nvim',
    after = { 'nvim-treesitter' },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
  },

  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = true,
        theme = 'gruvbox',
        component_separators = {'', ''},
        section_separators = {'', ''},
        disabled_filetypes = {},
      },
      sections = {
        lualine_a = {'mode', 'g:coc_status', 'bo:filetype'},
        lualine_b = {'branch'},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'},
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = {},
    },
  },

  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = {
        "bash",
        "css",
        "go",
        "html",
        "javascript",
        "json",
        "lua",
        "php",
        "python",
        "ruby",
        "scss",
        "typescript",
        "vim",
        "vue",
        "yaml",
      },
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
    },
  },

  {
    'preservim/nerdtree',
    config = function()
      vim.api.nvim_set_keymap('n', '<C-t>', ':NERDTreeToggle<CR>', { noremap = true })
      vim.api.nvim_set_keymap('n', '<leader>F', ':NERDTreeFind<CR>', { noremap = true })

      vim.g.NERDTreeFileLines = 1
      vim.g.NERDTreeWinPos = 'right'
      vim.g.NERDTreeWinSize = 50
    end,
  },

  {
    'mhinz/vim-startify',
    config = function()
      vim.g.startify_change_to_dir = 0
    end,
  },

  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    opts = {
      model = 'claude-sonnet-4',
      temperature = 0.1,
      window = {
        layout = 'vertical',
        width = 60,
      }
    },
  },
}
