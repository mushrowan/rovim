# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Neovim configuration managed by **nixCats-nvim** (Nix-based plugin management) with **lze** (lazy loading library). The configuration supports both Nix and non-Nix environments through fallback mechanisms in `lua/nixCatsUtils/`.

## Key Dependencies

- **lze** (`/home/rowan/dev/lua/lze`): Lazy loading library for Neovim plugins. Handles deferred loading via events, filetypes, commands, and keys.
- **nixCats-nvim** (`/home/rowan/dev/nix/nixCats-nvim`): Nix package manager for Neovim. Defines plugin categories in `flake.nix`, queried at runtime via `nixCats("category.name")`.

## Commands

```bash
# Build and run the configuration (opens neovide)
nix run .

# Run just nvim without neovide
nix run .#nvim

# Enter dev shell with nvim available (uses local lua for live editing)
nix develop

# Check configuration loads without errors
nix flake check

# Run headless config check
nix run .#nvim -- --headless +'lua print("ok")' +qa
```

## Architecture

### Entry Point Flow
1. `init.lua` - Sets `_G.ro` namespace, calls `main.lua`
2. `lua/main.lua` - Registers lze handlers, then loads partials in order:
   - `partials.settings` - vim options (editing, display, behavior)
   - `partials.neovide` - neovide-specific settings (only runs in neovide)
   - `partials.mappings` - global keymaps
   - `partials.abbreviations` - command abbreviations
   - `partials.plugins` - all plugins via `lze.load()`

### Plugin Configuration Pattern

Each plugin file in `lua/partials/plugins/` returns a table with this structure:

```lua
return {
  {
    "plugin-name",           -- Name must match nixCats package name
    for_cat = "editor",      -- nixCats category (enables/disables via Nix)
    event = "DeferredUIEnter", -- Lazy load trigger (or ft, cmd, keys)
    load = function(name)    -- Optional: custom load function
      vim.cmd.packadd(name)
    end,
    before = function() end, -- Runs before plugin loads
    after = function()       -- Runs after plugin loads (setup goes here)
      require("plugin").setup({})
    end,
    dep_of = { "other" },    -- Load before these plugins
    on_plugin = { "dep" },   -- Load after these plugins
  },
}
```

Plugins are imported in `lua/partials/plugins/init.lua` using `{ import = "partials.plugins.filename" }`.

### for_cat Handler

The custom `for_cat` handler (`lua/nixCatsUtils/lzUtils.lua`) integrates lze with nixCats:

```lua
for_cat = "editor"                            -- Simple category check
for_cat = { cat = "editor", default = true }  -- With non-Nix fallback
```

### Utility Functions

`lua/partials/utils.lua` provides:
- `map(mode, keys, action, desc, opts)` - Single keymap with defaults
- `buf_map(bufnr, mode, keys, action, desc, opts)` - Buffer-local keymap
- `map_all(mode, mappings)` - Batch keymaps from table

### Nix Structure

In `flake.nix`:
- `categoryDefinitions.lspsAndRuntimeDeps` - LSPs and CLI tools added to PATH
- `categoryDefinitions.startupPlugins` - Plugins loaded immediately (lze, plenary, nui)
- `categoryDefinitions.optionalPlugins` - Plugins loaded via `packadd` (everything else)
- `defaultCategories` - Shared category toggles used by all package variants
- `sharedSettings` - Common settings for nvim and nvim-dev packages

Available categories: `editor`, `ui`, `lsp`, `completion`, `git`, `testing`, `notes`, `format`, `ai`, `remote`, `discordRichPresence`, `typst`

### NixOS/Home-Manager Modules

`modules/nixos.nix` and `modules/home-manager.nix` wrap the package with:
- `avanteApiKeyFile` option for secure API key injection via environment variable

## Key Conventions

- **Leader key**: `<space>`
- **LSP mappings**: `<leader>l*` (go to: `<leader>lg*`, workspace: `<leader>lw*`)
- **Git mappings**: `<leader>g*` (hunks: `<leader>gh*`)
- **Search/picker mappings**: `<leader>s*`
- **Tab mappings**: `<leader>t*` (move: `<leader>tm*`)
- **Test mappings**: `<leader>T*`
- **Obsidian mappings**: `<leader>o*`
- **Lazy load event**: `DeferredUIEnter` for non-critical UI plugins

## Adding a New Plugin

1. Add to `flake.nix` under appropriate category in `optionalPlugins`
2. Create `lua/partials/plugins/pluginname.lua` with spec (or add to existing related file)
3. Add `{ import = "partials.plugins.pluginname" }` to `lua/partials/plugins/init.lua`
4. Run `nix flake check` to verify

## File Structure

```
lua/
├── main.lua                 # Entry point, loads all partials
├── nixCatsUtils/
│   ├── init.lua            # nixCats compatibility layer
│   └── lzUtils.lua         # for_cat handler for lze
└── partials/
    ├── settings.lua        # Core vim options
    ├── neovide.lua         # Neovide-specific config
    ├── mappings.lua        # Global keymaps
    ├── abbreviations.lua   # Command abbreviations
    ├── utils.lua           # Keymap utilities
    ├── eva02.lua           # Custom colorscheme
    └── plugins/
        ├── init.lua        # Plugin imports
        ├── lsp.lua         # LSP, lsp_lines, jinja syntax
        ├── snacks-nvim.lua # Picker, terminal, lazygit
        ├── tabby.lua       # Tab line with scope.nvim
        └── ...             # Other plugin configs
```
