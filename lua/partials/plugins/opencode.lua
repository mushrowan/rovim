-- SECTION: opencode
-- AI-powered code assistance via opencode CLI
-- Uses snacks.nvim for terminal/input/picker integration
return {
	{
		"opencode.nvim",
		for_cat = "ai",
		cmd = { "Opencode" },
		keys = {
			{ "<leader>aa", desc = "Ask opencode" },
			{ "<leader>ae", desc = "Opencode operator", mode = { "n", "x" } },
			{ "<leader>ac", desc = "Toggle opencode" },
			{ "<leader>as", desc = "Select opencode action" },
			{ "<leader>ar", desc = "Interrupt opencode" },
		},
		after = function()
			-- Required for opencode to auto-reload edited buffers
			vim.o.autoread = true

			---@type opencode.Opts
			vim.g.opencode_opts = {
				provider = {
					enabled = "snacks",
				},
			}

			local opencode = require("opencode")

			-- Ask: input a prompt (migrated from <leader>aa AvanteAsk)
			vim.keymap.set({ "n", "x" }, "<leader>aa", function()
				opencode.ask()
			end, { desc = "Ask opencode" })

			-- Operator: add range/selection to opencode (migrated from <leader>ae AvanteEdit)
			vim.keymap.set({ "n", "x" }, "<leader>ae", function()
				return opencode.operator("@this ")
			end, { desc = "Opencode operator", expr = true })

			-- Toggle: show/hide opencode terminal (migrated from <leader>ac AvanteToggle)
			vim.keymap.set({ "n", "t" }, "<leader>ac", function()
				opencode.toggle()
			end, { desc = "Toggle opencode" })

			-- Select: pick from prompts, commands, provider controls
			vim.keymap.set({ "n", "x" }, "<leader>as", function()
				opencode.select()
			end, { desc = "Select opencode action" })

			-- Interrupt: stop current generation (migrated from <leader>ar AvanteRefresh)
			vim.keymap.set("n", "<leader>ar", function()
				opencode.command("session.interrupt")
			end, { desc = "Interrupt opencode" })
		end,
	},
}
