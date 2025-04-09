vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function ()
    require("lsp.servers.jdtls")
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function ()
    require("lsp.servers.luals")
  end
})
