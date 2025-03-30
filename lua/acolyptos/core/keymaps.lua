local keymap = vim.keymap
local global = vim.g

local opts_silent = { noremap = true, silent = true }
local opts = { noremap = true }

global.mapleader = " "

keymap.set("n", "k", "k", opts_silent) -- Disable treesitter-textobjects overriding this button
keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { silent = true, desc = "Clear highlight search" })

-- Quick save and exit
keymap.set("n", "<leader>w", ":w<CR>", opts_silent)
keymap.set("n", "<leader>q", ":q<CR>", opts_silent)


-----------------------------------------------------------------
---                      PANES KEYMAPS                        ---
-----------------------------------------------------------------

-- Pane Navigation
keymap.set("n", "<C-h>", "<C-w>h", opts) -- Navigate to left pane
keymap.set("n", "<C-l>", "<C-w>l", opts) -- Navigate to right pane
keymap.set("n", "<C-j>", "<C-w>j", opts) -- Navigate to bottom pane
keymap.set("n", "<C-k>", "<C-w>k", opts) -- Navigate to upper pane

-- Split Panes
keymap.set("n", "<leader>|", "<cmd>vsplit<CR>", opts) -- Vertical Split
keymap.set("n", "<leader>_", "<cmd>split<CR>", opts) -- Horizontal Split

-- Resize Panes
keymap.set("n", "<C-left>", "<cmd>vertical resize -4<CR>", opts) -- Decreasing the width of the pane
keymap.set("n", "<C-right>", "<cmd>vertical resize +4<CR>", opts) -- Increasing the width of the pane
keymap.set("n", "<C-up>", "<cmd>resize +4<CR>", opts) -- Increasing the height of the pane
keymap.set("n", "<C-down>", "<cmd>resize -4<CR>", opts) -- Decreasing the height of the pane

-----------------------------------------------------------------
---                     FILE EXPLORATION                      ---
-----------------------------------------------------------------

keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", opts)

-----------------------------------------------------------------
---                         BUFFER                            ---
-----------------------------------------------------------------

keymap.set("n", "<S-h>", ":bprevious<CR>", opts) -- Go to previous buffer 
keymap.set("n", "<S-l>", ":bnext<CR>", opts) -- Go to next buffer 
keymap.set("n", "<leader>bd", ":bp|bd #<CR>", opts) -- Delete a buffer 

-----------------------------------------------------------------
---                         TABS                              ---
-----------------------------------------------------------------

keymap.set("n", "<leader>tn", ":tabnew<CR>", opts) -- Create a new tab
keymap.set("n", "<leader>tc", ":tabclose<CR>", opts) -- Close a tab
keymap.set("n", "<A-,>", ":tabprevious<CR>", opts) -- Go to previous tab
keymap.set("n", "<A-.>", ":tabnext<CR>", opts) -- Go to next tab

-----------------------------------------------------------------
---                      TELESCOPE                            ---
-----------------------------------------------------------------

keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find Files" })
keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Live Grep" })
keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "Find Buffers" })
keymap.set("n", "<leader>fh", ":Telescope help_tags<CR>", { desc = "Help Tags" })
