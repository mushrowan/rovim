-- Eva-02 Colorscheme
-- Inspired by Evangelion Unit-02's red/orange/gold color palette
-- Features the iconic hazard stripe aesthetic with amber/gold accents
-- Supports both terminal and GUI (Neovide) with vivid colors

local M = {}

-- Eva-02 Palette
M.colors = {
	-- Backgrounds
	bg = "#0D0D0D",
	bg_dark = "#080808",
	bg_light = "#1A1A1A",
	bg_highlight = "#2A1A10", -- Warm tint
	bg_visual = "#3A2010",
	bg_stripe = "#1A1208", -- For hazard stripe effect

	-- Primary reds (Eva-02 armor)
	red = "#E02020",
	red_dark = "#B01818",
	red_light = "#FF3030",
	red_bright = "#FF4040",

	-- Secondary oranges (Eva-02 accents)
	orange = "#F47920",
	orange_dark = "#C06010",
	orange_light = "#FF9030",
	orange_bright = "#FFB040",

	-- Golds and ambers (hazard stripes, warning accents)
	gold = "#D4A000", -- Darker, richer gold
	gold_dark = "#B08000", -- Deep amber
	gold_light = "#E8B800",
	amber = "#CC7700", -- Bronze/amber
	amber_dark = "#995500",
	amber_light = "#E89000",
	bronze = "#A06020", -- Dark bronze accent
	yellow = "#E0A820", -- Warmer yellow

	-- Accent colors
	white = "#E8E8E8",
	white_bright = "#FFFFFF",
	cream = "#E8DCC8", -- Warm white

	-- Neutrals
	grey = "#808080",
	grey_dark = "#404040",
	grey_light = "#A0A0A0",
	grey_dim = "#606060",
	grey_warm = "#706050", -- Warm grey

	-- Syntax colors (balanced for readability)
	green = "#50C878",
	blue = "#5090C0",
	purple = "#A060C0",
	cyan = "#40B0B0",
	pink = "#E080A0",

	-- Diagnostics
	error = "#FF3030",
	warn = "#E8A020",
	info = "#5090C0",
	hint = "#50C878",
}

function M.setup()
	local c = M.colors

	-- Enable 24-bit color
	vim.opt.termguicolors = true
	vim.opt.background = "dark"

	-- Clear existing highlights
	vim.cmd("highlight clear")
	if vim.fn.exists("syntax_on") then
		vim.cmd("syntax reset")
	end

	vim.g.colors_name = "eva02"

	local highlights = {
		-- Editor UI
		Normal = { fg = c.white, bg = c.bg },
		NormalFloat = { fg = c.cream, bg = c.bg_dark },
		FloatBorder = { fg = c.gold, bg = c.bg_dark },
		FloatTitle = { fg = c.bg, bg = c.gold, bold = true },
		Cursor = { fg = c.bg, bg = c.red },
		CursorLine = { bg = c.bg_highlight },
		CursorLineNr = { fg = c.gold, bold = true },
		LineNr = { fg = c.grey_warm },
		SignColumn = { bg = c.bg },
		VertSplit = { fg = c.bronze },
		WinSeparator = { fg = c.bronze },
		StatusLine = { fg = c.cream, bg = c.bg_light },
		StatusLineNC = { fg = c.grey, bg = c.bg_dark },
		Pmenu = { fg = c.cream, bg = c.bg_dark },
		PmenuSel = { fg = c.bg, bg = c.gold },
		PmenuSbar = { bg = c.bg_light },
		PmenuThumb = { bg = c.amber },
		Visual = { bg = c.bg_visual },
		VisualNOS = { bg = c.bg_visual },
		Search = { fg = c.bg, bg = c.gold },
		IncSearch = { fg = c.bg, bg = c.amber_light },
		CurSearch = { fg = c.bg, bg = c.red },
		MatchParen = { fg = c.gold_light, bg = c.bg_highlight, bold = true },
		Folded = { fg = c.amber, bg = c.bg_stripe },
		FoldColumn = { fg = c.gold_dark },
		NonText = { fg = c.grey_warm },
		SpecialKey = { fg = c.bronze },
		Whitespace = { fg = c.grey_dark },
		EndOfBuffer = { fg = c.bg },
		Directory = { fg = c.gold },
		Title = { fg = c.gold, bold = true },
		Question = { fg = c.amber_light },
		MoreMsg = { fg = c.green },
		ModeMsg = { fg = c.cream, bold = true },
		ErrorMsg = { fg = c.error, bold = true },
		WarningMsg = { fg = c.warn },
		WildMenu = { fg = c.bg, bg = c.gold },

		-- TabLine - hazard stripe inspired
		TabLine = { fg = c.grey, bg = c.bg_stripe },
		TabLineFill = { bg = c.bg_dark },
		TabLineSel = { fg = c.bg, bg = c.gold, bold = true },

		-- Diff
		DiffAdd = { fg = c.green, bg = c.bg },
		DiffChange = { fg = c.amber, bg = c.bg },
		DiffDelete = { fg = c.red, bg = c.bg },
		DiffText = { fg = c.gold_light, bg = c.bg_highlight },

		-- Syntax - using more gold/amber
		Comment = { fg = c.grey_warm, italic = true },
		Constant = { fg = c.gold },
		String = { fg = c.green },
		Character = { fg = c.green },
		Number = { fg = c.amber_light },
		Boolean = { fg = c.gold, bold = true },
		Float = { fg = c.amber_light },
		Identifier = { fg = c.cream },
		Function = { fg = c.red_light },
		Statement = { fg = c.red },
		Conditional = { fg = c.red },
		Repeat = { fg = c.red },
		Label = { fg = c.gold },
		Operator = { fg = c.amber_light },
		Keyword = { fg = c.red, bold = true },
		Exception = { fg = c.red },
		PreProc = { fg = c.gold },
		Include = { fg = c.red },
		Define = { fg = c.amber },
		Macro = { fg = c.gold },
		PreCondit = { fg = c.amber },
		Type = { fg = c.gold },
		StorageClass = { fg = c.red },
		Structure = { fg = c.gold },
		Typedef = { fg = c.amber },
		Special = { fg = c.amber_light },
		SpecialChar = { fg = c.gold },
		Tag = { fg = c.red },
		Delimiter = { fg = c.grey_light },
		SpecialComment = { fg = c.amber, bold = true },
		Debug = { fg = c.red },
		Underlined = { fg = c.blue, underline = true },
		Ignore = { fg = c.grey_dark },
		Error = { fg = c.error, bold = true },
		Todo = { fg = c.bg, bg = c.gold, bold = true },

		-- Treesitter - gold/amber emphasis
		["@variable"] = { fg = c.cream },
		["@variable.builtin"] = { fg = c.gold },
		["@variable.parameter"] = { fg = c.cream, italic = true },
		["@variable.member"] = { fg = c.cream },
		["@constant"] = { fg = c.gold },
		["@constant.builtin"] = { fg = c.gold, bold = true },
		["@constant.macro"] = { fg = c.amber },
		["@module"] = { fg = c.gold },
		["@label"] = { fg = c.amber },
		["@string"] = { fg = c.green },
		["@string.escape"] = { fg = c.gold },
		["@string.special"] = { fg = c.amber },
		["@character"] = { fg = c.green },
		["@boolean"] = { fg = c.gold, bold = true },
		["@number"] = { fg = c.amber_light },
		["@float"] = { fg = c.amber_light },
		["@function"] = { fg = c.red_light },
		["@function.builtin"] = { fg = c.red },
		["@function.call"] = { fg = c.red_light },
		["@function.macro"] = { fg = c.gold },
		["@function.method"] = { fg = c.red_light },
		["@function.method.call"] = { fg = c.red_light },
		["@constructor"] = { fg = c.gold },
		["@operator"] = { fg = c.amber_light },
		["@keyword"] = { fg = c.red },
		["@keyword.function"] = { fg = c.red, bold = true },
		["@keyword.operator"] = { fg = c.red },
		["@keyword.return"] = { fg = c.red, bold = true },
		["@keyword.import"] = { fg = c.red },
		["@keyword.conditional"] = { fg = c.red },
		["@keyword.repeat"] = { fg = c.red },
		["@keyword.exception"] = { fg = c.red },
		["@type"] = { fg = c.gold },
		["@type.builtin"] = { fg = c.gold },
		["@type.definition"] = { fg = c.gold },
		["@type.qualifier"] = { fg = c.red },
		["@attribute"] = { fg = c.amber },
		["@property"] = { fg = c.cream },
		["@punctuation.delimiter"] = { fg = c.grey_light },
		["@punctuation.bracket"] = { fg = c.amber_dark },
		["@punctuation.special"] = { fg = c.red },
		["@comment"] = { fg = c.grey_warm, italic = true },
		["@comment.todo"] = { fg = c.bg, bg = c.gold, bold = true },
		["@comment.warning"] = { fg = c.bg, bg = c.amber, bold = true },
		["@comment.error"] = { fg = c.bg, bg = c.error, bold = true },
		["@comment.note"] = { fg = c.bg, bg = c.info, bold = true },
		["@tag"] = { fg = c.red },
		["@tag.attribute"] = { fg = c.gold },
		["@tag.delimiter"] = { fg = c.grey_light },

		-- LSP Semantic Tokens
		["@lsp.type.class"] = { fg = c.gold },
		["@lsp.type.decorator"] = { fg = c.amber },
		["@lsp.type.enum"] = { fg = c.gold },
		["@lsp.type.enumMember"] = { fg = c.amber_light },
		["@lsp.type.function"] = { fg = c.red_light },
		["@lsp.type.interface"] = { fg = c.gold },
		["@lsp.type.macro"] = { fg = c.amber },
		["@lsp.type.method"] = { fg = c.red_light },
		["@lsp.type.namespace"] = { fg = c.gold },
		["@lsp.type.parameter"] = { fg = c.cream, italic = true },
		["@lsp.type.property"] = { fg = c.cream },
		["@lsp.type.struct"] = { fg = c.gold },
		["@lsp.type.type"] = { fg = c.gold },
		["@lsp.type.typeParameter"] = { fg = c.amber },
		["@lsp.type.variable"] = { fg = c.cream },

		-- Diagnostics - amber warning tones
		DiagnosticError = { fg = c.error },
		DiagnosticWarn = { fg = c.warn },
		DiagnosticInfo = { fg = c.info },
		DiagnosticHint = { fg = c.hint },
		DiagnosticUnderlineError = { sp = c.error, undercurl = true },
		DiagnosticUnderlineWarn = { sp = c.warn, undercurl = true },
		DiagnosticUnderlineInfo = { sp = c.info, undercurl = true },
		DiagnosticUnderlineHint = { sp = c.hint, undercurl = true },
		DiagnosticVirtualTextError = { fg = c.error, bg = c.bg_stripe },
		DiagnosticVirtualTextWarn = { fg = c.warn, bg = c.bg_stripe },
		DiagnosticVirtualTextInfo = { fg = c.info, bg = c.bg_stripe },
		DiagnosticVirtualTextHint = { fg = c.hint, bg = c.bg_stripe },
		DiagnosticFloatingError = { fg = c.error },
		DiagnosticFloatingWarn = { fg = c.warn },
		DiagnosticFloatingInfo = { fg = c.info },
		DiagnosticFloatingHint = { fg = c.hint },
		DiagnosticSignError = { fg = c.error },
		DiagnosticSignWarn = { fg = c.warn },
		DiagnosticSignInfo = { fg = c.info },
		DiagnosticSignHint = { fg = c.hint },

		-- Git Signs
		GitSignsAdd = { fg = c.green },
		GitSignsChange = { fg = c.amber },
		GitSignsDelete = { fg = c.red },

		-- Telescope/Picker - gold accents
		TelescopeNormal = { fg = c.cream, bg = c.bg_dark },
		TelescopeBorder = { fg = c.gold_dark, bg = c.bg_dark },
		TelescopePromptNormal = { fg = c.cream, bg = c.bg_light },
		TelescopePromptBorder = { fg = c.gold, bg = c.bg_light },
		TelescopePromptTitle = { fg = c.bg, bg = c.gold, bold = true },
		TelescopePreviewTitle = { fg = c.bg, bg = c.red, bold = true },
		TelescopeResultsTitle = { fg = c.bg, bg = c.amber, bold = true },
		TelescopeSelection = { fg = c.cream, bg = c.bg_highlight },
		TelescopeSelectionCaret = { fg = c.gold },
		TelescopeMatching = { fg = c.gold_light, bold = true },

		-- Snacks Picker
		SnacksPickerNormal = { fg = c.cream, bg = c.bg_dark },
		SnacksPickerBorder = { fg = c.gold_dark, bg = c.bg_dark },
		SnacksPickerTitle = { fg = c.bg, bg = c.gold, bold = true },
		SnacksPickerMatch = { fg = c.gold_light, bold = true },
		SnacksPickerSelection = { fg = c.cream, bg = c.bg_highlight },

		-- Which Key - hazard stripe feel
		WhichKey = { fg = c.gold },
		WhichKeyGroup = { fg = c.red },
		WhichKeyDesc = { fg = c.cream },
		WhichKeySeparator = { fg = c.bronze },
		WhichKeyFloat = { bg = c.bg_dark },
		WhichKeyBorder = { fg = c.gold_dark },
		WhichKeyValue = { fg = c.amber },

		-- Indent guides - subtle stripe pattern
		IndentBlanklineChar = { fg = c.grey_dark },
		IblIndent = { fg = c.bg_stripe },
		IblScope = { fg = c.gold_dark },

		-- Bufferline - hazard stripe aesthetic
		BufferLineFill = { bg = c.bg_dark },
		BufferLineBackground = { fg = c.grey, bg = c.bg_stripe },
		BufferLineBuffer = { fg = c.grey, bg = c.bg_stripe },
		BufferLineBufferSelected = { fg = c.cream, bg = c.bg, bold = true },
		BufferLineBufferVisible = { fg = c.grey_light, bg = c.bg_light },
		BufferLineTab = { fg = c.amber_dark, bg = c.bg_stripe },
		BufferLineTabSelected = { fg = c.bg, bg = c.gold, bold = true },
		BufferLineTabClose = { fg = c.red, bg = c.bg_stripe },
		BufferLineIndicatorSelected = { fg = c.gold, bg = c.bg },
		BufferLineSeparator = { fg = c.bronze, bg = c.bg_stripe },
		BufferLineModified = { fg = c.amber },
		BufferLineModifiedSelected = { fg = c.gold },
		BufferLineDiagnosticError = { fg = c.error },
		BufferLineDiagnosticWarning = { fg = c.warn },

		-- Notify - warning stripe colors
		NotifyERRORBorder = { fg = c.error },
		NotifyWARNBorder = { fg = c.amber },
		NotifyINFOBorder = { fg = c.gold_dark },
		NotifyDEBUGBorder = { fg = c.grey },
		NotifyTRACEBorder = { fg = c.purple },
		NotifyERRORIcon = { fg = c.error },
		NotifyWARNIcon = { fg = c.amber },
		NotifyINFOIcon = { fg = c.gold },
		NotifyDEBUGIcon = { fg = c.grey },
		NotifyTRACEIcon = { fg = c.purple },
		NotifyERRORTitle = { fg = c.error },
		NotifyWARNTitle = { fg = c.amber },
		NotifyINFOTitle = { fg = c.gold },
		NotifyDEBUGTitle = { fg = c.grey },
		NotifyTRACETitle = { fg = c.purple },

		-- Noice
		NoiceCmdlinePopupBorder = { fg = c.gold_dark },
		NoiceCmdlinePopupTitle = { fg = c.gold },
		NoiceCmdlineIcon = { fg = c.gold },

		-- Flash - high visibility
		FlashLabel = { fg = c.bg, bg = c.gold, bold = true },
		FlashBackdrop = { fg = c.grey_dark },
		FlashMatch = { fg = c.amber_light },
		FlashCurrent = { fg = c.gold_light },

		-- Oil
		OilDir = { fg = c.gold },
		OilFile = { fg = c.cream },
		OilLink = { fg = c.blue },
		OilLinkTarget = { fg = c.grey },

		-- Markdown - gold heading hierarchy
		["@markup.heading.1.markdown"] = { fg = c.red, bold = true },
		["@markup.heading.2.markdown"] = { fg = c.gold, bold = true },
		["@markup.heading.3.markdown"] = { fg = c.amber, bold = true },
		["@markup.heading.4.markdown"] = { fg = c.amber_light, bold = true },
		["@markup.heading.5.markdown"] = { fg = c.cream, bold = true },
		["@markup.heading.6.markdown"] = { fg = c.grey_light, bold = true },
		["@markup.strong"] = { bold = true },
		["@markup.italic"] = { italic = true },
		["@markup.link"] = { fg = c.blue },
		["@markup.link.url"] = { fg = c.blue, underline = true },
		["@markup.raw"] = { fg = c.green },
		["@markup.list"] = { fg = c.gold },

		-- Obsidian
		ObsidianTodo = { fg = c.gold, bold = true },
		ObsidianDone = { fg = c.green },
		ObsidianBullet = { fg = c.amber },
		ObsidianRefText = { fg = c.blue, underline = true },
		ObsidianTag = { fg = c.gold, italic = true },
		ObsidianHighlightText = { bg = c.bg_visual },

		-- Avante / AI
		AvanteTitle = { fg = c.bg, bg = c.gold, bold = true },
		AvanteBorder = { fg = c.gold_dark },

		-- Neovide-specific (GUI extras)
		-- These will render better in Neovide with full color support
		CursorIM = { fg = c.bg, bg = c.gold },
		lCursor = { fg = c.bg, bg = c.amber },
	}

	-- Apply highlights
	for group, settings in pairs(highlights) do
		vim.api.nvim_set_hl(0, group, settings)
	end

	-- Neovide-specific settings for vivid colors
	if vim.g.neovide then
		vim.g.neovide_cursor_vfx_mode = "railgun"
		vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
		vim.g.neovide_cursor_vfx_particle_density = 7.0
		vim.g.neovide_cursor_vfx_particle_speed = 10.0
		-- Eva-02 orange/gold particles
		vim.g.neovide_cursor_vfx_particle_curl = 1.0
	end
end

-- Lualine theme - hazard stripe inspired
M.lualine = {
	normal = {
		a = { fg = "#0D0D0D", bg = "#D4A000", gui = "bold" }, -- Gold
		b = { fg = "#E8DCC8", bg = "#2A1A10" },
		c = { fg = "#706050", bg = "#1A1A1A" },
	},
	insert = {
		a = { fg = "#0D0D0D", bg = "#E02020", gui = "bold" }, -- Red
	},
	visual = {
		a = { fg = "#0D0D0D", bg = "#CC7700", gui = "bold" }, -- Amber
	},
	replace = {
		a = { fg = "#0D0D0D", bg = "#FF3030", gui = "bold" }, -- Bright red
	},
	command = {
		a = { fg = "#0D0D0D", bg = "#E89000", gui = "bold" }, -- Orange
	},
	inactive = {
		a = { fg = "#706050", bg = "#1A1208" },
		b = { fg = "#706050", bg = "#1A1208" },
		c = { fg = "#606060", bg = "#0D0D0D" },
	},
}

return M
