require("lze").load({
	{ import = "partials.plugins.auto-session" },
	{ import = "partials.plugins.lint" },
	-- { import = "partials.plugins.tabby" },
	{ import = "partials.plugins.treesitter" },
	{ import = "partials.plugins.yanky" },
	{ import = "partials.plugins.harpoon" },
	{ import = "partials.plugins.conform" },
	{ import = "partials.plugins.lsp" },
	{ import = "partials.plugins.completion" },
	{ import = "partials.plugins.lualine" },
	{ import = "partials.plugins.snacks-nvim" },
	{ import = "partials.plugins.which-key" },
	{
		"rose-pine",
		for_cat = "general",
		after = function()
			vim.cmd("colorscheme rose-pine")
		end,
	},
	{
		"lazydev.nvim",
		for_cat = "general",
		-- event = "Filetype",
		cmd = { "LazyDev" },
		ft = "lua",
		after = function()
			require("lazydev").setup({
				library = {
					{ words = { "nixCats" }, path = (nixCats.nixCatsPath or "") .. "/lua" },
				},
			})
		end,
	},
	{
		"neocord",
		for_cat = "general",
		after = function()
			require("neocord").setup({
				editing_text = "Editing",
				enable_line_number = true,
				reading_text = "Reading",
			})
		end,
	},
	{
		"obsidian.nvim",
		for_cat = "general",
		ft = "markdown",
		after = function()
			require("obsidian").setup({
				workspaces = {
					{
						name = "colony",
						path = "~/Documents/colony",
					},
				},
			})
		end,
	},
	{
		"bufferline.nvim",
		for_cat = "general",
		load = function(name)
			vim.cmd.packadd(name)
			vim.cmd.packadd("nvim-web-devicons")
		end,
		after = function()
			require("bufferline").setup({})
			vim.keymap.set("n", "<C-l>", ":bnext<CR>", { desc = "Next Buffer" })
			vim.keymap.set("n", "<C-h>", ":bprevious<CR>", { desc = "Previous Buffer" })
		end,
	},
  {
    "direnv.vim",
    for_cat = "general",
    priority = 100,
    -- after = function()
    --   require("direnv-vim").setup({})
    -- end,
  },
  {
    "nix-develop.nvim",
    for_cat = "general",
  },
})
-- Config for rustaceanvim
local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set("n", "<leader>a", function()
	vim.cmd.RustLsp("codeAction") -- supports rust-analyzer's grouping
	-- or vim.lsp.buf.codeAction() if you don't want grouping.
end, { silent = true, buffer = bufnr })
vim.keymap.set(
	"n",
	"K", -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
	function()
		vim.cmd.RustLsp({ "hover", "actions" })
	end,
	{ silent = true, buffer = bufnr }
)
