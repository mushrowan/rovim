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
				vim.lsp.config(ls, { autostart = false })
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
			vim.filetype.add({
				filename = {
					["docker-compose.yml"] = "yaml.docker-compose",
					["docker-compose.yaml"] = "yaml.docker-compose",
					["compose.yml"] = "yaml.docker-compose",
					["compose.yaml"] = "yaml.docker-compose",
				},
			})
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
