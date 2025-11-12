return {
	{
		"obsidian.nvim",
		for_cat = "general",
    event = "DeferredUIEnter",
		after = function()
			require("obsidian").setup({
        conceallevel = 1;
				ui = {
					render = false,
				},
				legacy_commands = false,
				workspaces = {
					{
						name = "colony",
						path = "~/Documents/colony",
					},
				},
				templates = {
					folder = "templates",
					date_format = "%Y-%m-%d-%a",
					time_format = "%H:%M",
				},
				daily_notes = {
					folder = "dailies",
					template = "daily_template.md",
				},
			})
			require("partials.utils").map_all("n", {
				{
					"<leader>oo",
					function()
						MiniSessions.read("colony")
					end,
					"Open obsidian session",
				},
				{
					"<leader>of",
					"<cmd>Obsidian quick_switch<CR>",
					"Open obsidian file",
				},
				{
					"<leader>od",
					"<cmd>Obsidian today<CR>",
					"Open today's note",
				},
			})
		end,
	},
}
