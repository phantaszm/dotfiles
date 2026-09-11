local opt = vim.opt

-- ui options
opt.background = "dark"
opt.showcmd = true
opt.colorcolumn = "80"
opt.wrap = false
opt.termguicolors = true
opt.scrolloff = 9  -- maintain minimum x lines from top/bottom
-- -- opt.invlist -- show invisible characters

-- spaces for tabs
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smarttab = true

-- hybrid line numbers
opt.number = true
opt.relativenumber = true

-- search
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = false

-- options for vimdiff
opt.diffopt = "filler"
opt.diffopt = opt.diffopt + "iwhite"

-- nice folds
opt.foldmethod = "marker"

-- nav options
opt.autochdir = true

-- misc
opt.undofile = false

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true
