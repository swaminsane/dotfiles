vim.g.mapleader = " "  -- space as leader key

local map = vim.keymap.set

-- general
map("n", "<leader>w", ":w<CR>",        { desc = "Save" })
map("n", "<leader>q", ":q<CR>",        { desc = "Quit" })
map("n", "<leader>wq", ":wq<CR>",      { desc = "Save and quit" })

-- nvim-tree
map("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file tree" })

-- telescope
map("n", "<leader>ff", ":Telescope find_files<CR>",  { desc = "Find files" })
map("n", "<leader>fg", ":Telescope live_grep<CR>",   { desc = "Search in files" })
map("n", "<leader>fb", ":Telescope buffers<CR>",     { desc = "Find buffers" })

-- move between splits
map("n", "<C-h>", "<C-w>h", { desc = "Move left" })
map("n", "<C-l>", "<C-w>l", { desc = "Move right" })
map("n", "<C-j>", "<C-w>j", { desc = "Move down" })
map("n", "<C-k>", "<C-w>k", { desc = "Move up" })

-- move lines up and down in visual mode
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- quick notes
map("n", "<leader>n", ":e ~/sync/docs/notes/quicknotes.md<CR>", { desc = "Open notes" })

-- Compile and run C
map("n", "<leader>cc", ":w<CR>:!gcc % -o %:r && ./%:r<CR>", { desc = "Compile and run C" })
