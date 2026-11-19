require "nvchad.options"

-- add yours here!

-- treesitter-based folds
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevelstart = 99 -- open all folds on file open

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
