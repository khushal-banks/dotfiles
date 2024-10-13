vim.g.mapleader = " "

local bind = vim.keymap.set -- for conciseness

bind("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

bind("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
bind("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
bind("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
bind("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
bind("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
bind("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
bind("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

bind("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
bind("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
bind("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
bind("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
bind("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab
