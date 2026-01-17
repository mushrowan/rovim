-- nixCats compatibility layer
-- Provides a mock nixCats plugin when config is loaded outside of Nix
local M = {}

---@type boolean
M.isNixCats = vim.g["nixCats-special-rtp-entry-nixCats"] ~= nil

---@class nixCatsSetupOpts
---@field non_nix_value boolean|nil

---Setup mock nixCats plugin when not using nix.
---If loaded via nix, this does nothing.
---@param v nixCatsSetupOpts
function M.setup(v)
  if M.isNixCats then
    return
  end

  local default_value = type(v) == "table" and type(v.non_nix_value) == "boolean"
    and v.non_nix_value or true

  local function mk_with_meta(tbl)
    return setmetatable(tbl, {
      __call = function(_, attrpath)
        local keys = {}
        if type(attrpath) == "table" then
          keys = attrpath
        elseif type(attrpath) == "string" then
          for key in attrpath:gmatch("([^%.]+)") do
            table.insert(keys, key)
          end
        end
        return vim.tbl_get(tbl, unpack(keys))
      end
    })
  end

  package.preload["nixCats"] = function()
    local ncsub = {
      get = function(_) return default_value end,
      cats = mk_with_meta({
        nixCats_config_location = vim.fn.stdpath("config"),
        wrapRc = false,
      }),
      settings = mk_with_meta({
        nixCats_config_location = vim.fn.stdpath("config"),
        configDirName = os.getenv("NVIM_APPNAME") or "nvim",
        wrapRc = false,
      }),
      petShop = mk_with_meta({}),
      extra = mk_with_meta({}),
      pawsible = mk_with_meta({
        allPlugins = { start = {}, opt = {} },
      }),
      configDir = vim.fn.stdpath("config"),
      packageBinPath = os.getenv("NVIM_WRAPPER_PATH_NIX") or vim.v.progpath,
    }
    return setmetatable(ncsub, {
      __call = function(_, cat) return ncsub.get(cat) end
    })
  end

  _G.nixCats = require("nixCats")
end

return M
