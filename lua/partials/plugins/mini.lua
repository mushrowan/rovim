return {
	{
		"mini.icons",
		for_cat = "general",
		after = function()
			require("mini.icons").setup()
		end,
	},
	{
		"mini.sessions",
		for_cat = "general",
		dep_of = "snacks.nvim",
		after = function()
			local MiniSessions = require("mini.sessions")
			MiniSessions.setup({
				config = { autowrite = true },
			})
			vim.keymap.set("n", "<leader>sP", function()
				return MiniSessions.select()
			end, { desc = "Session Search" })
			vim.keymap.set("n", "<leader>as", function()
				MiniSessions.write()
			end, { desc = "Autosession Save" })
		end,
	},
	{
		"mini.surround",
		for_cat = "general",
		after = function()
			require("mini.surround").setup()
		end,
	},
	{
		"mini.bufremove",
		for_cat = "general",
		after = function()
			require("mini.bufremove").setup()
		end,
	},
}
