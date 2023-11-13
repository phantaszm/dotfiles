-- ui options
vim.opt.background = "dark"
vim.opt.showcmd = true

-- spaces for tabs
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smarttab = true

-- hybrid line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- options for vimdiff
vim.opt.diffopt = "filler"
vim.opt.diffopt = vim.opt.diffopt + "iwhite"

-- nice folds
vim.opt.foldmethod = "marker"

-- nav options
vim.opt.autochdir = true
