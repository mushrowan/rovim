return {
	{
		"auto-session",
		for_cat = "general",
		after = function()
			require("auto-session").setup({
				suppressed_dirs = { "~" },
				bypass_save_filetypes = { "alpha", "dashboard", "snacks_dashboard" }, -- or whatever dashboard you use
				session_lens = {
					picker_opts = {
						preview = { minimal = true },
						preset = "default",
					},
				},
			})
			vim.keymap.set("n", "<leader>sp", "<cmd>AutoSession search<CR>", { desc = "Session Search" })
		end,
	},
}
