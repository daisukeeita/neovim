return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local lualine = require('lualine')

      local colors = {
        bg       = '#2E3440', -- Dark background
        fg       = '#D8DEE9', -- Light foreground
        yellow   = '#EBCB8B',
        cyan     = '#88C0D0',
        darkblue = '#5E81AC',
        green    = '#A3BE8C',
        orange   = '#D08770',
        violet   = '#B48EAD',
        magenta  = '#BF616A',
        blue     = '#81A1C1',
        red      = '#BF616A',
      }

      local nord_theme = {
        normal = {
          a = { fg = colors.bg, bg = colors.blue, gui = 'bold' },
          b = { fg = colors.fg, bg = colors.darkblue },
          c = { fg = colors.fg, bg = colors.bg },
        },
        insert = { a = { fg = colors.bg, bg = colors.green, gui = 'bold' } },
        visual = { a = { fg = colors.bg, bg = colors.violet, gui = 'bold' } },
        replace = { a = { fg = colors.bg, bg = colors.red, gui = 'bold' } },
        command = { a = { fg = colors.bg, bg = colors.yellow, gui = 'bold' } },
        inactive = {
          a = { fg = colors.fg, bg = colors.bg, gui = 'bold' },
          b = { fg = colors.fg, bg = colors.bg },
          c = { fg = colors.fg, bg = colors.bg },
        },
      }

      local function lsp_attached()
        local clients = vim.lsp.get_active_clients()
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
          theme = nord_theme,
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
    end
  }
}
