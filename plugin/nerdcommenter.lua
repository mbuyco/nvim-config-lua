-- create default mappings
vim.g.NERDCreateDefaultMappings = 1

-- add spaces after comment delimiters by default
vim.g.NERDSpaceDelims = 1

-- align line-wise comment delimiters flush left instead of following code indentation
vim.g.NERDDefaultAlign = 'left'

-- use compact syntax for prettified multi-line comments
vim.g.NERDCompactSexyComs = 1

-- custom mapping
vim.api.nvim_set_keymap('n', '<C-_>', '<leader>c<Space>', { silent = true })
vim.api.nvim_set_keymap('v', '<C-_>', '<leader>c<Space>', { silent = true })
