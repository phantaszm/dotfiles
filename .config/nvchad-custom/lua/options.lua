require "nvchad.options"

-- add yours here!

-- Only what nvchad.options does not already set. Core covers 2-space
-- indent, number, ignorecase/smartcase, undofile and clipboard=unnamedplus.
local opt = vim.opt

-- ui
opt.colorcolumn = "80"
opt.wrap = false
opt.scrolloff = 9 -- keep minimum x lines from top/bottom
opt.relativenumber = true -- hybrid with core's number

-- search
opt.hlsearch = false

-- vimdiff
opt.diffopt:append "iwhite"

-- files
opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv "HOME" .. "/.vim/undodir" -- core enables undofile

-- nav
opt.autochdir = true

-- treesitter-based folds
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevelstart = 99 -- open all folds on file open

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
