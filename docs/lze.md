# lze Lazy Loading Reference

This document describes the lazy loading triggers available in [lze](https://github.com/BirdeeHub/lze), the lazy loading library used by this config.

## Load Triggers

### event

Triggers when a Neovim autocommand event fires.

```lua
{
  "plugin-name",
  event = "BufReadPre",           -- Single event
  event = { "BufEnter", "BufWritePost" },  -- Multiple events
  event = "BufEnter *.lua",       -- Event with pattern
  event = { event = "BufEnter", pattern = "*.lua" },  -- Explicit format
}
```

**Special event:** `DeferredUIEnter` - Fires after UIEnter when initial lazy loading completes. Good for non-critical UI plugins.

### ft (FileType)

Triggers when a specific filetype is opened.

```lua
{
  "plugin-name",
  ft = "lua",                     -- Single filetype
  ft = { "lua", "python", "rust" },  -- Multiple filetypes
}
```

### cmd (Command)

Triggers when a user command is executed. Creates placeholder commands that load the plugin when invoked.

```lua
{
  "plugin-name",
  cmd = "PluginCommand",          -- Single command
  cmd = { "Cmd1", "Cmd2" },       -- Multiple commands
}
```

### keys (Keymaps)

Triggers when a keybinding is pressed. Creates placeholder mappings.

```lua
{
  "plugin-name",
  keys = "<leader>f",             -- Simple keymap
  keys = { "<leader>f", "<cmd>DoThing<CR>", desc = "Do thing" },  -- With action
  keys = { "<leader>f", mode = "n" },  -- Explicit mode (default: "n")
  keys = { "<leader>f", ft = "python" },  -- Buffer-local via filetype
  keys = {                        -- Multiple keys
    { "<leader>f", desc = "Find" },
    { "<leader>g", desc = "Grep" },
  },
}
```

### colorscheme

Triggers when a colorscheme is set.

```lua
{
  "plugin-name",
  colorscheme = "tokyonight",     -- Single scheme
  colorscheme = { "tokyonight", "catppuccin" },  -- Multiple schemes
}
```

### on_require

Triggers when a Lua module is `require()`d. Useful for plugins that are called programmatically.

```lua
{
  "plugin-name",
  on_require = "persistence",     -- Load when require("persistence") is called
  on_require = { "mod1", "mod2" },  -- Multiple modules
}
```

This matches the top-level module and all submodules (e.g., `on_require = "foo"` matches `require("foo")` and `require("foo.bar")`).

## Dependency Triggers

### dep_of

Loads this plugin BEFORE another plugin loads.

```lua
{
  "dependency-plugin",
  dep_of = "main-plugin",         -- Load before main-plugin
  dep_of = { "plugin1", "plugin2" },  -- Load before multiple plugins
}
```

### on_plugin

Loads this plugin AFTER another plugin loads.

```lua
{
  "extension-plugin",
  on_plugin = "main-plugin",      -- Load after main-plugin
  on_plugin = { "plugin1", "plugin2" },  -- Load after any of these
}
```

## Lifecycle Hooks

These run at specific points during plugin loading:

```lua
{
  "plugin-name",
  beforeAll = function(plugin)
    -- Runs before ANY plugins in a load() call
  end,
  before = function(plugin)
    -- Runs before THIS plugin loads
  end,
  load = function(name)
    -- Custom load function (default: vim.cmd.packadd)
    vim.cmd.packadd(name)
  end,
  after = function(plugin)
    -- Runs after THIS plugin loads
    -- Put setup() calls here
    require("plugin").setup({})
  end,
}
```

## Other Options

```lua
{
  "plugin-name",
  enabled = true,                 -- Boolean or function, controls if plugin is active
  lazy = true,                    -- Mark as lazy-loaded (auto-set when using triggers)
  priority = 50,                  -- Load order for startup plugins (higher = earlier)
  allow_again = false,            -- Allow re-triggering after already loaded
}
```

## Custom Handler: for_cat

This config includes a custom `for_cat` handler that integrates with nixCats:

```lua
{
  "plugin-name",
  for_cat = "editor",             -- Only load if nixCats("editor") is true
  for_cat = { cat = "editor", default = true },  -- With non-Nix fallback
}
```

See `lua/nixCatsUtils/lzUtils.lua` for implementation.

## Example Plugin Spec

```lua
return {
  {
    "persistence.nvim",
    for_cat = "editor",
    event = "BufReadPre",
    on_require = "persistence",   -- Also load on require()
    after = function()
      require("persistence").setup({
        dir = vim.fn.stdpath("state") .. "/sessions/",
      })
    end,
  },
}
```

## Combining Triggers

Multiple triggers can be combined - the plugin loads when ANY trigger fires:

```lua
{
  "plugin-name",
  event = "BufReadPre",
  cmd = "PluginCommand",
  keys = "<leader>p",
  on_require = "plugin",
  -- Plugin loads on first of: file read, command, keypress, or require()
}
```
