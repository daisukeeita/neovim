return {
  { "hrsh7th/nvim-cmp", dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- LSP completion
      "hrsh7th/cmp-buffer",   -- Buffer completion
      "hrsh7th/cmp-path",     -- Path completion
      "hrsh7th/cmp-cmdline",  -- Command-line completion
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body) -- Enable LuaSnip Support
            -- vim.snippet.expand(args.body) -- Enable Neovim snippets (Nvim <0.10)
          end
        },

        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered()
        },
        
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
        }),

        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = 'luasnip' },
          { name = "buffer" },
          { name = "path" },
        }),
      })

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        }),
        matching = { disallow_symbol_nonprefix_matching = false }
      })

      cmp.setup.cmdline({ '/', '?' }, {
       mapping = cmp.mapping.preset.cmdline(),
       sources = { { name = 'buffer' } }
      })
    end
  },
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" }
}
