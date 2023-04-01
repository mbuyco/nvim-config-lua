require('plugins')

-- leader key
vim.cmd('let mapleader = "\\<Tab>"')

if vim.fn.has("termguicolors") == 1 then
  vim.o.termguicolors = true
end

-- colorscheme
vim.cmd('colorscheme tokyonight')

-- options
vim.o.autoindent = true
vim.o.autoread = true
vim.o.background = 'dark'
vim.o.clipboard = 'unnamed'
vim.o.cmdheight = 1
vim.o.cursorline = true
vim.o.encoding = 'utf-8'
vim.o.expandtab = true
vim.o.ffs = 'unix,dos,mac'
vim.o.hidden = true
vim.o.history = 500
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.incsearch = true
vim.o.lazyredraw = true
vim.o.lbr = true
vim.o.magic = true
vim.o.mouse = a
vim.o.nobackup = true
vim.o.nocompatible = true
vim.o.noerrorbells = true
vim.o.noswapfile = true
vim.o.novisualbell = true
vim.o.nowb = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.ruler = true
vim.o.shortmess = vim.o.shortmess .. 'c'
vim.o.si = true
vim.o.smartcase = true
vim.o.smarttab = true
vim.o.so = 999
vim.o.tw = 500
vim.o.updatetime = 300
vim.o.wildignore = '*.o,*~,*.pyc,*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store'
vim.o.wildmenu = true
vim.o.wrap = true

-- 1 tab = 2 spaces
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.tabstop = 4

-- return to last cursor position
vim.cmd([[
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
]])

-- enable filetype plugins
vim.cmd('filetype plugin on')
vim.cmd('filetype indent on')

-- transparent background
vim.cmd('hi Normal ctermbg=None')

-- syntax highlighting
vim.cmd('syntax on')

-- remove trailing spaces on save
vim.cmd('autocmd BufWritePre * :%s/\\s\\+$//e')

-- when entering insert mode, relative line numbers are turned off, leaving absoute line numbers turned on.
vim.cmd([[
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave * if &nu | set nornu | endif
augroup END
]])

require('keymap')
