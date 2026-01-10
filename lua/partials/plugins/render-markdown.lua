-- SECTION: render-markdown
-- In-buffer markdown rendering with concealment
return {
	{
		"render-markdown.nvim",
		event = "DeferredUIEnter",
		for_cat = "notes",
		after = function()
			-- Uses defaults: renders headings, checkboxes, tables, code blocks
			require("render-markdown").setup({})
		end,
	},
}
