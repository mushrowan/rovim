-- SECTION: lsp_lines
-- Multi-line diagnostic display instead of virtual text
return {
	{
		"lsp_lines.nvim",
		for_cat = "lsp",
		event = "LspAttach",
		after = function()
			vim.diagnostic.config({ virtual_lines = true, virtual_text = false })
			-- No options needed; diagnostic config above controls display
			require("lsp_lines").setup()
		end,
	},
}
