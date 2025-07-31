require('config.lazy')

-- Set default colorscheme
local color = require('config.color')
vim.cmd('colorscheme ' .. color)