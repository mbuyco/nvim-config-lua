-- leader key
vim.cmd('let mapleader = "\\<Tab>"')

-- Functional wrapper for mapping custom keybindings
function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- ctrl+s save
map('n', '<C-S>', ':up<CR>', { noremap = true })
map('v', '<C-S>', '<C-C>:up<CR>', { noremap = true })
map('i', '<C-S>', '<C-O>:up<CR>', { noremap = true })

-- increment
map('n', '+', '<C-a>', { noremap = true })
map('n', '-', '<C-x>', { noremap = true })

-- :W sudo saves the file
vim.cmd([[command W w !sudo tee % > /dev/null]])

-- search for selected text, forwards or backwards
map('v', '*', [[:<C-U>let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>\gvy/<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>\gVzv:call setreg('"', old_reg, old_regtype)<CR>]], { noremap = true, silent = true })
map('v', '#', [[:<C-U>let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>\gvy?<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>\gVzv:call setreg('"', old_reg, old_regtype)<CR>S]], { noremap = true, silent = true })

-- disable highlight when <leader><cr> is pressed
map('n', '<leader><cr>', ':noh<cr>', { noremap = true, silent = true })

-- smart way to move between windows
map('n', '<C-j>', '<C-W>j', { noremap = true })
map('n', '<C-k>', '<C-W>k', { noremap = true })
map('n', '<C-h>', '<C-W>h', { noremap = true })
map('n', '<C-l>', '<C-W>l', { noremap = true })

-- close current buffer
map('n', '<leader>bd', ':bd<cr>', { noremap = true })

-- close all the buffers
map('n', '<leader>ba', ':bufdo bd<cr>', { noremap = true })

-- buffer navigation
map('n', '<leader>l', ':bnext<cr>', { noremap = true })
map('n', '<leader>h', ':bprevious<cr>', { noremap = true })

-- opens a new tab with the current buffer's path
-- super useful when editing files in the same directory
map('n', '<leader>te', ':tabedit ' .. vim.fn.expand("%:p:h") .. '/<CR>', { noremap = true })

-- remap vim 0 to first non-blank character
map('n', '0', '^', { noremap = true })

-- remove the windows ^m - when the encodings gets messed up
map('n', '<leader>m', 'mmHmt:%s/<C-V><CR>//ge<CR>\'tzt\'m', { noremap = true })

-- quickly open a buffer for scribble
map('n', '<leader>q', ':e ~/buffer<CR>', { noremap = true })

-- quickly open a markdown buffer for scribble
map('n', '<leader>x', ':e ~/buffer.md<CR>', { noremap = true })

-- toggle paste mode on and off
map('n', '<leader>pp', ':setlocal paste!<CR>', { noremap = true })

-- map ctrl + / to comment
map('n', '<C-_>', '<leader>c<Space>', { noremap = true })
map('v', '<C-_>', '<leader>c<Space>', { noremap = true })
