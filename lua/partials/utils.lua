local M = {}

local function open_file_in_new_session(project_dir)
	return function(_, file_item)
		local file_path = file_item.file

		-- i. Clear all buffers
    MiniBufremove.wipeout()

		-- ii. Open the selected file
		vim.cmd("e " .. vim.fn.fnameescape(file_path))
		-- iii. Create the new session (saves the single open buffer)
		MiniSessions.write(project_dir, { force = true })

		-- iv. Load the newly created session
		MiniSessions.read(project_dir)
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

	-- If the selected path is not a directory, exit
	-- TODO: maybe go into parent directory
	if vim.fn.isdirectory(project_dir) == 0 then
		return
	end

	-- Check for an existing session
	if session_exists(project_basename) then
		-- Session EXISTS: Load it and change directory
		MiniSessions.read(project_basename)
	else
		-- Session DOESN'T EXIST: Launch File Picker

		-- Set CWD for the subsequent file picker
		vim.cmd("cd " .. vim.fn.fnameescape(project_dir))
		Snacks.picker.files({
			title = "Select File to Start New Session in " .. vim.fn.fnamemodify(project_basename, ":t"),
			cwd = project_dir,

			-- Nested CONFIRM function for the File Picker
			confirm = open_file_in_new_session(project_basename),
		})
	end
end

return M
