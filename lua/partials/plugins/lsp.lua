-- SECTION: lsp
-- LSP configuration, diagnostics display, and syntax plugins
return {
	-- Jinja2 template syntax highlighting
	{
		"jinja.vim",
		for_cat = "lsp",
		lazy = false, -- Syntax plugin, must load eagerly
	},
	-- Multi-line diagnostic display
	{
		"lsp_lines.nvim",
		for_cat = "lsp",
		event = "LspAttach",
		after = function()
			vim.diagnostic.config({ virtual_lines = true, virtual_text = false })
			require("lsp_lines").setup()
		end,
	},
	{
		"rustaceanvim",
		for_cat = "lsp",
		ft = "rust",
		dep_of = { "direnv-nvim" },
		priority = 100,
		before = function()
			vim.g.rustaceanvim = {
				server = {
					on_attach = function(_, bufnr)
						local utils = require("partials.utils")
						utils.buf_map(bufnr, "n", "<leader>ca", function()
							vim.cmd.RustLsp("codeAction")
						end, "Rust code action")
						utils.buf_map(bufnr, "n", "K", function()
							vim.cmd.RustLsp({ "hover", "actions" })
						end, "Rust hover actions")
					end,
				},
			}
		end,
	},
	{
		"nvim-lspconfig",
		for_cat = "lsp",
		event = "BufReadPost",
		dep_of = { "direnv-nvim" },

		before = function()
			-- Custom filetypes
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
					gotmpl = "go",
				},
				pattern = {
					[".*%.yaml%.j2"] = "yaml.jinja",
					[".*%.yml%.j2"] = "yaml.jinja",
				},
			})

			-- Default root markers for all LSP clients
			vim.lsp.config("*", {
				root_markers = { ".git" },
			})

			-- LSP servers to enable (grouped by language/purpose)
			local servers = {
				-- Nix
				"nil_ls",
				"nixd",
				"statix",
				-- .NET
				"csharp_ls",
				-- Dart
				"dartls",
				-- Python
				"ruff",
				-- Go
				"gopls",
				-- Lua
				"lua_ls",
				-- QML
				"qmlls",
				-- Terraform
				"terraformls",
				-- Docker
				"docker_language_server",
				"dockerls",
				"docker_compose_language_service",
				-- Web
				"ts_ls",
				"jsonls",
				-- Shell
				"bashls",
				-- Data
				"yamlls",
				"sqls",
				-- Docs
				"marksman",
				"markdown_oxide",
			}

			for _, server in ipairs(servers) do
				vim.lsp.enable(server)
			end

			-- Custom server configurations
			vim.lsp.config("gopls", {
				settings = {
					gopls = {
						templateExtensions = { "tmpl", "html", "gotmpl" },
						semanticTokens = true,
					},
				},
			})

			-- Jinja LSP (attach to filetypes containing "jinja")
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "jinja", "*.jinja", "*.jinja2" },
				callback = function()
					vim.lsp.start(vim.lsp.config.jinja_lsp)
				end,
			})
		end,
	},
}
