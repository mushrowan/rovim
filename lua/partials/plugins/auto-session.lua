return {
	{
		"auto-session",
		for_cat = "general",
    lazy = false,
		after = function()
      -- TODO: add delete bind
      -- TODO: add preview directory
			require("auto-session").setup({
				suppressed_dirs = { "~" },
        cwd_change_handling = true,

				bypass_save_filetypes = { "alpha", "dashboard", "snacks_dashboard" }, -- or whatever dashboard you use
				session_lens = {
					picker_opts = {
						preview = { minimal = true },
						preset = "default",
					},
				},
        -- lsp_stop_on_restore = true,
			})
			vim.keymap.set("n", "<leader>sp", "<cmd>AutoSession search<CR>", { desc = "Session Search" })
		end,
	},
}
