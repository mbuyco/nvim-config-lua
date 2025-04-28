require('utils').setup_config('nvim-treesitter.configs', {
  ensure_installed = {
    "bash",
    "go",
    "javascript",
    "json",
    "lua",
    "php",
    "python",
    "ruby",
    "vim",
    "yaml",
    "vue",
  }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
})
