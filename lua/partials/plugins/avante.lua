-- SECTION: avante
-- AI-powered code assistance (Claude integration)
return {
	{
		"avante.nvim",
		for_cat = "ai",
		event = "DeferredUIEnter",
		keys = {
			{ "<leader>aa", desc = "Avante ask" },
			{ "<leader>ae", desc = "Avante edit" },
			{ "<leader>ac", desc = "Avante chat" },
		},
		load = function(name)
			vim.cmd.packadd(name)
			vim.cmd.packadd("nui.nvim")
			vim.cmd.packadd("plenary.nvim")
		end,
		after = function()
			require("avante").setup({
				provider = "claude",
				providers = {
					claude = {
						endpoint = "https://api.anthropic.com",
						model = "claude-sonnet-4-20250514",
						extra_request_body = {
							temperature = 0,
							max_tokens = 4096,
						},
					},
				},
				mappings = {
					ask = "<leader>aa",
					edit = "<leader>ae",
					refresh = "<leader>ar",
					diff = {
						ours = "co",
						theirs = "ct",
						both = "cb",
						next = "]x",
						prev = "[x",
					},
					jump = {
						next = "]]",
						prev = "[[",
					},
					submit = {
						normal = "<CR>",
						insert = "<C-s>",
					},
					toggle = {
						debug = "<leader>aD",
						hint = "<leader>ah",
					},
				},
				hints = { enabled = true },
				windows = {
					position = "right",
					width = 40,
					sidebar_header = {
						align = "center",
						rounded = true,
					},
				},
			})

			vim.keymap.set("n", "<leader>ac", function()
				require("avante").toggle()
			end, { desc = "Avante toggle chat" })

			vim.keymap.set("v", "<leader>ae", function()
				require("avante").edit()
			end, { desc = "Avante edit selection" })
		end,
	},
}
