local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath
  })
  
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." }
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Load lazy.nvim setup and plugin
require("lazy_setup")

-- Load core configurations
require("core.autocmds")
require("core.keymaps")
require("core.options")

-- Load LSP configurations
require("lsp.init")

-- Load plugin configurations
require("plugins.colorscheme")
require("plugins.lsp_related")
require("plugins.treesitter")
require("plugins.cmp")
require("plugins.tester")
require("plugins.debugger")
require("plugins.gitsigns")
require("plugins.coding")
require("plugins.ui")
require("plugins.telescope")
