return {
	{
		"snacks.nvim",
		for_cat = "general",
		after = function()
			require("snacks").setup({
				bigfile = { enabled = true },
				explorer = { enabled = true },
				indent = { enabled = true },
				input = { enabled = true },
				notifier = { enabled = true, timeout = 3000 },
				picker = {
					enabled = true,
					hidden = true,
					sources = {
						files = { hidden = true },
						grep = { hidden = true },
					},
				},
				scope = { enabled = true },
				terminal = { enabled = true },
				lazygit = { enabled = true },
			})
			local terminal_keys = {
				{
					"<C-[>",
					function(win)
						win:toggle()
					end,
					mode = "n",
				},
				-- Terminal raw mode binding here?
			}
			vim.keymap.set("n", "<C-y>", function()
				return Snacks.picker.resume()
			end)
			vim.keymap.set("n", "<leader>sb", function()
				return Snacks.picker.buffers()
			end, { desc = "Buffers" })
			vim.keymap.set("n", "<leader>sg", function()
				return Snacks.picker.grep({ live = true })
			end, { desc = "Live grep" })
			vim.keymap.set("n", "<leader>rf", function()
				return Snacks.picker.recent()
			end, { desc = "Recent files" })
			vim.keymap.set("n", "<leader>ss", function()
				return Snacks.picker.smart()
			end, { desc = "Smart picker" })
			vim.keymap.set("n", "<leader>gs", function()
				return Snacks.picker.git_status()
			end, { desc = "Git status" })
			vim.keymap.set("n", "<leader>sp", function()
				return Snacks.picker.projects()
			end, { desc = "Projects" })
			vim.keymap.set("n", "<leader>lG", function()
				return Snacks.lazygit({
					win = { keys = terminal_keys },
				})
			end, { desc = "LazyGit" })
			vim.keymap.set("n", "<leader>sf", function()
				return Snacks.picker.files()
			end)
			vim.keymap.set("n", "<leader>sz", function()
				return Snacks.picker.zoxide()
			end, { desc = "Zoxide" })
			vim.keymap.set("n", "<leader>se", function()
				return Snacks.explorer.open()
			end, { desc = "Explorer" })
			vim.keymap.set("n", "<leader>tt", function()
				Snacks.terminal.toggle(
					-- Prevents opening zellij
					"fish",
					{
						win = {
							keys = terminal_keys,
						},
					}
				)
			end, {
				desc = "Toggle Terminal",
			})
		end,
	},
}
