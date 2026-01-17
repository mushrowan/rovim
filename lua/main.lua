require("nixCatsUtils").setup({
	non_nix_value = true,
})

require("lze").register_handlers(require("nixCatsUtils.lzUtils").for_cat)
require("lze").register_handlers(require("lzextras").lsp)

require("partials.settings")
require("partials.neovide")
require("partials.mappings")
require("partials.abbreviations")

require("partials.plugins")

