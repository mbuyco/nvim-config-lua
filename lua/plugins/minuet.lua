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
    accept = '<leader><Tab>', -- accept whole suggestion
    accept_line = '<M-C-Right>', -- accept one line
    accept_n_lines = '<M-C-Down>', -- accept N lines (prompts for count)
    next = '<M-]>', -- next suggestion (requests one if none shown)
    prev = '<M-[>', -- previous suggestion (requests one if none shown)
    dismiss = '<C-]>', -- dismiss suggestion
    suggest = '<M-\\>', -- request a suggestion now
    -- normal mode
    toggle_auto = '<leader>at', -- toggle auto-trigger for current buffer
    change_model = '<leader>am', -- pick provider/model
  },
}

return {
  'milanglacier/minuet-ai.nvim',
  event = 'InsertEnter',
  cmd = 'Minuet',
  config = function()
    local keymaps = settings.keymaps

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
          api_key = 'TERM', -- ollama needs no key; any always-set env var works
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
          accept_line = keymaps.accept_line or nil,
          accept_n_lines = keymaps.accept_n_lines or nil,
          next = keymaps.next or nil,
          prev = keymaps.prev or nil,
          dismiss = keymaps.dismiss or nil,
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

    local action = require('minuet.virtualtext').action

    -- Accept falls back to typing the keys so <leader><Tab> still inserts text
    -- when no suggestion is shown.
    if keymaps.accept then
      vim.keymap.set('i', keymaps.accept, function()
        if action.is_visible() then
          action.accept()
        else
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keymaps.accept, true, false, true), 'n', false)
        end
      end, { desc = 'Minuet: accept suggestion' })
    end

    if keymaps.suggest then
      vim.keymap.set('i', keymaps.suggest, action.next, { desc = 'Minuet: request suggestion' })
    end

    if keymaps.toggle_auto then
      vim.keymap.set('n', keymaps.toggle_auto, '<cmd>Minuet virtualtext toggle<cr>', { desc = 'Minuet: toggle auto-trigger' })
    end

    if keymaps.change_model then
      vim.keymap.set('n', keymaps.change_model, '<cmd>Minuet change_model<cr>', { desc = 'Minuet: change model' })
    end
  end,
}
