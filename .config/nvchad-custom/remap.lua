local keymap = vim.keymap

-- move selected lines simultaneously
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- keep cursor stationary when using
--   J to merge lines
keymap.set("n", "J", "mzJ`z")
--   C-d/C-u to jump pages
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
--   n to jump to next search result
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

-- paste without losing previous yank
-- disabled cause of conflict with nvchad
-- keymap.set("x", "<leader>p", [["_dP]])

-- yank to system clipboard
keymap.set({"n", "v"}, "<leader>y", [["+y]])
keymap.set("n", "<leader>Y", [["+Y]])

-- delete to void clipboard
keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- trigger replace for word under cursor
keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- just for fun
keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");
