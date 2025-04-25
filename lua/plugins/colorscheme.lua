local catpuccin = require("catppuccin")
catpuccin.setup({
  background = {
    light = "latte",
    dark = "mocha"
  },
  transparent_background = false,
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    treesitter = true,
    notify = true,
    mini = {
      enabled = true,
      indentscope_color = "",
    },
    alpha = true,
    dap = true,
    dap_ui = true,
    native_lsp = {
      enabled = true,
      underlines = {
        errors = { "underline" },
        hints = { "underline" },
        warnings = { "underline" },
        information = { "underline" },
        ok = { "underline" },
      }
    },
    nvim_surround = true,
    telescope = { enabled = true },

  },
})

vim.cmd("colorscheme catppuccin-latte")
