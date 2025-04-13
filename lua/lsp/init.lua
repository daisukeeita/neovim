require("lsp.servers.jdtls")

vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function ()
    require("lsp.servers.luals")
  end
})
