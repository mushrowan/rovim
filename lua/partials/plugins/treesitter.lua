-- SECTION: treesitter
return {
	{
		"nvim-treesitter",
		for_cat = "editor",
		event = "DeferredUIEnter",
		after = function()
			require("nvim-treesitter.configs").setup({
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = { "markdown" },
				},
				indent = { enable = true },
			})
		end,
	},
}
