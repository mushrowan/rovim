-- SECTION: snacks
return {
	{
		"snacks.nvim",
		for_cat = "editor",
		after = function()
			require("snacks").setup({
				bigfile = { enabled = true },
				indent = { enabled = true },
				git = { enable = true },
				--input = { enabled = true },
				-- notifier = { enabled = true, timeout = 3000 },
				picker = {
					-- enabled = true,
					hidden = true,
					sources = {
						projects = {},

						files = { hidden = true },
						grep = { hidden = true },
					},
				},
				scope = { enabled = true },
				terminal = { enabled = true },
				lazygit = { enabled = true },
			})

			---@param working_dir string?
			local terminal_opts = function(working_dir)
				return {
					win = {
						fixbuf = true,
						resize = true,
						position = "float",
						backdrop = 70,
						keys = {
							{
								"<C-[>",
								function(win)
									win:toggle()
								end,
								mode = "n",
							},
							-- Terminal raw mode binding here?
						},
					},
				}
			end

			vim.keymap.set("n", "<leader>rf", function()
				return Snacks.rename.rename_file()
			end, { desc = "Rename File" })
			vim.keymap.set("n", "<C-y>", function()
				return Snacks.picker.resume()
			end)
			vim.keymap.set("n", "<leader>sb", function()
				return Snacks.picker.buffers()
			end, { desc = "Buffers" })
			vim.keymap.set("n", "<leader>sg", function()
				return Snacks.picker.grep({ live = true })
			end, { desc = "Live grep" })
			vim.keymap.set("n", "<leader>sr", function()
				return Snacks.picker.recent()
			end, { desc = "Recent files" })
			vim.keymap.set("n", "<leader>sf", function()
				return Snacks.picker.smart()
			end, { desc = "Smart picker" })
			vim.keymap.set("n", "<leader>sp", function()
				return Snacks.picker.projects({
					dev = {
						"~/dev",
						"~/dev/nix",
						"~/dev/lua",
						"~/dev/ansible",
						"~/dev/work",
						"~/dev/work/devops",
					},
					projects = {
						"~/.dotfiles",
						"~/Documents/colony",
					},
				})
			end, { desc = "Projects" })
			vim.keymap.set("n", "<leader>lG", function()
				return Snacks.lazygit(terminal_opts())
			end, { desc = "LazyGit" })
			vim.keymap.set("n", "<leader>sF", function()
				return Snacks.picker.files()
			end)
			vim.keymap.set("n", "<leader>sz", function()
				return Snacks.picker.zoxide()
			end, { desc = "Zoxide" })
			vim.keymap.set("n", "<leader>ld", function()
				return Snacks.picker.diagnostics_buffer()
			end, { desc = "Diagnostics" })

			vim.keymap.set("n", "<leader>qf", function()
				return Snacks.picker.qflist()
			end, { desc = "Quickfix List" })

			-- Git
			vim.keymap.set("n", "<leader>gs", function()
				return Snacks.picker.git_status()
			end, { desc = "Git status" })
			vim.keymap.set("n", "<leader>gB", function()
				return Snacks.git.blame_line()
			end, { desc = "Git status" })
			vim.keymap.set("n", "<leader>gb", function()
				return Snacks.picker.git_branches()
			end, { desc = "Git branches" })
			vim.keymap.set("n", "<leader>Nh", function()
				return Snacks.notifier.show_history()
			end, { desc = "Show notifier history" })

			-- LSP keybinds
			local lsp_symbols = {
				filter = {
					rust = true,
					lua = true,
					markdown = true,
				},
			}
			vim.keymap.set("n", "<leader>ls", function()
				Snacks.picker.lsp_symbols(lsp_symbols)
			end, { desc = "LSP Symbols" })
			vim.keymap.set("n", "<leader>lt", function()
				Snacks.picker.treesitter(lsp_symbols)
			end, { desc = "Treesitter symbols" })

			vim.keymap.set("n", "<leader>lws", function()
				Snacks.picker.lsp_workspace_symbols(lsp_symbols)
			end, { desc = "LSP Workspace Symbols" })

			vim.keymap.set("n", "<leader>lwd", function()
				return Snacks.picker.diagnostics()
			end, { desc = "Workspace Diagnostics" })
			vim.keymap.set("n", "<leader>vac", function()
				return Snacks.picker.autocmds()
			end, { desc = "Show autocmds" })
			vim.keymap.set("n", "<leader>tt", function()
				return Snacks.terminal.toggle(nil, terminal_opts())
			end, {
				desc = "Toggle Terminal",
			})
		end,
	},
}
