-- SECTION: smart-splits
return {
	{
		"smart-splits.nvim",
		for_cat = "editor",
		keys = {
			{ "<C-A-h>", desc = "Resize left" },
			{ "<C-A-j>", desc = "Resize down" },
			{ "<C-A-k>", desc = "Resize up" },
			{ "<C-A-l>", desc = "Resize right" },
			{ "<A-h>", desc = "Move cursor left" },
			{ "<A-j>", desc = "Move cursor down" },
			{ "<A-k>", desc = "Move cursor up" },
			{ "<A-l>", desc = "Move cursor right" },
			{ "<A-\\>", desc = "Move cursor previous" },
			{ "<A-Shift-h>", desc = "Swap buffer left" },
			{ "<A-Shift-j>", desc = "Swap buffer down" },
			{ "<A-Shift-k>", desc = "Swap buffer up" },
			{ "<A-Shift-l>", desc = "Swap buffer right" },
		},
		after = function()
			require("smart-splits").setup({})
			require("partials.utils").map_all("n", {
				{ "<C-A-h>", require("smart-splits").resize_left },
				{ "<C-A-j>", require("smart-splits").resize_down },
				{ "<C-A-k>", require("smart-splits").resize_up },
				{ "<C-A-l>", require("smart-splits").resize_right },
				{ "<A-h>", require("smart-splits").move_cursor_left },
				{ "<A-j>", require("smart-splits").move_cursor_down },
				{ "<A-k>", require("smart-splits").move_cursor_up },
				{ "<A-l>", require("smart-splits").move_cursor_right },
				{ "<A-\\>", require("smart-splits").move_cursor_previous },
				{ "<A-Shift-h>", require("smart-splits").swap_buf_left },
				{ "<A-Shift-j>", require("smart-splits").swap_buf_down },
				{ "<A-Shift-k>", require("smart-splits").swap_buf_up },
				{ "<A-Shift-l>", require("smart-splits").swap_buf_right },
			})
		end,
	},
}
