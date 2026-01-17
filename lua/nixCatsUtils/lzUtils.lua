-- lze handler for nixCats category-based plugin enabling
-- Register with: require("lze").register_handlers(require("nixCatsUtils.lzUtils").for_cat)
--
-- Usage in plugin specs:
--   for_cat = "category.name"
--   for_cat = { cat = "category.name", default = true }
local M = {}

M.for_cat = {
  spec_field = "for_cat",
  set_lazy = false,
  modify = function(plugin)
    local cat = plugin.for_cat
    if type(cat) == "table" and cat.cat ~= nil then
      -- { cat = "name", default = bool } form
      if vim.g["nixCats-special-rtp-entry-nixCats"] ~= nil then
        plugin.enabled = nixCats(cat.cat) or false
      else
        plugin.enabled = cat.default
      end
    else
      -- Simple string form
      plugin.enabled = nixCats(cat) or false
    end
    return plugin
  end,
}

return M
