local utils = require('utils')

local lsp_servers = {
  'emmet_language_server',
  'html',
  'laravel_ls',
  'lua_ls',
  'phpactor',
  'pyright',
  'ts_ls',
  'volar',
}

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', '<C-w>]<CR>', opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

local cmp_nvim_lsp = utils.get_package('cmp_nvim_lsp')
if not cmp_nvim_lsp then
  return
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = cmp_nvim_lsp.default_capabilities()
local lspconfigMap = {
  emmet_language_server = {
    filetypes = {
      "css",
      "eruby",
      "html",
      "javascript",
      "javascriptreact",
      "less",
      "sass",
      "scss",
      "php",
      "pug",
      "typescriptreact",
    },
    -- Read more about this options in the [vscode docs](https://code.visualstudio.com/docs/editor/emmet#_emmet-configuration).
    -- **Note:** only the options listed in the table are supported.
    init_options = {
      ---@type table<string, string>
      includeLanguages = {},
      --- @type string[]
      excludeLanguages = {},
      --- @type string[]
      extensionsPath = {},
      --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
      preferences = {},
      --- @type boolean Defaults to `true`
      showAbbreviationSuggestions = true,
      --- @type "always" | "never" Defaults to `"always"`
      showExpandedAbbreviation = "always",
      --- @type boolean Defaults to `false`
      showSuggestionsAsSnippets = false,
      --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
      syntaxProfiles = {},
      --- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
      variables = {},
    },
  },

  -- volar config
  volar = {
    filetypes = {
      'typescript',
      'javascript',
      'javascriptreact',
      'typescriptreact',
      'vue',
    },
    init_options = {
      vue = {
        hybridMode = false,
      },
    },
  },

  -- phpactor config
  phpactor = {
    cmd = { 'phpactor', 'language-server', '-vvv' },
    init_options = {
      ['language_server_phpstan.enabled'] = true,
      -- ['php_code_sniffer.enabled'] = true,
    },
  },
}

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
for _, lsp in ipairs(lsp_servers) do
  local config = {
    capabilities = capabilities,
  }

  if lspconfigMap[lsp] then
    for k, v in pairs(lspconfigMap[lsp]) do
      config[k] = v
    end
  end

  vim.lsp.enable(lsp)
  vim.lsp.config(lsp, config)
end

-- luasnip setup
local luasnip = require('luasnip')

-- nvim-cmp setup
local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
    ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
    -- C-b (back) C-f (forward) for snippet placeholder navigation.
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
})

-- neovim 0.11 configuration
vim.diagnostic.config({
  virtual_text = true,
  severity_sort = true,
  virtual_lines = { current_line = true },
})
