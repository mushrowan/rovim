-- SECTION: yanky
-- Yank history with sqlite persistence
return {
	{
		"yanky.nvim",
		for_cat = "editor",
		event = "BufReadPre",
		load = function(name) 
      vim.cmd.packadd(name)
      vim.cmd.packadd("sqlite.lua")
    end,
   
		after = function()
			require("yanky").setup({
				ring = {
					storage = "sqlite",
				},
				highlight = {
					timer = 100,
					on_put = true,
					on_yank = true,
				},
			})
		end,
	},
}
