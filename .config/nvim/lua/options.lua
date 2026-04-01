local opt = vim.opt

-- UI
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.cursorline = true
vim.opt.guicursor = ""
vim.g.termresponse_timeout = 0
vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"
-- Tabs & indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

-- Behavior
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.splitright = true
opt.splitbelow = true
opt.ignorecase = true
opt.smartcase = true

-- Performance
opt.updatetime = 250
opt.timeoutlen = 400

-- Leader key
vim.g.mapleader = " "
vim.g.termresponse_timeout = 2500 
