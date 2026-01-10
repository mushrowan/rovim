return {
	{
		"persistence.nvim",
		for_cat = "general",
		event = "BufReadPre",
		after = function()
			require("persistence").setup({
				dir = vim.fn.stdpath("state") .. "/sessions/",
				need = 1,
				branch = true,
			})
			vim.keymap.set("n", "<leader>sP", function()
				require("persistence").select()
			end, { desc = "Session Search" })
			vim.keymap.set("n", "<leader>as", function()
				require("persistence").save()
			end, { desc = "Session Save" })
			vim.keymap.set("n", "<leader>al", function()
				require("persistence").load()
			end, { desc = "Session Load" })
			vim.keymap.set("n", "<leader>aL", function()
				require("persistence").load({ last = true })
			end, { desc = "Session Load Last" })
		end,
	},
}
