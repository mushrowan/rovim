local ok, err = pcall(require, "main")
if not ok then
  vim.notify("Error loading main.lua:\n" .. err, vim.log.levels.ERROR)
end
