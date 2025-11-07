return {
	{
		"snacks.nvim",
		for_cat = "general",
		after = function()
			require("snacks").setup({
				bigfile = { enabled = true },
				explorer = { enabled = true },
				indent = { enabled = true },
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
			local utils = require("partials.utils")
			-- from https://github.com/folke/snacks.nvim/discussions/1153
			-- vim.schedule(function()
			-- 	---@param path string
			-- 	---@param len? number
			-- 	---@param opts? {cwd?: string}
			-- 	require("snacks.picker.util").truncpath = function(path, len, opts)
			-- 		local cwd =
			-- 			svim.fs.normalize(opts and opts.cwd or vim.fn.getcwd(), { _fast = true, expand_env = false })
			-- 		local home = svim.fs.normalize("~")
			-- 		path = svim.fs.normalize(path, { _fast = true, expand_env = false })

			-- 		if path:find(cwd .. "/", 1, true) == 1 and #path > #cwd then
			-- 			path = path:sub(#cwd + 2)
			-- 		else
			-- 			local root = Snacks.git.get_root(path)
			-- 			if root and root ~= "" and path:find(root, 1, true) == 1 then
			-- 				-- NOTE: Changed from
			-- 				-- local tail = vim.fn.fnamemodify(root, ":t")
			-- 				local tail =
			-- 					vim.fs.joinpath(vim.fn.fnamemodify(path, ":h:t"), vim.fn.fnamemodify(path, ":t"))
			-- 				path = "⋮" .. tail .. "/" .. path:sub(#root + 2)
			-- 			elseif path:find(home, 1, true) == 1 then
			-- 				path = "~" .. path:sub(#home + 1)
			-- 			end
			-- 		end
			-- 		path = path:gsub("/$", "")

			-- 		if vim.api.nvim_strwidth(path) <= len then
			-- 			return path
			-- 		end

			-- 		local parts = vim.split(path, "/")
			-- 		if #parts < 2 then
			-- 			return path
			-- 		end
			-- 		local ret = table.remove(parts)
			-- 		local first = table.remove(parts, 1)
			-- 		if first == "~" and #parts > 0 then
			-- 			first = "~/" .. table.remove(parts, 1)
			-- 		end
			-- 		local width = vim.api.nvim_strwidth(ret) + vim.api.nvim_strwidth(first) + 3
			-- 		while width < len and #parts > 0 do
			-- 			local part = table.remove(parts) .. "/"
			-- 			local w = vim.api.nvim_strwidth(part)
			-- 			if width + w > len then
			-- 				break
			-- 			end
			-- 			ret = part .. ret
			-- 			width = width + w
			-- 		end
			-- 		return first .. "/…/" .. ret
			-- 	end
			-- end)
			-- -- Notifier LSP progress from https://github.com/folke/snacks.nvim/blob/0ccf97c6e14149cdf1f03ca0186b39101174d166/docs/notifier.md
			-- ---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
			-- local progress = vim.defaulttable()
			-- vim.api.nvim_create_autocmd("LspProgress", {
			-- 	---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
			-- 	callback = function(ev)
			-- 		local client = vim.lsp.get_client_by_id(ev.data.client_id)
			-- 		local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
			-- 		if not client or type(value) ~= "table" then
			-- 			return
			-- 		end
			-- 		local p = progress[client.id]

			-- 		for i = 1, #p + 1 do
			-- 			if i == #p + 1 or p[i].token == ev.data.params.token then
			-- 				p[i] = {
			-- 					token = ev.data.params.token,
			-- 					msg = ("[%3d%%] %s%s"):format(
			-- 						value.kind == "end" and 100 or value.percentage or 100,
			-- 						value.title or "",
			-- 						value.message and (" **%s**"):format(value.message) or ""
			-- 					),
			-- 					done = value.kind == "end",
			-- 				}
			-- 				break
			-- 			end
			-- 		end

			-- 		local msg = {} ---@type string[]
			-- 		progress[client.id] = vim.tbl_filter(function(v)
			-- 			return table.insert(msg, v.msg) or not v.done
			-- 		end, p)

			-- 		local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
			-- 		vim.notify(table.concat(msg, "\n"), "info", {
			-- 			id = "lsp_progress",
			-- 			title = client.name,
			-- 			opts = function(notif)
			-- 				notif.icon = #progress[client.id] == 0 and " "
			-- 					or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
			-- 			end,
			-- 		})
			-- 	end,
			-- })

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
			vim.keymap.set("n", "<leader>ss", function()
				return Snacks.picker.smart()
			end, { desc = "Smart picker" })
			vim.keymap.set("n", "<leader>sp", function()
				local projectspicker = Snacks.picker
				projectspicker.actions = {
					load_session = function(picker, item)
						picker:close()
						if not item then
							return
						end
						local dir = item.file
						local session_loaded = false
            Snacks.notify.info("whatttt")
						vim.api.nvim_create_autocmd("SessionLoadPost", {
							once = true,
							callback = function()
								session_loaded = true
							end,
						})
						vim.defer_fn(function()
							if not session_loaded then
								Snacks.picker.files()
							end
						end, 100)
						vim.fn.chdir(dir)
						local session = Snacks.dashboard.sections.session()
						if session then
							vim.cmd(session.action:sub(2))
						end
					end,
				}
				return Snacks.picker.projects({

					confirm = utils.handle_project_confirm,

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
			vim.keymap.set("n", "<leader>sf", function()
				return Snacks.picker.files()
			end)
			vim.keymap.set("n", "<leader>sz", function()
				return Snacks.picker.zoxide()
			end, { desc = "Zoxide" })
			vim.keymap.set("n", "<leader>se", function()
				return Snacks.explorer.open()
			end, { desc = "Explorer" })
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
			vim.keymap.set("n", "<leader>gb", function()
				return Snacks.picker.git_branches()
			end, { desc = "Git branches" })
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
