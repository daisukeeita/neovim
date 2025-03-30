return {
  { "nvim-telescope/telescope-fzf-native.nvim"  },
  { "nvim-lua/plenary.nvim" },
  { 
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "nvim-tree/nvim-web-devicons" },
      { "nvim-treesitter/nvim-treesitter" },
    },
    cmd = "Telescope",

    config = function()
      local telescope = require('telescope')
      local actions = require('telescope.actions')

      telescope.setup({
        defaults = {
          prompt_prefix = "  ",
          selection_caret = "  ",
          sorting_strategy = "ascending",
          border = true,
          winblend = 0,
          layout_strategy = "horizontal",
          layout_config = {
            prompt_position = "bottom",
            mirror = false,
            width = 0.9,
            height = 0.8,
            preview_width = 0.55
          }
        },

        pickers = {
          -- find_files = { theme = "dropdown" },
          -- live_grep = { theme = "ivy" }
        },

        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          }
        }
      })

      require('telescope').load_extension('fzf')
    end
  }
}
