return {
	{
		"obsidian.nvim",
		for_cat = "notes",
		event = "DeferredUIEnter",
		after = function()
			require("obsidian").setup({
				ui = {
					enable = false,
				},
				legacy_commands = false,
				workspaces = {
					{
						name = "colony",
						path = "~/Documents/colony",
					},
				},
				templates = {
					folder = "templates",
					date_format = "%Y-%m-%d-%a",
					time_format = "%H:%M",
				},
				daily_notes = {
					folder = "dailies",
					template = "daily_template.md",
				},
			})
			-- Move completed todo item to archive file
		local move_to_todo_archive = function()
				local target_file = vim.fn.expand("~/Documents/colony/todo_archive.md")
				local line = vim.api.nvim_get_current_line()
				if not string.match(line, "^%s*%- %[ %]") then
					print("Not an incomplete todo item")
					return
				end
				local new_line = string.gsub(line, "%- %[ %]", "- [x]", 1)
				local date_str = os.date("%Y-%m-%d")
				new_line = new_line .. " ✅ " .. date_str
				local f = io.open(target_file, "a")
				if f then
					f:write(new_line .. "\n")
					f:close()
					vim.api.nvim_del_current_line()
					print("Task moved to Archive")
				else
					print("Error: Could not open target file: " .. target_file)
				end
			end
			require("partials.utils").map_all("n", {
				{
					"<leader>oo",
					function()
						vim.cmd("cd " .. vim.fn.expand("~/Documents/colony"))
						require("persistence").load()
					end,
					"Open obsidian session",
				},
				{
					"<leader>of",
					"<cmd>Obsidian quick_switch<CR>",
					"Open obsidian file",
				},
				{
					"<leader>od",
					"<cmd>Obsidian today<CR>",
					"Open today's note",
				},
				{
					"<leader>ot",
					"<cmd>Obsidian tags<CR>",
					"Tags",
				},
				{ "<leader>oc", move_to_todo_archive, "complete task" },
			})
		end,
	},
}
