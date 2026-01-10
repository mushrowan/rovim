-- SECTION: remote-nvim
-- Remote development via SSH
return {
	{
		"remote-nvim.nvim",
		for_cat = "remote",
		event = "DeferredUIEnter",
		after = function()
			-- Uses defaults: SSH connection management with remote neovim instances
			require("remote-nvim").setup({})
		end,
	},
}
