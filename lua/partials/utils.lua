local M = {}

M.merge_tables = function(t1, t2)
	for _, v in ipairs(t2) do
		table.insert(t1, v)
	end
end

M.map = function(mode, keys, action, desc, opts)
	desc = desc or ""
	opts = opts or {}

	opts.desc = desc
	opts.silent = opts.silent or true

	vim.keymap.set(mode, keys, action, opts)
end

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
