require("log-highlight").setup({})

local treesitter_config = require("nvim-treesitter.configs")
treesitter_config.setup({
  ensure_installed = { "java" },  -- Install Java parser
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false
  }, -- Enable syntax highlighting
  indent = { enable = true },    -- Enable smart indentation
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-Space>",
      node_incremental = "<C-Space>",
      scope_incremental = false,
      node_decremental = "<BS>",
    },
  }
})
