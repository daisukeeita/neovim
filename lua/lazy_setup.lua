local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local lazy = require("lazy")

lazy.setup({
  -- Core LSP related plugins
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim", config = true },
  { 
    "williamboman/mason-lspconfig.nvim",
    dependencies = { 
      "mason.nvim", 
      "nvim-lspconfig" 
    }
  },
  {
    "mfussenegger/nvim-jdtls",
    dependencies = {
      "mfussenegger/nvim-dap"
    }
  },

  -- Treesiter
  { 
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate"
  },
  { "fei6409/log-highlight.nvim" },

  -- Completion related plugins
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline"
    }
  },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-cmdline" },
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },

  -- Testing related plugins
  { "nvim-neotest/nvim-nio" },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter"
    }
  },
  {
    "rcasia/neotest-java",
    ft = "java",
    dependencies = {
      "mfussenegger/nvim-jdtls",
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    }
  },

  -- Debugger related plugins 
  { "mfussenegger/nvim-dap" },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio"
    }
  },

  -- Git related plugins
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" }
  },

  -- Coding related plugins
  { "echasnovski/mini.pairs", version = '*' },
  { 'echasnovski/mini.move', version = '*' },
  { 'echasnovski/mini.surround', version = '*' },
  { "ggandor/leap.nvim" },

  -- UI require plugins
  { "nvim-tree/nvim-web-devicons" },
  { "nvim-lua/plenary.nvim" },
  { 
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" }
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
  {
    "rcarriga/nvim-notify",
    lazy = false,
  },
  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    
  },

  -- Telescope related plugins
  { "nvim-telescope/telescope-fzf-native.nvim"  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "nvim-tree/nvim-web-devicons" },
      { "nvim-treesitter/nvim-treesitter" },
    },
    cmd = "Telescope"
  },

  -- Colorscheme
  { "shaunsingh/nord.nvim" },
  { "catppuccin/nvim", name = "catppuccin"},

  checker = { enabled = true },
  ui = {
    notify = vim.notify
  }
})
