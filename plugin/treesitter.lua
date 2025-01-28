local status_ok, treesitter = pcall(require, 'nvim-treesitter')
if not status_ok then
	return
end

require'nvim-treesitter.configs'.setup {
    ensure_installed = {
        "bash",
        "javascript",
        "json",
        "lua",
        "php",
        "python",
        "ruby",
        "vim",
        "yaml",
        "vue"
    }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
}
