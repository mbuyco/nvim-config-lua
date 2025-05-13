vim.api.nvim_set_keymap('i', '<leader><Tab>', 'copilot#Accept("\\<CR>")', { silent = true, expr = true, script = true })
vim.g.copilot_no_tab_map = true
vim.g.copilot_settings = { selectedCompletionModel = 'gpt-4o-copilot' }
