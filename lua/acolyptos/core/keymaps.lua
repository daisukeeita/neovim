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

-----------------------------------------------------------------
---                       GITSIGNS                            ---
-----------------------------------------------------------------
keymap.set("n", "<leader>gs", ":Gitsigns stage_hunk<CR>")
keymap.set("n", "<leader>gu", ":Gitsigns undo_stage_hunk<CR>")
keymap.set("n", "<leader>gr", ":Gitsigns reset_hunk<CR>")
keymap.set("n", "<leader>gb", ":Gitsigns blame_line<CR>")
keymap.set("n", "<leader>gd", ":Gitsigns diffthis<CR>")
keymap.set("n", "]c", "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
keymap.set("n", "[c", "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })

-----------------------------------------------------------------
---                       TERMINAL                            ---
-----------------------------------------------------------------
local terminal_bufnr = nil  -- Store terminal buffer number
local terminal_winid = nil   -- Store terminal window ID

-- This will hide the terminal instead of destroying the terminal
function ToggleBottomTerminal()
  if terminal_winid and vim.api.nvim_win_is_valid(terminal_winid) then
    vim.api.nvim_win_hide(terminal_winid)  -- Hide the window instead of closing
    terminal_winid = nil
  else
    if terminal_bufnr and vim.api.nvim_buf_is_valid(terminal_bufnr) then
      -- Open the existing terminal buffer
      vim.cmd("botright split") 
      vim.cmd("resize 10")
      vim.api.nvim_set_current_buf(terminal_bufnr)
    else
      -- Create a new terminal if it doesn't exist
      vim.cmd("botright split | resize 10 | terminal")
      terminal_bufnr = vim.api.nvim_get_current_buf()
    end
    terminal_winid = vim.api.nvim_get_current_win()
  end
end

vim.keymap.set("n", "<leader>tb", ToggleBottomTerminal, { noremap = true, silent = true })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", opts_silent)
