-- SECTION: flash
-- Label-based navigation and treesitter selection
return {
	{
		"flash.nvim",
		for_cat = "editor",
		keys = {
			{ "s", desc = "Flash" },
			{ "S", desc = "Flash Treesitter" },
			{ "r", mode = "o", desc = "Remote Flash" },
			{ "R", mode = { "o", "x" }, desc = "Treesitter Search" },
		},
		after = function()
			require("flash").setup({
				labels = "asdfghjklqwertyuiopzxcvbnm",
				search = {
					multi_window = true,
					forward = true,
					wrap = true,
				},
				jump = {
					jumplist = true,
					pos = "start",
					autojump = false,
				},
				label = {
					uppercase = true,
					reuse = "lowercase",
					style = "overlay",
				},
				modes = {
					search = { enabled = false },
					char = {
						enabled = true,
						jump_labels = true,
					},
					treesitter = {
						labels = "abcdefghijklmnopqrstuvwxyz",
						jump = { pos = "range" },
					},
				},
			})

			vim.keymap.set({ "n", "x", "o" }, "s", function()
				require("flash").jump()
			end, { desc = "Flash" })

			vim.keymap.set({ "n", "x", "o" }, "S", function()
				require("flash").treesitter()
			end, { desc = "Flash Treesitter" })

			vim.keymap.set("o", "r", function()
				require("flash").remote()
			end, { desc = "Remote Flash" })

			vim.keymap.set({ "o", "x" }, "R", function()
				require("flash").treesitter_search()
			end, { desc = "Treesitter Search" })
		end,
	},
}
