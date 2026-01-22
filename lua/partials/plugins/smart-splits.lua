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
			require("smart-splits").setup({
				-- tmux integration: navigate seamlessly between vim and tmux panes
				multiplexer_integration = "tmux",
				-- When at edge of neovim, wrap around (or use "stop" to stay put)
				at_edge = "wrap",
				-- Don't navigate to tmux panes when current tmux pane is zoomed
				disable_multiplexer_nav_when_zoomed = true,
				-- Resize mode settings
				resize_mode = {
					quit_key = "<ESC>",
					resize_keys = { "h", "j", "k", "l" },
					silent = true,
				},
			})
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
