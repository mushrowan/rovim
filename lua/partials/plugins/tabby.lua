-- SECTION: tabby
return {
	{
		"tabby.nvim",
		for_cat = "ui",
		event = "DeferredUIEnter",
		after = function()
			local theme = {
				fill = "TabLineFill",
				head = "TabLine",
				current_tab = "TabLineSel",
				tab = "TabLine",
				win = "TabLine",
				tail = "TabLine",
			}
			require("tabby").setup({
				line = function(line)
					return {
						{
							{ "  ", hl = theme.head },
							line.sep("", theme.head, theme.fill),
						},
						line.tabs().foreach(function(tab)
							local hl = tab.is_current() and theme.current_tab or theme.tab
							return {
								line.sep("", hl, theme.fill),
								tab.is_current() and "" or "󰆣",
								tab.in_jump_mode() and tab.jump_key() or tab.number(),
								tab.name(),
								tab.close_btn(""),
								line.sep("", hl, theme.fill),
								hl = hl,
								margin = " ",
							}
						end),
						line.spacer(),
						line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
							return {
								line.sep("", theme.win, theme.fill),
								win.is_current() and "" or "",
								win.buf_name(),
								line.sep("", theme.win, theme.fill),
								hl = theme.win,
								margin = " ",
							}
						end),
						{
							line.sep("", theme.tail, theme.fill),
							{ "  ", hl = theme.tail },
						},
						hl = theme.fill,
					}
				end,
			})

			-- Always show tabline
			vim.o.showtabline = 2

			local utils = require("partials.utils")
			utils.map_all("n", {
				{ "<leader>j", ":Tabby jump_to_tab<CR>", "Jump to tab" },
				{ "<leader>ta", ":$tabnew<CR>", "New tab" },
				{ "<leader>tc", ":tabclose<CR>", "Close tab" },
				{ "<leader>to", ":tabonly<CR>", "Tab only" },
				{ "<leader>tn", ":tabn<CR>", "Next tab" },
				{ "<leader>tp", ":tabp<CR>", "Previous tab" },
				{ "<leader>tmp", ":-tabmove<CR>", "Move tab left" },
				{ "<leader>tmn", ":+tabmove<CR>", "Move tab right" },
			})
		end,
	},
}
