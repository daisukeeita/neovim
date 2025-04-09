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
---                        NEOTEST                            ---
-----------------------------------------------------------------
local neotest = require("neotest")

keymap.set("n", "<leader>tt", function ()
  neotest.run.run()
end, { desc = "Run nearest test" })

keymap.set("n", "<leader>td", function ()
  neotest.run.run({ strategy = "dap" })
end, { desc = "Debug nearest test with DAP" })

keymap.set("n", "<leader>tf", function ()
  neotest.run.file()
end, { desc = "Run file test"})

keymap.set("n", "<leader>to", function ()
  neotest.output.open({ enter = true })
end, { desc = "Show test output" })

keymap.set("n", "<leader>ts", function ()
  neotest.summary.toggle()
end, { desc = "Toggle test summary" })

keymap.set("n", "<leader>tD", function ()
  neotest.run.stop()
end, { desc = "Stop running tests" })

-----------------------------------------------------------------
---                         DAP                               ---
-----------------------------------------------------------------
local dap = require("dap")
local dapui = require("dapui")

keymap.set("n", "<leader>dui", function ()
  dapui.toggle()
end, { noremap = true, silent = true, desc = "DAPUI: Toggle DAP UI" })

keymap.set("n", "<F5>", function ()
  dap.continue()
end, { desc = "DAP: Continue/Start Debugger"})

keymap.set("n", "<F6>", function ()
  dap.step_over()
end, { desc = "DAP: Step Over" })

keymap.set("n", "<F7>", function ()
  dap.step_into()
end, { desc = "DAP: Step Into" })

keymap.set("n", "<F8>", function ()
  dap.step_out()
end, { desc = "DAP: Step Out" })

keymap.set("n", "<F9>", function ()
  dap.run_last()
end, { desc = "DAP: Run Last"})

keymap.set("n", "<F12>", function ()
  dap.terminate()
end, { desc = "DAP: Terminate"})

keymap.set("n", "<leader>dtb", function ()
  dap.toggle_breakpoint()
end, { noremap = true, silent = true, desc = "DAP: Toggle Breakpoint" })

keymap.set("n", "<leader>dtr", function ()
  dap.repl.toggle()
end, { noremap = true, silent = true, desc = "DAP: Toggle DAP REPL" })

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
