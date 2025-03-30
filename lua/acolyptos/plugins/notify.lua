return {
  {
    "rcarriga/nvim-notify",
    lazy = false,
    config = function()
      local notify = require("notify")
      notify.setup({
        stages = "fade_in_slide_out",
        timeout = 3000,  -- Notifications last for 3 seconds
        render = "minimal",  -- Change to "default" if you want icons
        background_colour = "#1E1E2E",  -- Set a background color
      })
      vim.notify = notify
    end,
    -- enabled = false,
  }
}
