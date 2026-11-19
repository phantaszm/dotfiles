require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- move selected lines
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "move selection up" })

-- keep the cursor stationary
map("n", "J", "mzJ`z", { desc = "join lines, keep cursor" })
map("n", "<C-d>", "<C-d>zz", { desc = "half page down, centered" })
map("n", "<C-u>", "<C-u>zz", { desc = "half page up, centered" })
map("n", "n", "nzzzv", { desc = "next match, centered" })
map("n", "N", "Nzzzv", { desc = "previous match, centered" })

-- yank to system clipboard (redundant while core sets clipboard=unnamedplus)
map({ "n", "v" }, "<leader>y", [["+y]], { desc = "yank to system clipboard" })
map("n", "<leader>Y", [["+Y]], { desc = "yank line to system clipboard" })

-- delete to the void register
map({ "n", "v" }, "<leader>d", [["_d]], { desc = "delete to void register" })

-- replace the word under the cursor
map(
  "n",
  "<leader>s",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "replace word under cursor" }
)
