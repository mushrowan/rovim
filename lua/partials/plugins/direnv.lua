return {
	{
		"direnv.nvim",
		event = "DeferredUIEnter",
		for_cat = "general",
		after = function()
			require("direnv-nvim").setup({
				async = true,
				on_direnv_finished = function()
					vim.cmd("LspStart")
					if vim.bo.filetype == "rust" then
						require("rustaceanvim.lsp").start()
						require("rustaceanvim.lsp").reload_settings()
					end
				end,
			})
		end,
	},
}
