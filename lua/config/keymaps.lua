-- leader key
vim.g.mapleader = ' '

-- ctrl+s save
vim.api.nvim_set_keymap('n', '<C-S>', ':w<CR>', { noremap = true })
vim.api.nvim_set_keymap('v', '<C-S>', '<C-C>:w<CR>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-S>', '<C-O>:w<CR>', { noremap = true })

-- increment
vim.api.nvim_set_keymap('n', '+', '<C-a>', { noremap = true })
vim.api.nvim_set_keymap('n', '-', '<C-x>', { noremap = true })

-- :W sudo saves the file
vim.cmd([[command W w !sudo tee % > /dev/null]])

-- disable highlight when <leader><cr> is pressed
vim.api.nvim_set_keymap('n', '<leader><cr>', ':noh<cr>', { noremap = true, silent = true })

-- smart way to move between windows
vim.api.nvim_set_keymap('n', '<C-j>', '<C-W>j', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-W>k', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-h>', '<C-W>h', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-W>l', { noremap = true })

-- close current buffer
vim.api.nvim_set_keymap('n', '<leader>bd', ':bd<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>bq', ':%bd|e#|bd#<cr>', { noremap = true })

-- close all the buffers
vim.api.nvim_set_keymap('n', '<leader>ba', ':bufdo bd<cr>', { noremap = true })

-- buffer navigation
vim.api.nvim_set_keymap('n', '<leader>l', ':bnext<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>h', ':bprevious<cr>', { noremap = true })

-- opens a new tab with the current buffer's path
-- super useful when editing files in the same directory
vim.api.nvim_set_keymap('n', '<leader>te', ':tabedit ' .. vim.fn.expand("%:p:h") .. '/<CR>', { noremap = true })

-- duplicate current buffer to a tab
vim.api.nvim_set_keymap('n', '<leader>td', ':tabedit %<CR>', { noremap = true })

-- remap vim 0 to first non-blank character
vim.api.nvim_set_keymap('n', '0', '^', { noremap = true })

-- remove the windows ^m - when the encodings gets messed up
vim.api.nvim_set_keymap('n', '<leader>m', 'mmHmt:%s/<C-V><CR>//ge<CR>\'tzt\'m', { noremap = true })

-- quickly open a buffer for scribble
vim.api.nvim_set_keymap('n', '<leader>q', ':e ~/buffer<CR>', { noremap = true })

-- quickly open a markdown buffer for scribble
vim.api.nvim_set_keymap('n', '<leader>x', ':e ~/buffer.md<CR>', { noremap = true })

-- toggle paste mode on and off
vim.api.nvim_set_keymap('n', '<leader>pp', ':setlocal paste!<CR>', { noremap = true })

-- toggle comment
vim.api.nvim_set_keymap('n', '<C-_>', 'gcc', { silent = true })
vim.api.nvim_set_keymap('v', '<C-_>', 'gc', { silent = true })

-- primeagean remap
vim.api.nvim_set_keymap('x', '<leader>p', '"_dP', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>dl', function ()
  if vim.diagnostic.config().virtual_lines then
		vim.diagnostic.config({ virtual_lines = false })
	else
		vim.diagnostic.config({ virtual_lines = { current_line = true } })
	end
end, { noremap = true, silent = true })

vim.keymap.set('n', '<leader>dt', function ()
  if vim.diagnostic.config().virtual_text then
    vim.diagnostic.config({ virtual_text = false })
  else
    vim.diagnostic.config({ virtual_text = { spacing = 4, prefix = '' } })
  end
end, { noremap = true, silent = true })

-- disable cmdheight++ on accidental keystroke
vim.api.nvim_set_keymap('n', '<C-w>-', '<nop>', { noremap = true, silent = true })

-- map ctrl 1-9 to buffer tabs
for i = 1, 9 do
  vim.keymap.set('n', '<leader>' .. i, function()
    require('bufferline').go_to_buffer(i, true)
  end, { noremap = true, silent = true })
end
