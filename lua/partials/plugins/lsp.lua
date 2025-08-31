-- Set default root markers for all clients
return {
  {
    "nvim-lspconfig",
    for_cat = "general",
    after = function() 
      vim.lsp.config("*", {
      	root_markers = { ".git" },
      })
      
      -- Nixcats - use the lspandruntimedeps for this bit
      
      -- Nix
      vim.lsp.enable("nil_ls")
      vim.lsp.enable("statix")
      
      -- Python
      vim.lsp.enable("ruff")
      
      -- Lua
      vim.lsp.enable("lua_ls")
      
      
      -- Docker Compose
      vim.lsp.enable("docker_compose_language_service")
      
      -- Rust 
      vim.lsp.enable("rust_analyzer")
      
      -- Ansible
      vim.lsp.enable("ansiblels")
      
      -- Azure Pipelines
      vim.lsp.enable("azure_pipelines_ls")
      
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
      	["signs"] = false,
      	["underline"] = true,
      	["update_in_insert"] = false,
      	["virtual_lines"] = true,
      	["virtual_text"] = false,
      })
      
      -- Set default root markers for all clients
      vim.lsp.config("*", {
      	root_markers = { ".git" },
      })
      
      local function map(mode, key, action, desc)
      	vim.keymap.set(mode, key, action, { buffer = 0, noremap = true, silent = true, desc = desc })
      end
      
      map("n", "<leader>lgD", vim.lsp.buf.declaration, "Go to declaration")
      
      map("n", "<leader>lgd", vim.lsp.buf.definition, "Go to definition")
      map("n", "<leader>lgt", vim.lsp.buf.type_definition, "Go to type")
      map("n", "<leader>lgi", vim.lsp.buf.implementation, "List implementations")
      map("n", "<leader>lgr", vim.lsp.buf.references, "List references")
      map("n", "<leader>lgn", vim.diagnostic.goto_next, "Go to next diagnostic")
      map("n", "<leader>lgp", vim.diagnostic.goto_prev, "Go to previous diagnostic")
      map("n", "<leader>le", vim.diagnostic.open_float, "Open diagnostic float")
      map("n", "<leader>lH", vim.lsp.buf.document_highlight, "Document highlight")
      map("n", "<leader>lS", vim.lsp.buf.document_symbol, "List document symbols")
      map("n", "<leader>lwa", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
      map("n", "<leader>lwr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
      map("n", "<leader>lwl", function()
      	vim.notify(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, "List workspace folders")
      map("n", "<leader>lws", vim.lsp.buf.workspace_symbol, "List workspace symbols")
      map("n", "<leader>lh", vim.lsp.buf.hover, "Trigger hover")
      map("n", "<leader>ls", vim.lsp.buf.signature_help, "Signature help")
      map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
      map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
      map("n", "<leader>lf", vim.lsp.buf.format, "Format")
      
      map("n", "<leader>ltd", function()
      	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
      end, "Toggle diagnostics")
      map("n", "<leader>ltf", function()
      	vim.b.disableFormatSave = not vim.b.disableFormatSave
      end, "Toggle format on save") 
    end
  }
}
