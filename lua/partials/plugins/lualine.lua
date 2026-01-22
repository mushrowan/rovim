-- SECTION: lualine
-- Eva-02 themed statusline with hostname display
return {
	{
		"lualine.nvim",
		for_cat = "ui",
		event = "DeferredUIEnter",
		after = function()
			local eva02 = require("partials.eva02")
			local hostname = vim.fn.hostname():upper()

			require("lualine").setup({
				extensions = {
					{
						filetypes = { "snacks_picker_list", "snacks_picker_input" },
						sections = {
							lualine_a = {
								function()
									return vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
								end,
							},
						},
					},
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
				options = {
					always_divide_middle = true,
					component_separators = { left = "", right = "" },
					globalstatus = true,
					icons_enabled = true,
					refresh = { statusline = 1000, tabline = 1000, winbar = 1000 },
					section_separators = { left = "", right = "" },
					theme = eva02.lualine,
				},
				sections = {
					lualine_a = {
						{
							"mode",
							icons_enabled = true,
							separator = { left = "▎", right = "" },
						},
					},
					lualine_b = {
						{
							"filetype",
							colored = false,
							icon_only = true,
							icon = { align = "left" },
						},
						{
							"filename",
							symbols = { modified = " ", readonly = " " },
							separator = { right = "" },
						},
					},
					lualine_c = {
						{
							"diff",
							colored = true,
							diff_color = {
								added = { fg = "#50C878" },
								modified = { fg = "#F0C020" },
								removed = { fg = "#E02020" },
							},
							symbols = { added = "+", modified = "~", removed = "-" },
							separator = { right = "" },
						},
						{
							"diagnostics",
							sources = { "nvim_diagnostic" },
							symbols = { error = " ", warn = " ", info = " ", hint = " " },
						},
					},
				lualine_x = {
					{
						-- opencode.nvim status
						function()
							local ok, opencode = pcall(require, "opencode")
							if ok then
								return opencode.statusline()
							end
							return ""
						end,
						cond = function()
							local ok, opencode = pcall(require, "opencode")
							return ok and opencode.statusline() ~= ""
						end,
					},
					{
						-- LSP server name
						function()
								local buf_ft = vim.bo.filetype
								local excluded = { toggleterm = true, NvimTree = true, ["neo-tree"] = true, TelescopePrompt = true }

								if excluded[buf_ft] then
									return ""
								end

								local clients = vim.lsp.get_clients({ bufnr = 0 })
								if vim.tbl_isempty(clients) then
									return "NO LSP"
								end

								local names = {}
								for _, client in ipairs(clients) do
									table.insert(names, client.name)
								end
								return table.concat(names, ", ")
							end,
							icon = " ",
							separator = { left = "" },
						},
					},
					lualine_y = {
						{ "progress" },
						{ "location" },
					},
					lualine_z = {
						{
							function()
								return hostname
							end,
							icon = "󰒋",
							separator = { left = "", right = "▕" },
						},
					},
				},
			})
		end,
	},
}
