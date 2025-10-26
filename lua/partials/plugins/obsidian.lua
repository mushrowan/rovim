return {
	{
		"obsidian.nvim",
		for_cat = "general",
		lazy = true,
		ft = "markdown",
		after = function()
			vim.o.conceallevel = 2
			require("obsidian").setup({
				legacy_commands = false,
				workspaces = {
					{
						name = "colony",
						path = "~/Documents/colony",
					},
				},
			})
		end,
	},
}
