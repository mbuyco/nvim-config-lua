require('config.lazy')

-- Set default colorscheme
local color = require('config.color')
vim.cmd('colorscheme ' .. color)

-- Set default background (light/dark)
local background = require('config.background')
vim.cmd('set background=' .. background)
