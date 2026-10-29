local lsp_servers = {
  'denols',
  'emmet_language_server',
  'gopls',
  'graphql',
  'html',
  'intelephense',
  'laravel_ls',
  'lua_ls',
  'phpactor',
  'pyright',
  'robotframework_ls',
  'svelte',
  'ts_ls',
  'tsc',
  'vue_ls',
}

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

local cmp_nvim_lsp = require('cmp_nvim_lsp')
if not cmp_nvim_lsp then
  return
end

local function uses_ts7(bufnr)
  for dir in vim.fs.parents(vim.api.nvim_buf_get_name(bufnr)) do
    local pkg = dir .. '/node_modules/typescript/package.json'
    if vim.uv.fs_stat(pkg) then
      local ok, json = pcall(vim.json.decode, vim.fn.readblob(pkg))
      local version = ok and vim.version.parse(json.version or '')
      return version and version.major >= 7 or false
    end
  end
  return false
end

local function gate_on_ts7(server, want_ts7)
  local root_dir = vim.lsp.config[server].root_dir
  return {
    root_dir = function(bufnr, on_dir)
      if uses_ts7(bufnr) == want_ts7 then
        root_dir(bufnr, on_dir)
      end
    end,
  }
end

local lspconfigMap = {
  emmet_language_server = {
    filetypes = {
      "blade",
      "css",
      "eruby",
      "html",
      "javascript",
      "javascriptreact",
      "less",
      "sass",
      "scss",
      "svelte",
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

  -- phpactor config
  phpactor = {
    cmd = { 'phpactor', 'language-server', '-vvv' },
    init_options = {
      ['language_server_configuration.auto_config'] = false,
      ['language_server.diagnostic_exclude_paths'] = {
        'vendor/**/*',
      },
      -- ['php_code_sniffer.enabled'] = true,
    },
  },

  pyright = {
    settings = {
      python = {
        analysis = {
          diagnosticSeverityOverrides = {
            reportUnusedImport = "warning",
            reportUnusedVariable = "warning",
          },
        },
      },
    },
  },

  ts_ls = gate_on_ts7('ts_ls', false),
  tsc = gate_on_ts7('tsc', true),
}

-- Enable/configure language servers
for _, lsp in ipairs(lsp_servers) do
  local config = {}

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
    { name = 'emoji' },
  },
})

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
    vim.keymap.set('n', 'gd', '<C-]>', opts) -- uncomment to enable goto definition in horizontal split
    -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
