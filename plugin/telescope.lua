local status_ok, telescope = pcall(require, 'telescope')
if not status_ok then
	return
end

-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
telescope.setup {
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--vimgrep',
      '--smart-case',
      '-j1'
    }
  }
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
telescope.load_extension('fzf')
telescope.load_extension('fzy_native')

-- Falling back to find_files if git_files can't find a .git directory
function project_files()
  local function is_git_repo()
    vim.fn.system("git rev-parse --is-inside-work-tree")
    return vim.v.shell_error == 0
  end
  local opts = {}
  if is_git_repo() then
    require("telescope.builtin").git_files({})
  else
    require("telescope.builtin").find_files({})
  end
end

-- Live grep from project git root
function live_grep_git_dir()
  local git_dir = vim.fn.system(string.format("git -C %s rev-parse --show-toplevel", vim.fn.expand("%:p:h")))
  git_dir = string.gsub(git_dir, "\n", "") -- remove newline character from git_dir
  local opts = {
    cwd = git_dir,
  }
  require('telescope.builtin').live_grep(opts)
end

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', project_files, {})
vim.keymap.set('n', '<leader>fg', live_grep_git_dir, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
