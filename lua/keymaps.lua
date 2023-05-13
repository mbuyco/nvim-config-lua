-- leader key
vim.cmd('let mapleader = "\\<Tab>"')

-- ctrl+s save
vim.api.nvim_set_keymap('n', '<C-S>', ':up<CR>', { noremap = true })
vim.api.nvim_set_keymap('v', '<C-S>', '<C-C>:up<CR>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-S>', '<C-O>:up<CR>', { noremap = true })

-- increment
vim.api.nvim_set_keymap('n', '+', '<C-a>', { noremap = true })
vim.api.nvim_set_keymap('n', '-', '<C-x>', { noremap = true })

-- :W sudo saves the file
vim.cmd([[command W w !sudo tee % > /dev/null]])

-- search for selected text, forwards or backwards
vim.api.nvim_set_keymap('v', '*', [[:<C-U>let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>\gvy/<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>\gVzv:call setreg('"', old_reg, old_regtype)<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '#', [[:<C-U>let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>\gvy?<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>\gVzv:call setreg('"', old_reg, old_regtype)<CR>S]], { noremap = true, silent = true })

-- disable highlight when <leader><cr> is pressed
vim.api.nvim_set_keymap('n', '<leader><cr>', ':noh<cr>', { noremap = true, silent = true })

-- smart way to move between windows
vim.api.nvim_set_keymap('n', '<C-j>', '<C-W>j', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-W>k', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-h>', '<C-W>h', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-W>l', { noremap = true })

-- close current buffer
vim.api.nvim_set_keymap('n', '<leader>bd', ':bd<cr>', { noremap = true })

-- close all the buffers
vim.api.nvim_set_keymap('n', '<leader>ba', ':bufdo bd<cr>', { noremap = true })

-- buffer navigation
vim.api.nvim_set_keymap('n', '<leader>l', ':bnext<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>h', ':bprevious<cr>', { noremap = true })

-- opens a new tab with the current buffer's path
-- super useful when editing files in the same directory
vim.api.nvim_set_keymap('n', '<leader>te', ':tabedit ' .. vim.fn.expand("%:p:h") .. '/<CR>', { noremap = true })

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
