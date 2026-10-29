-- Local LLM inline completion (ghost text) via Ollama.
-- Requires: `ollama serve` and `ollama pull qwen2.5-coder:1.5b`
local settings = {
  model = 'qwen2.5-coder:1.5b',
  end_point = 'http://localhost:11434/v1/completions',
  debounce_ms = 300, -- wait after you stop typing before requesting a completion
  throttle_ms = 1000, -- minimum interval between requests
  request_timeout = 3, -- seconds
  context_window = 2048, -- characters of surrounding code sent to the model
  max_tokens = 64,
  filetypes = {
    'blade',
    'css',
    'conf',
    'go',
    'html',
    'javascript',
    'javascriptreact',
    'json',
    'lua',
    'markdown',
    'php',
    'python',
    'scss',
    'sh',
    'svelte',
    'toml',
    'typescript',
    'typescriptreact',
    'vim',
    'vue',
    'yaml',
  },
  -- Copilot-style keymaps. Set any entry to false to disable it.
  keymaps = {
    -- insert mode
    accept = '<C-f>', -- accept whole suggestion
    accept_line = '<M-C-Right>', -- accept one line
    accept_n_lines = '<M-C-Down>', -- accept N lines (prompts for count)
    next = '<M-]>', -- request a suggestion if none shown (n_completions = 1, so no cycling)
    prev = '<M-[>', -- request a suggestion if none shown (n_completions = 1, so no cycling)
    dismiss = '<C-]>', -- dismiss suggestion
    suggest = '<M-\\>', -- discard the current suggestion and request a new one
    -- normal mode
    toggle_auto = '<leader>at', -- toggle auto-trigger for current buffer
    change_model = '<leader>am', -- pick provider/model
  },
}

local keymaps = settings.keymaps

return {
  'milanglacier/minuet-ai.nvim',
  event = 'VeryLazy',
  cmd = 'Minuet',
  keys = vim.tbl_filter(function(spec)
    return spec[1]
  end, {
    { keymaps.toggle_auto, '<cmd>Minuet virtualtext toggle<cr>', desc = 'Minuet: toggle auto-trigger' },
    { keymaps.change_model, '<cmd>Minuet change_model<cr>', desc = 'Minuet: change model' },
  }),
  config = function()
    require('minuet').setup({
      provider = 'openai_fim_compatible',
      n_completions = 1,
      throttle = settings.throttle_ms,
      debounce = settings.debounce_ms,
      request_timeout = settings.request_timeout,
      context_window = settings.context_window,
      provider_options = {
        openai_fim_compatible = {
          name = 'Ollama',
          api_key = function()
            return 'ollama'
          end,
          end_point = settings.end_point,
          model = settings.model,
          optional = {
            max_tokens = settings.max_tokens,
            top_p = 0.9,
          },
        },
      },
      virtualtext = {
        auto_trigger_ft = settings.filetypes,
        show_on_completion_menu = false,
        keymap = {
          accept = keymaps.accept,
          accept_line = keymaps.accept_line,
          accept_n_lines = keymaps.accept_n_lines,
          next = keymaps.next,
          prev = keymaps.prev,
          dismiss = keymaps.dismiss,
        },
      },
    })

    -- minuet enables auto-trigger on FileType, which already fired for buffers
    -- opened before this plugin lazy-loaded.
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_loaded(buf) and vim.tbl_contains(settings.filetypes, vim.bo[buf].filetype) then
        vim.b[buf].minuet_virtual_text_auto_trigger = true
      end
    end

    if keymaps.suggest then
      local action = require('minuet.virtualtext').action
      vim.keymap.set('i', keymaps.suggest, function()
        action.dismiss()
        action.next()
      end, { desc = 'Minuet: request suggestion' })
    end
  end,
}
