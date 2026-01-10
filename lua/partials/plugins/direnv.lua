-- SECTION: direnv
-- Automatic direnv environment loading with LSP restart
return {
	{
		"direnv.nvim",
		event = "DeferredUIEnter",
		for_cat = "editor",
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
