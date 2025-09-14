-- Set default root markers for all clients
return {
	{
		"nvim-lspconfig",
		for_cat = "general",
    lazy = false,
		-- event = "Filetype",
    -- on_require = { "lspconfig" },


		before = function()
      require("partials.plugins.lspkeys")
			vim.lsp.config("*", {
				root_markers = { ".git" },
			})

			-- Nixcats - use the lspandruntimedeps for this bit

			-- Nix
			vim.lsp.enable("nil_ls")
			vim.lsp.enable("nixd")
			vim.lsp.enable("statix")

			-- Python
			vim.lsp.enable("ruff")

			-- Lua
			vim.lsp.enable("lua_ls")

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
				["signs"] = true,
				["underline"] = true,
				["update_in_insert"] = false,
				["virtual_lines"] = true,
				["virtual_text"] = false,
			})


		end,
	},
}
