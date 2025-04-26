vim.api.nvim_create_autocmd('BufEnter', {
  pattern = 'copilot-*',
  callback = function()
    vim.keymap.set('n', '<C-l>', '<C-w>l', { buffer = true, silent = true, noremap = true })
    vim.keymap.set('i', '<C-l>', '<C-w>l', { buffer = true, silent = true, noremap = true })
  end
})
