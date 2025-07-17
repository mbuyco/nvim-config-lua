vim.api.nvim_set_keymap('n', '<C-t>', ':NERDTreeToggle<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>F', ':NERDTreeFind<CR>', { noremap = true })

vim.g.NERDTreeFileLines = 1
vim.g.NERDTreeWinPos = 'right'
vim.g.NERDTreeWinSize = 50
