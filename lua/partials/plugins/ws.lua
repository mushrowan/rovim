-- SECTION: workspaces
return {
	{
		"workspaces.nvim",
		for_cat = "general",
		cmd = { "WorkspacesAdd", "WorkspacesOpen", "WorkspacesList" },
		after = function()
			require("workspaces").setup()
		end,
	},
}
