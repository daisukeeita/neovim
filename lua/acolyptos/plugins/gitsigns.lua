return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" }, -- Load when opening a file
    config = function()
      require("gitsigns").setup({
        signs = {
          add          = { text = "┃" }, -- Nord green
          change       = { text = "┃" }, -- Nord blue
          delete       = { text = "󰍵" }, -- Nord red
          topdelete    = { text = "󰍵" }, -- Nord red
          changedelete = { text = "┃" }, -- Nord yellow
          untracked    = { text = "┆" }, -- Nord gray
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
    end
  }
}
