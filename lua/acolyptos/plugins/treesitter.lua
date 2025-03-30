return {
  { "nvim-treesitter/nvim-treesitter-textobjects", 
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    enabled = false,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "java" },  -- Install Java parser
        highlight = { enable = true }, -- Enable syntax highlighting
        indent = { enable = true },    -- Enable smart indentation
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<C-Space>",
                node_incremental = "<C-Space>",
                scope_incremental = false,
                node_decremental = "<BS>",
            },
        },
        textobjects = {
          lsp_interop = {
            enable = true,          -- Enable LSP interop for Treesitter
            border = "rounded",     -- Customize floating window border
            floating_preview_opts = {}, -- Additional floating window options
            peek_definition_code = {
              keymaps = {
                ["<leader>df"] = "@function.outer", -- Peek function definitions
                ["<leader>dF"] = "@class.outer",    -- Peek class definitions
              }  
            },
          },
        },
      })
    end,
  }
}
