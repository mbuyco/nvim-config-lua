local telescope = require('utils').get_package('telescope')
if not telescope then
	return
end

local builtin = require('telescope.builtin')

-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
telescope.setup({
  defaults = {
    file_ignore_patterns = {
      "%node_modules",
      "%vendor",
      ".git"
    },
    vimgrep_arguments = {
      'rg',
      '--vimgrep',
      '--smart-case',
      '--hidden',
      '--fixed-strings',
      '-j1'
    },
    mappings = {
      i = {
        ["<C-h>"] = "which_key",
        ["<C-j>"] = "cycle_history_next",
        ["<C-k>"] = "cycle_history_prev"
      }
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      }
    }
  }
})

-- Load extensions
telescope.load_extension('fzf')
telescope.load_extension('live_grep_args')

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', require('telescope').extensions.live_grep_args.live_grep_args, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
