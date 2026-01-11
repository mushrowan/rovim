-- SECTION: tabby
-- Eva-02 themed tab line with directory and filetype info
return {
	{
		"tabby.nvim",
		for_cat = "ui",
		event = "DeferredUIEnter",
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

			require("tabby").setup({
				line = function(line)
					return {
						{
							{ "  ", hl = "TabbyHead" },
							line.sep("", "TabbyHeadSep", "TabbyFill"),
						},
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
						line.spacer(),
						line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
							return {
								line.sep("", "TabbyWinSep", "TabbyFill"),
								win.is_current() and "" or "",
								win.buf_name(),
								line.sep("", "TabbyWinSep", "TabbyFill"),
								hl = "TabbyWin",
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

			local utils = require("partials.utils")
			utils.map_all("n", {
				{ "<leader>j", ":Tabby jump_to_tab<CR>", "Jump to tab" },
				{ "<leader>ta", ":$tabnew<CR>", "New tab" },
				{ "<leader>tc", ":tabclose<CR>", "Close tab" },
				{ "<leader>to", ":tabonly<CR>", "Tab only" },
				{ "<leader>tn", ":tabn<CR>", "Next tab" },
				{ "<leader>tp", ":tabp<CR>", "Previous tab" },
				{ "<leader>tmp", ":-tabmove<CR>", "Move tab left" },
				{ "<leader>tmn", ":+tabmove<CR>", "Move tab right" },
			})
		end,
	},
}
