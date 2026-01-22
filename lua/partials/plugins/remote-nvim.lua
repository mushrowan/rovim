-- SECTION: remote-nvim
-- Remote development via SSH
return {
	{
		"remote-nvim.nvim",
		for_cat = "remote",
		cmd = { "RemoteStart", "RemoteStop", "RemoteInfo", "RemoteCleanup", "RemoteConfigDel", "RemoteLog" },
		after = function()
			require("remote-nvim").setup({
				ssh_config = {
					ssh_prompts = {
						{
							match = "password:",
							type = "secret",
							value_type = "static",
							value = "",
						},
						{
							match = "[sudo] password for",
							type = "secret",
							value_type = "static",
							value = "",
						},
						{
							match = "continue connecting (yes/no/[fingerprint])?",
							type = "plain",
							value_type = "static",
							value = "",
						},
					},
				},
			})
		end,
	},
}
