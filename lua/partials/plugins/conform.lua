return {
	{
		"conform.nvim",
		for_cat = "general",
		keys = {
			{ "<leader>cf", desc = "[c]ode [f]ormat" },
		},
		after = function(_)
			local conform = require("conform")
			conform.setup({
				-- NOTE: download some formatters in lspsAndRuntimeDeps
				-- and configure them here
				formatters_by_ft = {
					dockerfile = { "dockerfmt" },
					lua = { "stylua" },
					markdown = { "prettier_markdown" },
					nix = { "alejandra" },
					rust = { "rustfmt" },
					sh = { "shfmt" },
					caddy = { "caddy" },
					dart = { "dart_format" },
				},

				formatters = {

					caddy = {
						command = "caddy",
						args = { "fmt", "-" },
						stdin = true,
					},
				},
			})
			-- for markdown formatting
			local markdown_formatter = vim.deepcopy(require("conform.formatters.prettier"))
			require("conform.util").add_formatter_args(markdown_formatter, {
				"--prose-wrap",
				"always",
				"--print-width",
				"80",
			}, { append = false })
			---@cast markdown_formatter conform.FormatterConfigOverride
			conform.formatters.prettier_markdown = markdown_formatter

			vim.keymap.set({ "n", "v" }, "<leader>cf", function()
				conform.format({
					lsp_fallback = true,
					async = true,
					timeout_ms = 1000,
				})
			end, { desc = "[c]ode [f]ormat" })
		end,
	},
}
