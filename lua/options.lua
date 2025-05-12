if vim.fn.has("termguicolors") == 1 then
  vim.o.termguicolors = true
end

-- options
vim.opt.autoindent = true
vim.opt.autoread = true
vim.opt.background = 'dark'
vim.opt.backup = false
vim.opt.clipboard = 'unnamed'
vim.opt.cmdheight = 1
vim.opt.compatible = false
vim.opt.cursorline = true
vim.opt.encoding = 'utf-8'
vim.opt.errorbells = false
vim.opt.expandtab = true
vim.opt.ffs:append('unix', 'dos', 'mac')
vim.opt.hidden = true
vim.opt.history = 500
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.lazyredraw = true
vim.opt.lbr = true
vim.opt.magic = true
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ruler = true
vim.opt.shortmess:append('c')
vim.opt.si = true
vim.opt.smartcase = true
vim.opt.smartindent = false
vim.opt.smarttab = true
vim.opt.so = 999
vim.opt.swapfile = false
vim.opt.switchbuf:append('usetab', 'newtab')
vim.opt.tw = 500
vim.opt.updatetime = 300
vim.opt.visualbell = false
vim.opt.wb = false
vim.opt.wildignore:append('*.o', '*~', '*.pyc', '*/.git/*', '*/.hg/*', '*/.svn/*', '*/.DS_Store')
vim.opt.wildmenu = true
vim.opt.wrap = true

-- Remove trailing spaces on save
vim.cmd [[autocmd BufWritePre * :%s/\s\+$//e]]

-- neovim 0.11 configuration for diagnostics
vim.diagnostic.config({
  virtual_text = true,
  severity_sort = true,
  virtual_lines = { current_line = true },
})
