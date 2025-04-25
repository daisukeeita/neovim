local gitsigns = require("gitsigns")

gitsigns.setup({
  signs = {
    add          = { text = "┃" },
    change       = { text = "┃" },
    delete       = { text = "󰍵" },
    topdelete    = { text = "󰍵" },
    changedelete = { text = "┃" },
    untracked    = { text = "┆" },
  },
  sign_priority = 6,
  numhl = true, -- Highlights line numbers
  current_line_blame = true, -- Show git blame per line
  current_line_blame_opts = {
    delay = 500,
    virt_text_pos = "eol",
  },
  preview_config = {
    border = "rounded",
  },
})
