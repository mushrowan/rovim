return {
	{
		"blink.cmp",
		for_cat = "general.completion",
		after = function(_)
			require("blink.cmp").setup({
				keymap = {
					["<C-k>"] = { "select_prev", "fallback" },
					["<C-j>"] = { "select_next", "fallback" },
				},
			})
		end,
	},
}
