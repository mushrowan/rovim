return {
	{
		"lsp_lines.nvim",
		for_cat = "lsp",
		event = "DeferredUIEnter",
		after = function()
			vim.diagnostic.config({ virtual_lines = true, virtual_text = false })
			require("lsp_lines").setup()
		end,
	},
}
