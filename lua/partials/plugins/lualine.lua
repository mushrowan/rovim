-- SECTION: lualine
return {
	{
		"lualine.nvim",
		for_cat = "general",
		after = function()
			require("lualine").setup({
				["extensions"] = {
					{
						["filetypes"] = { "snacks_picker_list", "snacks_picker_input" },
						["sections"] = {
							["lualine_a"] = {
								function()
									return vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
								end,
							},
						},
					},
				},
				["inactive_sections"] = {
					["lualine_a"] = {},
					["lualine_b"] = {},
					["lualine_c"] = { "filename" },
					["lualine_x"] = { "location" },
					["lualine_y"] = {},
					["lualine_z"] = {},
				},
				["options"] = {
					["always_divide_middle"] = true,
					["component_separators"] = { "", "" },
					["globalstatus"] = true,
					["icons_enabled"] = true,
					["refresh"] = { ["statusline"] = 1000, ["tabline"] = 1000, ["winbar"] = 1000 },
					["section_separators"] = { "", "" },
					["theme"] = "auto",
				},
				["sections"] = {

					["lualine_a"] = {
						{
							"mode",
							icons_enabled = true,
							separator = {
								left = "▎",
								right = "",
							},
						},
						{
							"",
							draw_empty = true,
							separator = { left = "", right = "" },
						},
					},
					["lualine_b"] = {
						{
							"filetype",
							colored = true,
							icon_only = true,
							icon = { align = "left" },
						},
						{
							"filename",
							symbols = { modified = " ", readonly = " " },
							separator = { right = "" },
						},
						{
							"",
							draw_empty = true,
							separator = { left = "", right = "" },
						},
					},
					["lualine_c"] = {
						{
							"diff",
							colored = false,
							diff_color = {
								-- Same color values as the general color option can be used here.
								added = "DiffAdd", -- Changes the diff's added color
								modified = "DiffChange", -- Changes the diff's modified color
								removed = "DiffDelete", -- Changes the diff's removed color you
							},
							symbols = { added = "+", modified = "~", removed = "-" }, -- Changes the diff symbols
							separator = { right = "" },
						},
					},
					["lualine_x"] = {
						{
							-- Lsp server name
							function()
								local buf_ft = vim.bo.filetype
								local excluded_buf_ft =
									{ toggleterm = true, NvimTree = true, ["neo-tree"] = true, TelescopePrompt = true }

								if excluded_buf_ft[buf_ft] then
									return ""
								end

								local bufnr = vim.api.nvim_get_current_buf()
								local clients = vim.lsp.get_clients({ bufnr = bufnr })

								if vim.tbl_isempty(clients) then
									return "No Active LSP"
								end

								local active_clients = {}
								for _, client in ipairs(clients) do
									table.insert(active_clients, client.name)
								end

								return table.concat(active_clients, ", ")
							end,
							icon = " ",
							separator = { left = "" },
						},
					},
				},
			})
		end,
	},
}
