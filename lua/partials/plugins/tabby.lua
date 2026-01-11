-- SECTION: tabby
-- Eva-02 themed tab line: buffers (left) | tabs/sessions (right)
-- Uses scope.nvim for per-tab buffer isolation
--
-- Navigation:
--   Alt+h/j/k/l   = Move between splits
--   Ctrl+h/l      = Cycle buffers
--   <leader>1-5   = Switch tabs (sessions)
--   <leader>C-h/l = Prev/next tab
return {
	{
		"tabby.nvim",
		for_cat = "ui",
		event = "DeferredUIEnter",
		load = function(name)
			-- Load scope.nvim for per-tab buffer scoping
			vim.cmd.packadd("scope.nvim")
			require("scope").setup({})
			vim.cmd.packadd(name)
		end,
		after = function()
			local eva02 = require("partials.eva02")
			local c = eva02.colors

			-- Custom Eva-02 highlights for tabby
			vim.api.nvim_set_hl(0, "TabbyHead", { fg = c.bg, bg = c.red, bold = true })
			vim.api.nvim_set_hl(0, "TabbyHeadSep", { fg = c.red, bg = c.bg_dark })
			vim.api.nvim_set_hl(0, "TabbyActive", { fg = c.white, bg = c.red, bold = true })
			vim.api.nvim_set_hl(0, "TabbyActiveSep", { fg = c.red, bg = c.bg_dark })
			vim.api.nvim_set_hl(0, "TabbyInactive", { fg = c.grey, bg = c.bg_light })
			vim.api.nvim_set_hl(0, "TabbyInactiveSep", { fg = c.bg_light, bg = c.bg_dark })
			vim.api.nvim_set_hl(0, "TabbyFill", { bg = c.bg_dark })
			vim.api.nvim_set_hl(0, "TabbyTail", { fg = c.bg, bg = c.orange, bold = true })
			vim.api.nvim_set_hl(0, "TabbyTailSep", { fg = c.orange, bg = c.bg_dark })
			vim.api.nvim_set_hl(0, "TabbyWin", { fg = c.grey_light, bg = c.bg_light })
			vim.api.nvim_set_hl(0, "TabbyWinSep", { fg = c.bg_light, bg = c.bg_dark })
			vim.api.nvim_set_hl(0, "TabbyIcon", { fg = c.gold, bg = c.red })
			vim.api.nvim_set_hl(0, "TabbyIconInactive", { fg = c.amber_dark, bg = c.bg_light })
			vim.api.nvim_set_hl(0, "TabbyDir", { fg = c.gold, bg = c.red, italic = true })
			vim.api.nvim_set_hl(0, "TabbyDirInactive", { fg = c.grey_dim, bg = c.bg_light, italic = true })

			-- Get abbreviated directory name for a tab
			local function get_tab_cwd(tabid)
				local wins = vim.api.nvim_tabpage_list_wins(tabid)
				if #wins == 0 then
					return ""
				end
				-- Get cwd from first window's buffer
				local bufnr = vim.api.nvim_win_get_buf(wins[1])
				local bufname = vim.api.nvim_buf_get_name(bufnr)
				if bufname == "" then
					return ""
				end
				-- Get directory and abbreviate
				local dir = vim.fn.fnamemodify(bufname, ":h:t")
				if dir == "" or dir == "." then
					dir = vim.fn.fnamemodify(vim.fn.getcwd(-1, vim.api.nvim_tabpage_get_number(tabid)), ":t")
				end
				-- Return first 3 chars lowercase
				return dir:sub(1, 3):lower()
			end

			-- Get primary filetype icon for a tab
			local function get_tab_icon(tabid)
				local wins = vim.api.nvim_tabpage_list_wins(tabid)
				local ft_counts = {}
				-- Count filetypes across windows
				for _, win in ipairs(wins) do
					local bufnr = vim.api.nvim_win_get_buf(win)
					local ft = vim.bo[bufnr].filetype
					if ft and ft ~= "" and ft ~= "oil" and ft ~= "snacks_picker_list" then
						ft_counts[ft] = (ft_counts[ft] or 0) + 1
					end
				end
				-- Find most common filetype
				local max_ft, max_count = nil, 0
				for ft, count in pairs(ft_counts) do
					if count > max_count then
						max_ft, max_count = ft, count
					end
				end
				if not max_ft then
					return "󰈔" -- Default file icon
				end
				-- Try to get icon from mini.icons or nvim-web-devicons
				local ok, icons = pcall(require, "mini.icons")
				if ok then
					local icon = icons.get("filetype", max_ft)
					if icon then
						return icon
					end
				end
				-- Fallback icons for common languages
				local fallback_icons = {
					lua = "",
					rust = "",
					python = "",
					javascript = "",
					typescript = "",
					go = "",
					nix = "",
					markdown = "",
					json = "",
					yaml = "",
					toml = "",
					sh = "",
					bash = "",
					zsh = "",
					fish = "",
					vim = "",
					html = "",
					css = "",
					scss = "",
					c = "",
					cpp = "",
					java = "",
					ruby = "",
					php = "",
					dart = "",
					sql = "",
					dockerfile = "",
					terraform = "",
					hcl = "",
				}
				return fallback_icons[max_ft] or "󰈔"
			end

			-- Get buffer display name
			local function get_buf_name(bufnr)
				local name = vim.api.nvim_buf_get_name(bufnr)
				if name == "" then
					return "[No Name]"
				end
				return vim.fn.fnamemodify(name, ":t")
			end

			-- Get icon for buffer using mini.icons
			local function get_buf_icon(bufnr)
				local name = vim.api.nvim_buf_get_name(bufnr)
				local ok, icons = pcall(require, "mini.icons")
				if ok then
					local icon = icons.get("file", name)
					if icon then
						return icon
					end
				end
				return "󰈔"
			end

			require("tabby").setup({
				line = function(line)
					local buffers = {}
					-- Get scoped buffers for current tab (via scope.nvim)
					for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
						if vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buflisted then
							local name = vim.api.nvim_buf_get_name(bufnr)
							-- Skip empty and special buffers
							if name ~= "" and vim.bo[bufnr].buftype == "" then
								table.insert(buffers, bufnr)
							end
						end
					end

					local current_buf = vim.api.nvim_get_current_buf()

					return {
						-- Buffers on the left
						vim.tbl_map(function(bufnr)
							local is_current = bufnr == current_buf
							local hl = is_current and "TabbyActive" or "TabbyInactive"
							local sep_hl = is_current and "TabbyActiveSep" or "TabbyInactiveSep"
							local modified = vim.bo[bufnr].modified and " ●" or ""

							return {
								line.sep("", sep_hl, "TabbyFill"),
								get_buf_icon(bufnr) .. " ",
								get_buf_name(bufnr),
								modified,
								line.sep("", sep_hl, "TabbyFill"),
								hl = hl,
								margin = " ",
							}
						end, buffers),
						line.spacer(),
						-- Tabs/sessions on the right
						line.tabs().foreach(function(tab)
							local hl = tab.is_current() and "TabbyActive" or "TabbyInactive"
							local sep_hl = tab.is_current() and "TabbyActiveSep" or "TabbyInactiveSep"
							local icon_hl = tab.is_current() and "TabbyIcon" or "TabbyIconInactive"
							local dir_hl = tab.is_current() and "TabbyDir" or "TabbyDirInactive"

							local tabid = tab.id
							local icon = get_tab_icon(tabid)
							local dir = get_tab_cwd(tabid)
							local dir_display = dir ~= "" and (" " .. dir) or ""

							return {
								line.sep("", sep_hl, "TabbyFill"),
								{ icon .. " ", hl = icon_hl },
								tab.in_jump_mode() and tab.jump_key() or tab.number(),
								{ dir_display, hl = dir_hl },
								tab.close_btn(""),
								line.sep("", sep_hl, "TabbyFill"),
								hl = hl,
								margin = " ",
							}
						end),
						{
							line.sep("", "TabbyTailSep", "TabbyFill"),
							{ "  ", hl = "TabbyTail" },
						},
						hl = "TabbyFill",
					}
				end,
			})

			-- Always show tabline
			vim.o.showtabline = 2

			-- Buffer navigation (Ctrl+h/l)
			vim.keymap.set("n", "<C-h>", "<cmd>bprev<CR>", { desc = "Previous buffer" })
			vim.keymap.set("n", "<C-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })

			-- Tab/session navigation
			-- NOTE: Split navigation (Alt+hjkl) handled by smart-splits.nvim
			vim.keymap.set("n", "<leader>1", "1gt", { desc = "Go to tab 1" })
			vim.keymap.set("n", "<leader>2", "2gt", { desc = "Go to tab 2" })
			vim.keymap.set("n", "<leader>3", "3gt", { desc = "Go to tab 3" })
			vim.keymap.set("n", "<leader>4", "4gt", { desc = "Go to tab 4" })
			vim.keymap.set("n", "<leader>5", "5gt", { desc = "Go to tab 5" })
			vim.keymap.set("n", "<leader><C-h>", "<cmd>tabprev<CR>", { desc = "Previous tab" })
			vim.keymap.set("n", "<leader><C-l>", "<cmd>tabnext<CR>", { desc = "Next tab" })

			local utils = require("partials.utils")
			utils.map_all("n", {
				{ "<leader>j", ":Tabby jump_to_tab<CR>", "Jump to tab" },
				{ "<leader>ta", ":$tabnew<CR>", "New tab" },
				{ "<leader>tc", ":tabclose<CR>", "Close tab" },
				{ "<leader>to", ":tabonly<CR>", "Tab only" },
				{ "<leader>tmp", ":-tabmove<CR>", "Move tab left" },
				{ "<leader>tmn", ":+tabmove<CR>", "Move tab right" },
			})
		end,
	},
}
