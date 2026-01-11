# Rovim Refactoring Progress Log

## Phase 1-7: Initial Refactor (2026-01-10)

**Bug fixes:** colorscheme, lspkeys, ws, obsidian, lsp, treesitter plugin specs
**Removed:** harpoon, textobjects, dead code
**Standardized:** plugin patterns with `for_cat`, section headers, table-driven LSP
**Reorganized:** flake.nix into functional categories (editor, ui, lsp, completion, git, testing, notes, format, ai, remote)
**Deduplicated:** Nix modules via shared.nix (106 → 79 lines)

## Phase 8: Eva-02 Theme & UX Improvements (2026-01-11)

### Treesitter Fix
- Updated to modern nvim-treesitter API (removed deprecated `configs.setup()`)

### Project Picker Session Management
- `<leader>sp` now saves current session before switching projects
- Added `on_require = "persistence"` trigger for auto-loading

### Eva-02 Colorscheme (`lua/partials/eva02.lua`)
- Custom colorscheme inspired by Evangelion Unit-02
- Red/gold/amber palette with hazard stripe aesthetic
- Full highlight coverage: syntax, LSP, diagnostics, Treesitter, UI plugins
- Neovide-specific cursor effects (railgun particles)
- Lualine theme: gold (normal), red (insert), amber (visual)

### UI Enhancements
- **Lualine:** Eva-02 theme, hostname in ALL CAPS (right section), diagnostics
- **Tabby:** Devicons per tab, 3-char directory abbreviation, Eva-02 colors
- **Bufferline:** Removed duplicate tab indicators (handled by tabby)

### Nix Package Structure
```
nix run .           # Neovide + baked config (default)
nix run .#nvim      # Terminal nvim + baked config
nix run .#dev       # Neovide + local config (live reload on restart)
nix run .#nvim-dev  # Terminal nvim + local config
nix develop         # Shell with nvim-dev
```

### Documentation
- Created `docs/lze.md` - lazy loading trigger reference

## Files Changed (Phase 8)
- `lua/partials/eva02.lua` (new)
- `lua/partials/plugins/colorscheme.lua`
- `lua/partials/plugins/treesitter.lua`
- `lua/partials/plugins/lualine.lua`
- `lua/partials/plugins/tabby.lua`
- `lua/partials/plugins/bufferline.lua`
- `lua/partials/plugins/snacks-nvim.lua`
- `lua/partials/plugins/persistence.lua`
- `flake.nix` (dev packages, neovide wrapper)
- `docs/lze.md` (new)
