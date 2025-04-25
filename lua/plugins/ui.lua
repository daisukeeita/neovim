-- BufferLine
local latte = require("catppuccin.palettes").get_palette "latte"
require("bufferline").setup({
  highlights = require("catppuccin.groups.integrations.bufferline").get{
    styles = { "italic", "bold" },
  }
})

-- Nvim Tree
require("nvim-tree").setup({})

-- Indent Scope
require('mini.indentscope').setup({})

-- Notify
local notify = require("notify")
notify.setup({
  stages = "fade_in_slide_out",
  timeout = 3000,  -- Notifications last for 3 seconds
  render = "minimal",  -- Change to "default" if you want icons
  background_colour = "#1E1E2E",  -- Set a background color
})
vim.notify = notify

-- Status Line
local lualine = require('lualine')
local function lsp_attached()
  local clients = vim.lsp.get_clients()
  local buf_ft = vim.bo.filetype
  local lsp_names = {}

  for _, client in pairs(clients) do
    if client.attached_buffers[vim.api.nvim_get_current_buf()] then
      table.insert(lsp_names, client.name)
    end
  end

  return #lsp_names > 0 and "  " .. table.concat(lsp_names, ", ") or "No LSP"
  end

lualine.setup({
  options = {
    theme = "catppuccin",
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { { 'mode', icon = '' } },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { lsp_attached },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { { 'location', icon = '' } },
  },
  inactive_sections = {
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
  },
})

-- Dashboard
local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = require("core.dashboard_logo")

dashboard.section.buttons.val = {
  dashboard.button("f", "󰈞  Find File", ":Telescope find_files<CR>"),
  dashboard.button("n", "  New File", ":ene <BAR> startinsert <CR>"),
  dashboard.button("r", "󰁯  Recent Files", ":Telescope oldfiles<CR>"),
  dashboard.button("p", "  Projects", ":Telescope projects<CR>"),
  dashboard.button("q", "󰅚  Quit Neovim", ":qa<CR>")
}

dashboard.section.footer.val = {
  "Coding is poetry. ✨",
  "Welcome back, Acolyptos."
}

-- vim.cmd([[highlight AlphaHeader guifg=#88C0D0]])
-- vim.cmd([[highlight AlphaButtons guifg=#8FBCBB]])
-- vim.cmd([[highlight AlphaFooter guifg=#81A1C1]])
--
-- dashboard.section.header.opts.hl = "AlphaHeader"
-- dashboard.section.buttons.opts.hl = "AlphaButtons"
-- dashboard.section.footer.opts.hl = "AlphaFooter"

alpha.setup(dashboard.opts)
