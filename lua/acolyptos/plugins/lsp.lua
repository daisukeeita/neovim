return {
  { "williamboman/mason.nvim", config = true },
  { 
    "neovim/nvim-lspconfig",
    config = function ()
      local lspconfig = require('lspconfig')
      local cmp_nvim_lsp = require('cmp_nvim_lsp')

      local capabilities = cmp_nvim_lsp.default_capabilities()

      lspconfig.jdtls.setup({
        cmd = { 'jdtls' },
        root_dir = lspconfig.util.root_pattern(".git", "mvnw", "gradlew", "pom.xml", "build.gradle"),
        capabilities = capabilities, -- Enable full LSP support

        handlers = {
          ["window/showMessages"] = function(_, result, ctx)
            local client = vim.lsp.get_client_by_id(ctx.client_id)
            local lvl = ({ "ERROR", "WARN", "INFO", "DEBUG" })[result.type]
            vim.notify(result.message, lvl, { title = client.name })
          end
        },

        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")
          end
        end,

        settings = {
          java = {
            format = {
              enabled = true,
              settings = {
                url = "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml",
                profile = "GoogleStyle",
              }
            },
            errors = {
              incompleteClasspath = {
                severity = "warning",
              }
            },
            configuration = {
              checkstyle = {
                enabled = true
              }
            },
            trace = {
              server = "verbose"
            },
            signatureHelp = {
              enabled = true,
            },
            completion = {
              favoriteStaticMembers = {
                "org.junit.Assert.*",
                "org.junit.Assume.*",
                "org.junit.jupiter.api.Assertions.*",
                "org.junit.jupiter.api.Assumptions.*",
                "org.junit.jupiter.api.DynamicContainer.*",
                "org.junit.jupiter.api.DynamicTest.*"
              },
              filteredTypes = {
                "com.sun.*",
                "io.micrometer.shaded.*",
                "java.awt.*",
                "jdk.*", "sun.*",
              }
            },
            sources = {
              organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999
              }
            },
          }
        }
      })

      vim.diagnostic.config({
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        virtual_text = false,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.INFO] = " ",
            [vim.diagnostic.severity.HINT] = " ",
          },
        },
        float = {
          scope = "cursor",
          border = "rounded",
          focusable = true,
          style = "minimal",
          source = "if_many",
          prefix = " ",
        },
      })

    end
  },

  { "williamboman/mason-lspconfig.nvim", 
    dependencies = { 
      "mason.nvim", 
      "nvim-lspconfig" 
    }, 
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "jdtls" },
        handlers = {
          function (server_name)
            require('lspconfig')[server_name].setup({})
          end
        }
      })
    end
  },

  { 
    'echasnovski/mini.pairs',
    config = function()
      require('mini.pairs').setup()
    end
  },
}
