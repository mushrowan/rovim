-- SECTION: direnv
-- Automatic direnv environment loading with LSP restart
return {
	{
		"direnv-nvim",
		event = "BufReadPre",
		cmd = { "Direnv" },
		keys = {
			{ "<leader>da", "<cmd>Direnv allow<CR>", desc = "Direnv allow" },
			{ "<leader>dd", "<cmd>Direnv deny<CR>", desc = "Direnv deny" },
			{ "<leader>dr", "<cmd>Direnv reload<CR>", desc = "Direnv reload" },
			{ "<leader>de", "<cmd>Direnv edit<CR>", desc = "Direnv edit" },
			{ "<leader>ds", "<cmd>Direnv status<CR>", desc = "Direnv status" },
		},
		for_cat = "editor",
		after = function()
			require("direnv").setup({
				autoload_direnv = true,
				keybindings = {
					allow = "<leader>da",
					deny = "<leader>dd",
					reload = "<leader>dr",
				},
			})

			-- Restart LSP after direnv loads (only if clients are running)
			vim.api.nvim_create_autocmd("User", {
				pattern = "DirenvLoaded",
				callback = function()
					if #vim.lsp.get_clients() > 0 then
						vim.cmd("LspRestart")
					end
				end,
			})
		end,
	},
}
