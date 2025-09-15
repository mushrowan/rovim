-- Set default root markers for all clients
return {
	{
		"nvim-lspconfig",
		for_cat = "general",
		lazy = false,
    priority = 100,
		dep_of = { "direnv.nvim" },
		--event = "Filetype",
		-- on_require = { "lspconfig" },

		before = function()
			require("partials.plugins.lspkeys")
			vim.lsp.config("*", {
				root_markers = { ".git" },
			})

      local enable_no_autostart = function(ls)
        vim.lsp.enable(ls)
        vim.lsp.config(ls, {autostart = false,})
      end
			-- Nixcats - use the lspandruntimedeps for this bit
			-- Nix
      enable_no_autostart("nil_ls")
      enable_no_autostart("nixd")
      enable_no_autostart("statix")

			-- Python
      enable_no_autostart("ruff")

			-- Lua
			vim.lsp.enable("lua_ls")
			vim.lsp.config("lua_ls", {
        -- autostart = false,
			})

			-- Docker Compose
			vim.lsp.enable("docker_compose_language_service")

			-- Ansible
			-- vim.lsp.enable("ansiblels")

			-- Azure Pipelines
			-- vim.lsp.enable("azure_pipelines_ls")

			-- Bash
			vim.lsp.enable("bashls")

			-- YAML
			vim.lsp.enable("yamlls")

			-- Markdown
			vim.lsp.enable("marksman")
			vim.lsp.enable("markdown_oxide")

			-- SQL
			vim.lsp.enable("sqls")
			vim.diagnostic.config({
        signs = true,
				underline = true,
				update_in_insert = false,
				virtual_lines = true,
				virtual_text = false,
			})
		end,
	},
}
