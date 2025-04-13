require("mason").setup({})
require("mason-lspconfig").setup({})

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

vim.lsp.handlers["window/showMessage"] = function (_, result, ctx)
  local client = vim.lsp.get_client_by_id(ctx.client_id)
  local level = ({
    "ERROR",
    "WARN",
    "INFO",
    "DEBUG"
  })[result.type]

  vim.notify(result.message, level, {
    title = "LSP | " .. client.name,
  })
end

vim.lsp.set_log_level("off") -- For debugging, switch it to "debug"
