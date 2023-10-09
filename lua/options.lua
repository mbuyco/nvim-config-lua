if vim.fn.has("termguicolors") == 1 then
  vim.o.termguicolors = true
end

-- options
vim.opt.autoindent = true
vim.opt.autoread = true
vim.opt.background = 'dark'
vim.opt.clipboard = 'unnamed'
vim.opt.cmdheight = 1
vim.opt.cursorline = true
vim.opt.encoding = 'utf-8'
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
vim.opt.backup = false
vim.opt.compatible = false
vim.opt.errorbells = false
vim.opt.swapfile = false
vim.opt.visualbell = false
vim.opt.wb = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ruler = true
vim.opt.shortmess:append('c')
vim.opt.si = true
vim.opt.smartcase = true
vim.opt.smarttab = true
vim.opt.so = 999
vim.opt.tw = 500
vim.opt.updatetime = 300
vim.opt.wildignore:append('*.o', '*~', '*.pyc', '*/.git/*', '*/.hg/*', '*/.svn/*', '*/.DS_Store')
vim.opt.wildmenu = true
vim.opt.wrap = true

-- 1 tab = 2 spaces
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.tabstop = 4

-- Remove trailing spaces on save
vim.cmd [[autocmd BufWritePre * :%s/\s\+$//e]]
