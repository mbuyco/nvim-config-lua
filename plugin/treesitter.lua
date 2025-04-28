require('utils').setup_config('nvim-treesitter.configs', {
  ensure_installed = {
    "bash",
    "css",
    "go",
    "html",
    "javascript",
    "json",
    "lua",
    "php",
    "python",
    "ruby",
    "scss",
    "typescript",
    "vim",
    "vue",
    "yaml",
  }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
})
