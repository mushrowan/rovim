return {
	{
		"tabby.nvim",
		for_cat = "general",
		after = function()
			local theme = {
				fill = "TabLineFill",
				-- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
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
							{ "  ", hl = theme.head },
							line.sep("", theme.head, theme.fill),
						},
						line.tabs().foreach(function(tab)
							local hl = tab.is_current() and theme.current_tab or theme.tab
							return {
								line.sep("", hl, theme.fill),
								tab.is_current() and "" or "󰆣",
								tab.in_jump_mode() and tab.jump_key() or tab.number(),
								tab.name(),
								tab.close_btn(""),
								line.sep("", hl, theme.fill),
								hl = hl,
								margin = " ",
							}
						end),
						line.spacer(),
						line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
							return {
								line.sep("", theme.win, theme.fill),
								win.is_current() and "" or "",
								win.buf_name(),
								line.sep("", theme.win, theme.fill),
								hl = theme.win,
								margin = " ",
							}
						end),
						{
							line.sep("", theme.tail, theme.fill),
							{ "  ", hl = theme.tail },
						},
						hl = theme.fill,
					}
				end,
				-- option = {}, -- setup modules' option,
			})

			-- show tabby even with only one tab :)
			vim.o.showtabline = 2

			local function map(mode, key, action, desc)
				vim.keymap.set(mode, key, action, { noremap = true, silent = true, desc = desc })
			end

			map("n", "<leader>j", ":Tabby jump_to_tab<CR>", "Jump to tab")
			map("n", "<leader>ta", ":$tabnew<CR>", "New tab")
			map("n", "<leader>tc", ":tabclose<CR>", "Close tab")
			map("n", "<leader>to", ":tabonly<CR>", "Tab only?")
			map("n", "<leader>tn", ":tabn<CR>", "Next tab")
			map("n", "<leader>tp", ":tabp<CR>", "Previous tab")
			map("n", "<leader>tmp", ":-tabmove<CR>", "Move current tab to the left")
			map("n", "<leader>tmn", ":+tabmove<CR>", "Move current tab to the right")
		end,
	},
}
