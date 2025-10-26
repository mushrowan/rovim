local utils = require("partials.utils")

utils.map_normal_all({
	{ "<leader>lgD", vim.lsp.buf.declaration, "Go to declaration" },
	{ "<leader>lgd", vim.lsp.buf.definition, "Go to definition" },
	{ "<leader>lgt", vim.lsp.buf.type_definition, "Go to type" },
	{ "<leader>lgn", vim.diagnostic.get_next, "Go to next diagnostic" },
	{ "<leader>lgp", vim.diagnostic.get_prev, "Go to previous diagnostic" },
	{ "<leader>le", vim.diagnostic.open_float, "Open diagnostic float" },
	{ "<leader>lH", vim.lsp.buf.document_highlight, "Document highlight" },
	{ "<leader>lwa", vim.lsp.buf.add_workspace_folder, "Add workspace folder" },
	{ "<leader>lwr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder" },
	{ "<leader>lh", vim.lsp.buf.hover, "Trigger hover", { noremap = false } },
	{ "<leader>lS", vim.lsp.buf.signature_help, "Signature help" },
	{ "<leader>rn", vim.lsp.buf.rename, "Rename symbol" },
	{ "<leader>ca", vim.lsp.buf.code_action, "Code action", { noremap = false } },
})
