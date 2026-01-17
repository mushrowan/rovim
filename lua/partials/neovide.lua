-- Neovide-specific configuration
-- Note: Cursor VFX settings are in eva02.lua (colorscheme-specific)
if not vim.g.neovide then
  return {}
end

-- Window opacity
vim.g.neovide_normal_opacity = 0.97

-- Scaling keymaps
vim.g.neovide_scale_factor = 1.0

local function change_scale_factor(delta)
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end

vim.keymap.set("n", "<C-=>", function()
  change_scale_factor(1.25)
end, { desc = "Increase scale" })

vim.keymap.set("n", "<C-->", function()
  change_scale_factor(1 / 1.25)
end, { desc = "Decrease scale" })

return {}
