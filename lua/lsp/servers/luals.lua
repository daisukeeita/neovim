local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("lspconfig").lua_ls.setup({
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		if client.server_capabilities.inlayHintProvider then
			vim.lsp.inlay_hint.enable(true, { bufnr })
		end
	end,
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			workspace = { checkThirdParty = false },
			diagnostics = { globals = { "vim" } },
			completion = {
				callSnippet = "Both",
				keywordSnippet = "Both",
				workspaceWord = true,
			},
			hint = {
				enable = true,
				paramType = false,
				semicolon = false,
				setType = true,
				arrayIndex = false,
			},
		},
	},
})
