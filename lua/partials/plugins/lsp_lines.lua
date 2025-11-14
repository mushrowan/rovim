return {
	{
		"lsp_lines.nvim",
		for_cat = "general",
		event = "DeferredUIEnter",
		after = function()
			vim.diagnostic.config({ virtual_lines = true, virtual_text = false })
			require("lsp_lines").setup()
		end,
	},
}
