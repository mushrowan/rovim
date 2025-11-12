local M = {}

local function open_file_in_new_session(project_basename)
	return function(_, file_item)
		local file_path = file_item.file

		-- i. Clear all buffers
		MiniBufremove.wipeout()

		-- ii. Open the selected file
		vim.cmd("e " .. vim.fn.fnameescape(file_path))
		-- iii. Create the new session (saves the single open buffer)
		MiniSessions.write(project_basename, { force = true })

		-- iv. Load the newly created session
		MiniSessions.read(project_basename)
	end
end

-- Function 1: Helper function to check if a session exists for a directory
local function session_exists(dir)
	-- Construct the full expected path for the global session file
	local session_path = MiniSessions.config.directory .. "/" .. dir

	return vim.fn.filereadable(session_path) == 1
end
-- -------

-- This is the custom function you will assign to the 'confirm' option
M.handle_project_confirm = function(picker, item)
	local project_dir = item.file
	local project_basename = vim.fn.fnamemodify(project_dir, ":t")

	-- Close the project picker immediately
	picker:close()

	-- Check for an existing session
	if session_exists(project_basename) then
		-- Session EXISTS: Load it and change directory
		MiniSessions.read(project_basename)
	else
		-- Set CWD for the subsequent file picker
		vim.cmd("cd " .. vim.fn.fnameescape(project_dir))
		-- vim.cmd("cd " .. project_dir)
		Snacks.picker.files({
			title = "Select File to Start New Session in " .. vim.fn.fnamemodify(project_basename, ":t"),
			ignored = true,
			hidden = false,
			cwd = project_dir,

			-- Nested CONFIRM function for the File Picker
			confirm = open_file_in_new_session(project_basename),
		})
	end
end
-- use ipairs
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
