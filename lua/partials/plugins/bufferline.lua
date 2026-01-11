-- SECTION: bufferline
-- Buffer tabs with scope.nvim for per-tab buffer isolation
return {
	{
		"bufferline.nvim",
		for_cat = "ui",
		event = "DeferredUIEnter",
		load = function(name)
			-- Load scope.nvim first for per-tab buffer scoping
			vim.cmd.packadd("scope.nvim")
			require("scope").setup({})
			vim.cmd.packadd(name)
			vim.cmd.packadd("nvim-web-devicons")
		end,
		after = function()
			require("bufferline").setup({
				options = {
					mode = "buffers",
					diagnostics = "nvim_lsp",
					show_buffer_close_icons = false,
					show_close_icon = false,
					separator_style = "slant",
					-- Show tabs on the right side
					show_tab_indicators = true,
					always_show_bufferline = true,
					offsets = {
						{
							filetype = "oil",
							text = "File Explorer",
							highlight = "Directory",
							separator = true,
						},
					},
					-- Tab indicators handled by tabby, not here
				},
			})

			-- Buffer navigation (scoped to current tab via scope.nvim)
			vim.keymap.set("n", "<C-h>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
			vim.keymap.set("n", "<C-l>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
			vim.keymap.set("n", "<C-S-h>", "<cmd>BufferLineMovePrev<CR>", { desc = "Move buffer left" })
			vim.keymap.set("n", "<C-S-l>", "<cmd>BufferLineMoveNext<CR>", { desc = "Move buffer right" })

			-- Tab/workspace navigation
			vim.keymap.set("n", "<leader>1", "1gt", { desc = "Go to tab 1" })
			vim.keymap.set("n", "<leader>2", "2gt", { desc = "Go to tab 2" })
			vim.keymap.set("n", "<leader>3", "3gt", { desc = "Go to tab 3" })
			vim.keymap.set("n", "<leader>4", "4gt", { desc = "Go to tab 4" })
			vim.keymap.set("n", "<leader>5", "5gt", { desc = "Go to tab 5" })
			vim.keymap.set("n", "gt", "<cmd>tabnext<CR>", { desc = "Next tab" })
			vim.keymap.set("n", "gT", "<cmd>tabprev<CR>", { desc = "Previous tab" })
		end,
	},
}
