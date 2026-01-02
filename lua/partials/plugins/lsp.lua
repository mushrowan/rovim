-- Set default root markers for all clients
return {
	{
		"rustaceanvim",
		for_cat = "general",
		lazy = false,
		dep_of = { "direnv.nvim" },
		priority = 100,
		before = function()
			vim.g.rustaceanvim = {
				server = {
					on_attach = function(_, bufnr)
						vim.keymap.set("n", "<leader>ca", function()
							vim.cmd.RustLsp("codeAction") -- supports rust-analyzer's grouping
						end, { noremap = true, silent = true, buffer = bufnr })
						vim.keymap.set(
							"n",
							"K", -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
							function()
								vim.cmd.RustLsp({ "hover", "actions" })
							end,
							{ noremap = true, silent = true, buffer = bufnr }
						)
					end,
				},
			}
		end,
	},
	{
		"nvim-lspconfig",
		for_cat = "general",
		-- lazy = false,
		-- priority = 100,
		dep_of = { "direnv.nvim" },

		before = function()
			require("partials.plugins.lspkeys")

			-- Filetypes
			vim.filetype.add({
				filename = {
					["docker-compose.yml"] = "yaml.docker-compose",
					["docker-compose.yaml"] = "yaml.docker-compose",
					["compose.yml"] = "yaml.docker-compose",
					["compose.yaml"] = "yaml.docker-compose",
				},
				extension = {
					jinja = "jinja",
					jinja2 = "jinja",
					j2 = "jinja",
				},
				pattern = {
					[".*%.yaml%.j2"] = "yaml.jinja",
					[".*%.yml%.j2"] = "yaml.jinja",
				},
			})

			vim.lsp.config("*", {
				root_markers = { ".git" },
			})

			-- Nix
			vim.lsp.enable("nil_ls")
			vim.lsp.enable("nixd")
			vim.lsp.enable("statix")

			-- CSharp
			vim.lsp.enable("csharp_ls")

			-- Dart
			vim.lsp.enable("dartls")

			-- Python
			vim.lsp.enable("ruff")

			-- Go
			vim.lsp.config("gopls", {
				settings = {
					gopls = {
						templateExtensions = { "tmpl", "html", "gotmpl" },
						semanticTokens = true,
					},
				},
			})
			vim.lsp.enable("gopls")

			-- Lua
			vim.lsp.enable("lua_ls")
			-- Jinja (attach to any filetype containing "jinja")
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "*",
				callback = function(args)
					if args.match:find("jinja") then
						vim.lsp.start(vim.lsp.config.jinja_lsp)
					end
				end,
			})

			-- Qml
			vim.lsp.enable("qmlls")

			-- Terraform/OpenTofu
			vim.lsp.enable("terraformls")

			-- Docker
			vim.lsp.enable("docker_language_server")
			vim.lsp.enable("dockerls")

			-- Docker-compose
			vim.lsp.enable("docker_compose_language_service")
			-- Javascript/typescript
			vim.lsp.enable("ts_ls")
			-- JSON
			vim.lsp.enable("jsonls")
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
		end,
	},
}
