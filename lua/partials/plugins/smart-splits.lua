-- SECTION: smart-splits
return {
	{
		"smart-splits.nvim",
		for_cat = "editor",
		event = "DeferredUIEnter",
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
