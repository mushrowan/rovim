-- SECTION: neotest
return {
	{
		"neotest",
		for_cat = "testing",
		cmd = "Neotest",
		keys = {
			{ "<leader>Tt", desc = "Run nearest test" },
			{ "<leader>Tf", desc = "Run file tests" },
			{ "<leader>Ts", desc = "Test summary" },
			{ "<leader>To", desc = "Test output" },
		},
		load = function(name)
			vim.cmd.packadd(name)
			vim.cmd.packadd("neotest-rust")
		end,
		after = function()
			local neotest = require("neotest")
			neotest.setup({
				adapters = {
					require("neotest-rust")({
						args = { "--no-capture" },
						dap_adapter = "lldb",
					}),
				},
				status = {
					virtual_text = true,
					signs = true,
				},
				output = {
					enabled = true,
					open_on_run = "short",
				},
				quickfix = {
					enabled = true,
					open = false,
				},
				summary = {
					animated = true,
					enabled = true,
					expand_errors = true,
					follow = true,
				},
			})

			vim.keymap.set("n", "<leader>Tt", function()
				neotest.run.run()
			end, { desc = "Run nearest test" })

			vim.keymap.set("n", "<leader>Tf", function()
				neotest.run.run(vim.fn.expand("%"))
			end, { desc = "Run file tests" })

			vim.keymap.set("n", "<leader>Ts", function()
				neotest.summary.toggle()
			end, { desc = "Test summary" })

			vim.keymap.set("n", "<leader>To", function()
				neotest.output.open({ enter = true })
			end, { desc = "Test output" })

			vim.keymap.set("n", "<leader>TO", function()
				neotest.output_panel.toggle()
			end, { desc = "Test output panel" })

			vim.keymap.set("n", "<leader>Tw", function()
				neotest.watch.toggle(vim.fn.expand("%"))
			end, { desc = "Watch file tests" })

			vim.keymap.set("n", "<leader>Ta", function()
				neotest.run.run(vim.fn.getcwd())
			end, { desc = "Run all tests" })

			vim.keymap.set("n", "<leader>Td", function()
				neotest.run.run({ strategy = "dap" })
			end, { desc = "Debug nearest test" })
		end,
	},
}
