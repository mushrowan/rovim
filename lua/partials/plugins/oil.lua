return {
	{
		"oil.nvim",
		for_cat = "general",
		cmd = "Oil",
		keys = {
			{ "-", desc = "Oil (parent directory)" },
			{ "<leader>se", desc = "Oil File Explorer" },
		},
		after = function()
			require("oil").setup({
				default_file_explorer = true,
				delete_to_trash = true,
				skip_confirm_for_simple_edits = true,
				view_options = {
					show_hidden = true,
					natural_order = true,
				},
				float = {
					padding = 2,
					max_width = 120,
					max_height = 40,
					border = "rounded",
				},
				keymaps = {
					["<C-[>"] = "actions.close",
					["q"] = "actions.close",
					["<C-h>"] = false,
					["<C-l>"] = false,
				},
			})

			vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open parent directory" })
			vim.keymap.set("n", "<leader>se", function()
				require("oil").toggle_float()
			end, { desc = "Oil File Explorer (float)" })
		end,
	},
}
