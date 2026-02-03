-- SECTION: img-clip
-- Paste images from clipboard into markdown files
return {
	{
		"img-clip.nvim",
		for_cat = "notes",
		ft = "markdown",
		cmd = { "PasteImage" },
		keys = {
			{ "<leader>pi", desc = "Paste image" },
		},
		after = function()
			-- find nearest "images" dir walking up from current file
			local function find_images_dir()
				local current = vim.fn.expand("%:p:h")
				while current ~= "/" do
					local images = current .. "/images"
					if vim.fn.isdirectory(images) == 1 then
						return vim.fn.fnamemodify(images, ":~:.")
					end
					current = vim.fn.fnamemodify(current, ":h")
				end
				return "images"
			end

			require("img-clip").setup({
				default = {
					dir_path = find_images_dir,
					prompt_for_file_name = true,
					show_dir_path_in_prompt = true,
				},
			})

			-- custom paste that prompts for format
			local function paste_image_with_format()
				vim.ui.select({ "markdown", "html" }, {
					prompt = "embed format:",
				}, function(choice)
					if not choice then
						return
					end
					local template = choice == "html" and '<img src="$FILE_PATH" alt="$CURSOR">'
						or "![$CURSOR]($FILE_PATH)"
					require("img-clip").paste_image({ template = template })
				end)
			end

			vim.keymap.set("n", "<leader>pi", paste_image_with_format, { desc = "paste image" })
		end,
	},
}
