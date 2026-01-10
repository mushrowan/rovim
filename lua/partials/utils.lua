local M = {}

--- Create a keymap with default options
---@param mode string|table Mode(s) for the mapping
---@param keys string Key sequence
---@param action string|function Action to perform
---@param desc string Description for which-key
---@param opts? table Additional options
M.map = function(mode, keys, action, desc, opts)
	desc = desc or ""
	opts = opts or {}

	opts.desc = desc
	opts.silent = opts.silent or true

	vim.keymap.set(mode, keys, action, opts)
end

--- Create a buffer-local keymap
---@param bufnr number Buffer number
---@param mode string|table Mode(s) for the mapping
---@param keys string Key sequence
---@param action string|function Action to perform
---@param desc string Description for which-key
---@param opts? table Additional options
M.buf_map = function(bufnr, mode, keys, action, desc, opts)
	opts = opts or {}
	opts.buffer = bufnr
	M.map(mode, keys, action, desc, opts)
end

--- Create multiple keymaps at once
---@param mode string|table Mode(s) for all mappings
---@param mappings table[] List of {keys, action, desc, opts?} tables
M.map_all = function(mode, mappings)
	for _, mapping in ipairs(mappings) do
		M.map(
			mode,
			mapping[1] or mapping.keys,
			mapping[2] or mapping.action,
			mapping[3] or mapping.desc,
			mapping[4] or mapping.opts
		)
	end
end

return M
