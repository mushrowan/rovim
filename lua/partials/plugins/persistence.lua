-- SECTION: persistence
-- Session management with branch awareness
-- Excludes: floating windows, filetrees, help, terminals, etc.
return {
	{
		"persistence.nvim",
		for_cat = "editor",
		event = "BufReadPre",
		on_require = "persistence", -- Also load when require("persistence") is called
		after = function()
			-- Filetypes to always exclude (regardless of window type)
			local excluded_fts = {
				"oil",
				"neo-tree",
				"NvimTree",
				"help",
				"qf",
				"man",
				"notify",
				"noice",
				"Trouble",
				"lazy",
				"mason",
				"snacks_picker_list",
				"snacks_picker_input",
				"TelescopePrompt",
				"DressingInput",
				"DressingSelect",
			}

			--- Check if buffer is only shown in floating windows (not in any split)
			local function is_only_floating(buf)
				local wins = vim.fn.win_findbuf(buf)
				if #wins == 0 then
					return true -- Not visible, safe to exclude
				end
				for _, win in ipairs(wins) do
					local config = vim.api.nvim_win_get_config(win)
					if config.relative == "" then
						return false -- Found a non-floating window
					end
				end
				return true -- All windows are floating
			end

			require("persistence").setup({
				dir = vim.fn.stdpath("state") .. "/sessions/",
				need = 1,
				branch = true,
				pre_save = function()
					for _, buf in ipairs(vim.api.nvim_list_bufs()) do
						if vim.api.nvim_buf_is_valid(buf) then
							local ft = vim.bo[buf].filetype
							local bt = vim.bo[buf].buftype
							local dominated = vim.tbl_contains(excluded_fts, ft)
								or bt == "prompt"
								or bt == "popup"
							-- Terminals: keep if in split, delete if floating
							local is_terminal = ft == "snacks_terminal" or ft == "toggleterm" or bt == "terminal"
							local dominated_terminal = is_terminal and is_only_floating(buf)
							-- Other nofile buffers (not terminals): always exclude
							local other_nofile = bt == "nofile" and not is_terminal

							if dominated or dominated_terminal or other_nofile then
								pcall(vim.api.nvim_buf_delete, buf, { force = true })
							end
						end
					end
				end,
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
