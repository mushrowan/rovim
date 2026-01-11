-- SECTION: treesitter
-- Note: Modern nvim-treesitter no longer uses configs.setup()
-- Highlighting is enabled automatically when parsers are available
-- Indent is configured via vim options
return {
	{
		"nvim-treesitter",
		for_cat = "editor",
		event = { "BufReadPre", "BufNewFile" },
		after = function()
			-- Enable treesitter-based indentation
			vim.opt.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

			-- Enable additional regex highlighting for markdown
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "markdown",
				callback = function()
					vim.opt_local.syntax = "on"
				end,
			})
		end,
	},
}
