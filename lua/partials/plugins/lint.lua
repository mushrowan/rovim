return {
	{
		"nvim-lint",
		for_cat = "format",
		event = "Filetype",

		after = function(_)
			require("lint").linters_by_ft = {
				dockerfile = { "trivy" },
			}

			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
}
