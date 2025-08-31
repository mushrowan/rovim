-- SECTION: whichkey
return {
	{
		"which-key.nvim",
		for_cat = "general",
		after = function()
			local wk = require("which-key")
			wk.setup({
				["notify"] = true,
				["preset"] = "modern",
				["replace"] = { ["<cr>"] = "RETURN", ["<leader>"] = "SPACE", ["<space>"] = "SPACE", ["<tab>"] = "TAB" },
				["win"] = { ["border"] = "rounded" },
			})
			wk.add({
				{ "<leader>b", desc = "+Buffer" },
				{ "<leader>bm", desc = "BufferLineMove" },
				{ "<leader>bs", desc = "BufferLineSort" },
				{ "<leader>bsi", desc = "BufferLineSortById" },
				{ "<leader>lw", desc = "+Workspace" },
				{ "<leader>x", desc = "+Trouble" },
			})
		end,
	},
}
