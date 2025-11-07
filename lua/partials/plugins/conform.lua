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
					markdown = { "prettier" },
					nix = { "alejandra" },
					rust = { "rustfmt" },
					sh = { "shfmt" },
					caddy = { "caddy" },
				},

				formatters = {
					caddy = {
						command = "caddy",
						args = { "fmt", "-" },
						stdin = true,
					},
				},
			})

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
