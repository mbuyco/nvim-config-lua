if vim.fn.has("termguicolors") == 1 then
  vim.o.termguicolors = true
end

-- options
vim.cmd [[set autoindent]]
vim.cmd [[set autoread]]
vim.cmd [[set background=dark]]
vim.cmd [[set clipboard=unnamed]]
vim.cmd [[set cmdheight=1]]
vim.cmd [[set cursorline]]
vim.cmd [[set encoding=utf-8]]
vim.cmd [[set expandtab]]
vim.cmd [[set ffs=unix,dos,mac]]
vim.cmd [[set hidden]]
vim.cmd [[set history=500]]
vim.cmd [[set hlsearch]]
vim.cmd [[set ignorecase]]
vim.cmd [[set incsearch]]
vim.cmd [[set lazyredraw]]
vim.cmd [[set lbr]]
vim.cmd [[set magic]]
vim.cmd [[set mouse=a]]
vim.cmd [[set nobackup]]
vim.cmd [[set nocompatible]]
vim.cmd [[set noerrorbells]]
vim.cmd [[set noswapfile]]
vim.cmd [[set novisualbell]]
vim.cmd [[set nowb]]
vim.cmd [[set number]]
vim.cmd [[set relativenumber]]
vim.cmd [[set ruler]]
vim.cmd [[set shortmess+=c]]
vim.cmd [[set si]]
vim.cmd [[set smartcase]]
vim.cmd [[set smarttab]]
vim.cmd [[set so=999]]
vim.cmd [[set tw=500]]
vim.cmd [[set updatetime=300]]
vim.cmd [[set wildignore=*.o,*~,*.pyc,*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store]]
vim.cmd [[set wildmenu]]
vim.cmd [[set wrap]]

-- 1 tab = 2 spaces
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.tabstop = 4

-- Remove trailing spaces on save
vim.cmd [[autocmd BufWritePre * :%s/\s\+$//e]]
