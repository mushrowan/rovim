local M = {}

-- Helper to get session file path for a project
local function get_session_path(project_name)
	local session_dir = vim.fn.stdpath("state") .. "/sessions/"
	-- persistence.nvim uses directory path with / replaced by %
	return session_dir .. project_name .. ".vim"
end

local function session_exists(project_name)
	return vim.fn.filereadable(get_session_path(project_name)) == 1
end

local function open_file_in_new_session(project_dir)
	return function(_, file_item)
		local file_path = file_item.file

		-- Open the selected file
		vim.cmd("e " .. vim.fn.fnameescape(file_path))

		-- Save session using persistence
		require("persistence").save()
	end
end

-- Check if we're already in this project (in any tab)
local function is_current_project(project_dir)
	local current_cwd = vim.fn.getcwd()
	local expanded_project = vim.fn.expand(project_dir)
	return current_cwd == expanded_project
end

-- This is the custom function you will assign to the 'confirm' option
-- Opens projects in a new tab to keep other projects alive
M.handle_project_confirm = function(picker, item)
	-- Close the project picker immediately
	picker:close()

	-- Guard against nil item
	if not item then
		return
	end

	local project_dir = item.file
	local project_basename = vim.fn.fnamemodify(project_dir, ":t")

	-- Use vim.schedule to defer actions after picker is fully closed
	vim.schedule(function()
		-- Check if we're already in this project
		if is_current_project(project_dir) then
			vim.notify("Already in " .. project_basename, vim.log.levels.INFO)
			return
		end

		-- Create a new tab for the project (keeps current project alive)
		vim.cmd("tabnew")

		-- Change to project directory (tcd for tab-local cwd)
		vim.cmd("tcd " .. vim.fn.fnameescape(project_dir))

		-- Check for an existing session
		if session_exists(project_basename) then
			-- Session EXISTS: Load it
			require("persistence").load()
		else
			-- No session: open file picker to start new session
			Snacks.picker.files({
				title = "Select File to Start New Session in " .. project_basename,
				ignored = true,
				hidden = false,
				cwd = project_dir,
				confirm = open_file_in_new_session(project_dir),
			})
		end
	end)
end

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
