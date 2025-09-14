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
			-- Notifier LSP progress from https://github.com/folke/snacks.nvim/blob/0ccf97c6e14149cdf1f03ca0186b39101174d166/docs/notifier.md
			---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
			local progress = vim.defaulttable()
			vim.api.nvim_create_autocmd("LspProgress", {
				---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
				callback = function(ev)
					local client = vim.lsp.get_client_by_id(ev.data.client_id)
					local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
					if not client or type(value) ~= "table" then
						return
					end
					local p = progress[client.id]

					for i = 1, #p + 1 do
						if i == #p + 1 or p[i].token == ev.data.params.token then
							p[i] = {
								token = ev.data.params.token,
								msg = ("[%3d%%] %s%s"):format(
									value.kind == "end" and 100 or value.percentage or 100,
									value.title or "",
									value.message and (" **%s**"):format(value.message) or ""
								),
								done = value.kind == "end",
							}
							break
						end
					end

					local msg = {} ---@type string[]
					progress[client.id] = vim.tbl_filter(function(v)
						return table.insert(msg, v.msg) or not v.done
					end, p)

					local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
					vim.notify(table.concat(msg, "\n"), "info", {
						id = "lsp_progress",
						title = client.name,
						opts = function(notif)
							notif.icon = #progress[client.id] == 0 and " "
								or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
						end,
					})
				end,
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
				Snacks.terminal.toggle(nil, {
					-- Prevents opening zellij
					win = {
						position = "float",
						keys = terminal_keys,
					},
				})
			end, {
				desc = "Toggle Terminal",
			})
		end,
	},
}
