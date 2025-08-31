-- Global attrset for stuffs
_G.ro = {}

local ok, err = pcall(require, 'main')
if not ok then
  vim.notify('Error loading main.lua.\n' .. err)
  -- TODO: Load fallback
  -- vim.cmd.runtime('minvimrc.vim')
end

