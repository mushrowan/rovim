return {
	{
		"blink.cmp",
		for_cat = "general",
		after = function(_)
			require("blink.cmp").setup({
				sources = {
					default = { "lsp", "path", "snippets", "buffer"},
				},
				completion = {
					-- Display a preview of the selected item on the current line
          --  ghost_text = { enabled = true },
				},

				keymap = {
					["<C-k>"] = {
						function(cmp)
							cmp.scroll_documentation_up(4)
						end,
						"select_prev",
					},
					["<C-j>"] = {

						function(cmp)
							cmp.scroll_documentation_down(4)
						end,
						"select_next",
					},
					["<C-l>"] = {
						function(cmp)
							return cmp.select_next({ count = 5 })
						end,
					},
					["<C-h>"] = {
						function(cmp)
							return cmp.select_prev({ count = 5 })
						end,
					},
					["<C-i>"] = { "show_documentation", "hide_documentation" },
				},
			})
		end,
	},
	{
		"blink.compat",
		for_cat = "general",
		after = function()
			require("blink.compat").setup({})
		end,
	},
}
