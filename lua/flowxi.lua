local M = {}
local config = require("flowxi.config")

local function set_highlights()
	local utilities = require("flowxi.utilities")
	local palette = require("flowxi.palette")
	local styles = config.options.styles

	local groups = {}
	for group, color in pairs(config.options.groups) do
		groups[group] = utilities.parse_color(color)
	end

	local function make_border(fg)
		fg = fg or groups.border
		return {
			fg = fg,
			bg = (config.options.extend_background_behind_borders and not styles.transparency) and palette.surface
				or "NONE",
		}
	end

	local highlights = {}
	local legacy_highlights = {
		["@attribute.diff"] = { fg = palette.orange_two },
		["@boolean"] = { link = "Boolean" },
		["@class"] = { fg = palette.text },
		["@conditional"] = { link = "Conditional" },
		["@field"] = { fg = palette.text },
		["@include"] = { link = "Include" },
		["@interface"] = { fg = palette.text },
		["@macro"] = { link = "Macro" },
		["@method"] = { fg = palette.text },
		["@namespace"] = { link = "Include" },
		["@number"] = { link = "Number" },
		["@parameter"] = { fg = palette.text },
		["@preproc"] = { link = "PreProc" },
		["@punctuation"] = { fg = palette.text },
		["@punctuation.bracket"] = { link = "@punctuation" },
		["@punctuation.delimiter"] = { link = "@punctuation" },
		["@punctuation.special"] = { link = "@punctuation" },
		["@regexp"] = { link = "String" },
		["@repeat"] = { link = "Repeat" },
		["@storageclass"] = { link = "StorageClass" },
		["@symbol"] = { link = "Identifier" },
		["@text"] = { fg = palette.text },
		["@text.danger"] = { fg = groups.error },
		["@text.diff.add"] = { fg = groups.git_add, bg = groups.git_add, blend = 20 },
		["@text.diff.delete"] = { fg = groups.git_delete, bg = groups.git_delete, blend = 20 },
		["@text.emphasis"] = { italic = true },
		["@text.environment"] = { link = "Macro" },
		["@text.environment.name"] = { link = "Type" },
		["@text.math"] = { link = "Special" },
		["@text.note"] = { fg = palette.blue_two },
		["@text.strike"] = { strikethrough = true },
		["@text.strong"] = { bold = true },
		["@text.title"] = { link = "Title" },
		["@text.title.1.markdown"] = { fg = palette.text, bold = true },
		["@text.title.1.marker.markdown"] = { fg = palette.text },
		["@text.title.2.markdown"] = { fg = palette.text, bold = true },
		["@text.title.2.marker.markdown"] = { fg = palette.text },
		["@text.title.3.markdown"] = { fg = palette.text, bold = true },
		["@text.title.3.marker.markdown"] = { fg = palette.text },
		["@text.title.4.markdown"] = { fg = palette.text },
		["@text.title.4.marker.markdown"] = { fg = palette.text },
		["@text.title.5.markdown"] = { fg = palette.text },
		["@text.title.5.marker.markdown"] = { fg = palette.text },
		["@text.title.6.markdown"] = { fg = palette.text },
		["@text.title.6.marker.markdown"] = { fg = palette.text },
		["@text.underline"] = { underline = true },
		["@text.uri"] = { fg = groups.link },
		["@text.warning"] = { fg = groups.warn },
		["@todo"] = { fg = palette.yellow_two },

		-- lukas-reineke/indent-blankline.nvim
		IndentBlanklineChar = { fg = palette.muted, nocombine = true },
		IndentBlanklineSpaceChar = { fg = palette.muted, nocombine = true },
		IndentBlanklineSpaceCharBlankline = { fg = palette.muted, nocombine = true },
	}
	local default_highlights = {
		ColorColumn = { bg = palette.overlay },
		Conceal = { bg = "NONE" },
		CurSearch = { fg = palette.base, bg = palette.yellow_one },
		Cursor = { fg = palette.text, bg = palette.highlight_high },
		CursorColumn = { bg = palette.overlay },
		-- CursorIM = {},
		CursorLine = { bg = palette.overlay },
		CursorLineNr = { fg = palette.text },
		-- DarkenedPanel = { },
		-- DarkenedStatusline = {},
		DiffAdd = { bg = groups.git_add, blend = 20 },
		DiffChange = { bg = groups.git_change, blend = 20 },
		DiffDelete = { bg = groups.git_delete, blend = 20 },
		DiffText = { bg = groups.git_text, blend = 20 },
		diffAdded = { link = "DiffAdd" },
		diffChanged = { link = "DiffChange" },
		diffRemoved = { link = "DiffDelete" },
		Directory = { fg = palette.text },

		-- EndOfBuffer = {},
		ErrorMsg = { fg = groups.error },
		FloatBorder = make_border(),
		FloatTitle = { fg = palette.text, bg = groups.panel },
		FoldColumn = { fg = palette.muted },
		Folded = { fg = palette.text, bg = palette.overlay },
		IncSearch = { link = "CurSearch" },
		LineNr = { fg = palette.muted },
		MatchParen = { fg = palette.text, bg = palette.blue_one, blend = 20 },
		ModeMsg = { fg = palette.subtle },
		MoreMsg = { fg = palette.text },
		NonText = { fg = palette.muted },
		Normal = { fg = palette.text, bg = palette.base },
		NormalFloat = { bg = groups.panel },
		NormalNC = { fg = palette.text, bg = config.options.dim_inactive_windows and palette._nc or palette.base },
		NvimInternalError = { link = "ErrorMsg" },
		Pmenu = { fg = palette.subtle, bg = groups.panel },
		PmenuExtra = { fg = palette.muted, bg = groups.panel },
		PmenuExtraSel = { fg = palette.subtle, bg = palette.overlay },
		PmenuKind = { fg = palette.text, bg = groups.panel },
		PmenuKindSel = { fg = palette.subtle, bg = palette.overlay },
		PmenuSbar = { bg = groups.panel },
		PmenuSel = { fg = palette.text, bg = palette.overlay },
		PmenuThumb = { bg = palette.muted },
		Question = { fg = palette.text },
		-- QuickFixLink = {},
		-- RedrawDebugNormal = {},
		RedrawDebugClear = { fg = palette.base, bg = palette.orange_two },
		RedrawDebugComposed = { fg = palette.base, bg = palette.blue_two },
		RedrawDebugRecompose = { fg = palette.base, bg = palette.red_two },
		Search = { fg = palette.text, bg = palette.yellow_one, blend = 20 },
		SignColumn = { fg = palette.text, bg = "NONE" },
		SpecialKey = { fg = palette.text },
		SpellBad = { sp = palette.subtle, undercurl = true },
		SpellCap = { sp = palette.subtle, undercurl = true },
		SpellLocal = { sp = palette.subtle, undercurl = true },
		SpellRare = { sp = palette.subtle, undercurl = true },
		StatusLine = { fg = palette.subtle, bg = groups.panel },
		StatusLineNC = { fg = palette.muted, bg = groups.panel, blend = 60 },
		StatusLineTerm = { fg = palette.base, bg = palette.blue_two },
		StatusLineTermNC = { fg = palette.base, bg = palette.blue_two, blend = 60 },
		Substitute = { link = "IncSearch" },
		TabLine = { fg = palette.subtle, bg = palette.overlay },
		TabLineFill = { bg = "NONE" },
		TabLineSel = { fg = palette.text, bg = palette.highlight_low },
		Title = { fg = palette.text, bold = true },
		VertSplit = { fg = groups.border },
		Visual = { bg = palette.highlight_med },

		-- VisualNOS = {},
		WarningMsg = { fg = groups.warn },

		-- Whitespace = {},
		WildMenu = { link = "IncSearch" },
		WinBar = { fg = palette.subtle, bg = groups.panel },
		WinBarNC = { fg = palette.muted, bg = groups.panel, blend = 60 },
		WinSeparator = { fg = groups.border },
		DiagnosticError = { fg = groups.error },
		DiagnosticHint = { fg = groups.hint },
		DiagnosticInfo = { fg = groups.info },
		DiagnosticOk = { fg = groups.ok },
		DiagnosticWarn = { fg = groups.warn },
		DiagnosticDefaultError = { link = "DiagnosticError" },
		DiagnosticDefaultHint = { link = "DiagnosticHint" },
		DiagnosticDefaultInfo = { link = "DiagnosticInfo" },
		DiagnosticDefaultOk = { link = "DiagnosticOk" },
		DiagnosticDefaultWarn = { link = "DiagnosticWarn" },
		DiagnosticFloatingError = { link = "DiagnosticError" },
		DiagnosticFloatingHint = { link = "DiagnosticHint" },
		DiagnosticFloatingInfo = { link = "DiagnosticInfo" },
		DiagnosticFloatingOk = { link = "DiagnosticOk" },
		DiagnosticFloatingWarn = { link = "DiagnosticWarn" },
		DiagnosticSignError = { link = "DiagnosticError" },
		DiagnosticSignHint = { link = "DiagnosticHint" },
		DiagnosticSignInfo = { link = "DiagnosticInfo" },
		DiagnosticSignOk = { link = "DiagnosticOk" },
		DiagnosticSignWarn = { link = "DiagnosticWarn" },
		DiagnosticUnderlineError = { sp = groups.error, undercurl = true },
		DiagnosticUnderlineHint = { sp = groups.hint, undercurl = true },
		DiagnosticUnderlineInfo = { sp = groups.info, undercurl = true },
		DiagnosticUnderlineOk = { sp = groups.ok, undercurl = true },
		DiagnosticUnderlineWarn = { sp = groups.warn, undercurl = true },
		DiagnosticVirtualTextError = { fg = groups.error, bg = groups.error, blend = 10 },
		DiagnosticVirtualTextHint = { fg = groups.hint, bg = groups.hint, blend = 10 },
		DiagnosticVirtualTextInfo = { fg = groups.info, bg = groups.info, blend = 10 },
		DiagnosticVirtualTextOk = { fg = groups.ok, bg = groups.ok, blend = 10 },
		DiagnosticVirtualTextWarn = { fg = groups.warn, bg = groups.warn, blend = 10 },
		Boolean = { fg = palette.text },
		Character = { fg = palette.cyan_two },
		Comment = { fg = palette.subtle, italic = true },
		Conditional = { fg = palette.text },
		Constant = { fg = palette.text },
		Debug = { fg = palette.text },
		Define = { fg = palette.text },
		Delimiter = { fg = palette.text },
		Error = { fg = palette.red_two },
		Exception = { fg = palette.text },
		Float = { fg = palette.text },
		Function = { fg = palette.text },
		Identifier = { fg = palette.text },
		Include = { fg = palette.text },
		Keyword = { fg = palette.text },
		Label = { fg = palette.text },
		LspCodeLens = { fg = palette.subtle },
		LspCodeLensSeparator = { fg = palette.muted },
		LspInlayHint = { fg = palette.muted, bg = palette.muted, blend = 10 },
		LspReferenceRead = { bg = palette.highlight_med },
		LspReferenceText = { bg = palette.highlight_med },
		LspReferenceWrite = { bg = palette.highlight_med },
		Macro = { fg = palette.text },
		Number = { fg = palette.text },
		Operator = { fg = palette.text },
		PreCondit = { fg = palette.text },
		PreProc = { link = "PreCondit" },
		Repeat = { fg = palette.text },
		Special = { fg = palette.text },
		SpecialChar = { link = "Special" },
		SpecialComment = { fg = palette.purple_two },
		Statement = { fg = palette.text },
		StorageClass = { fg = palette.text },
		String = { fg = palette.cyan_two },
		Structure = { fg = palette.text },
		Tag = { fg = palette.text },
		Todo = { link = "@comment.todo" },
		Type = { fg = palette.text },
		TypeDef = { link = "Type" },
		Underlined = { fg = palette.text, underline = true },
		healthError = { fg = groups.error },
		healthSuccess = { fg = groups.info },
		healthWarning = { fg = groups.warn },
		htmlArg = { fg = palette.text },
		htmlBold = { bold = true },
		htmlEndTag = { fg = palette.text },
		htmlH1 = { link = "markdownH1" },
		htmlH2 = { link = "markdownH2" },
		htmlH3 = { link = "markdownH3" },
		htmlH4 = { link = "markdownH4" },
		htmlH5 = { link = "markdownH5" },
		htmlItalic = { italic = true },
		htmlLink = { link = "markdownUrl" },
		htmlTag = { fg = palette.text },
		htmlTagN = { fg = palette.text },
		htmlTagName = { fg = palette.text },
		markdownDelimiter = { fg = palette.text },
		markdownH1 = { fg = palette.text, bold = true },
		markdownH1Delimiter = { link = "markdownH1" },
		markdownH2 = { fg = palette.text, bold = true },
		markdownH2Delimiter = { link = "markdownH2" },
		markdownH3 = { fg = palette.text, bold = true },
		markdownH3Delimiter = { link = "markdownH3" },
		markdownH4 = { fg = palette.text, bold = true },
		markdownH4Delimiter = { link = "markdownH4" },
		markdownH5 = { fg = palette.text, bold = true },
		markdownH5Delimiter = { link = "markdownH5" },
		markdownH6 = { fg = palette.text, bold = true },
		markdownH6Delimiter = { link = "markdownH6" },
		markdownLinkText = { link = "markdownUrl" },
		markdownUrl = { fg = groups.link, sp = groups.link, underline = true },
		mkdCode = { fg = palette.cyan_two, italic = true },
		mkdCodeDelimiter = { fg = palette.text },
		mkdCodeEnd = { fg = palette.cyan_two },
		mkdCodeStart = { fg = palette.cyan_two },
		mkdFootnotes = { fg = palette.text },
		mkdID = { fg = palette.text, underline = true },
		mkdInlineURL = { link = "markdownUrl" },
		mkdLink = { link = "markdownUrl" },
		mkdLinkDef = { link = "markdownUrl" },
		mkdListItemLine = { fg = palette.text },
		mkdRule = { fg = palette.text },
		mkdURL = { link = "markdownUrl" },

		--- Identifiers
		["@variable"] = { fg = palette.text },
		["@variable.builtin"] = { fg = palette.text },
		["@variable.parameter"] = { fg = palette.text },
		["@variable.member"] = { fg = palette.text },
		["@constant"] = { fg = palette.text },
		["@constant.builtin"] = { fg = palette.text },
		["@constant.macro"] = { fg = palette.text },
		["@module"] = { fg = palette.text },
		["@module.builtin"] = { fg = palette.text },
		["@label"] = { link = "Label" },

		--- Literals
		["@string"] = { link = "String" },
		["@string.regexp"] = { fg = palette.cyan_two },
		["@string.escape"] = { fg = palette.text },
		["@string.special"] = { link = "String" },
		["@string.special.symbol"] = { link = "Identifier" },
		["@string.special.url"] = { fg = groups.link },
		["@character"] = { link = "Character" },
		["@character.special"] = { link = "Character" },
		["@boolean"] = { link = "Boolean" },
		["@number"] = { link = "Number" },
		["@number.float"] = { link = "Number" },
		["@float"] = { link = "Number" },

		--- Types
		["@type"] = { fg = palette.text },
		["@type.builtin"] = { fg = palette.text },
		-- ["@type.definition"] = {},
		-- ["@type.qualifier"] = {},

		-- ["@attribute"] = {},
		["@property"] = { fg = palette.text },

		--- Functions
		["@function"] = { fg = palette.text },
		["@function.builtin"] = { fg = palette.text },
		-- ["@function.call"] = {},
		["@function.macro"] = { link = "Function" },
		["@function.method"] = { fg = palette.text },
		["@function.method.call"] = { fg = palette.text },

		["@constructor"] = { fg = palette.text },
		["@operator"] = { link = "Operator" },

		--- Keywords
		["@keyword"] = { link = "Keyword" },
		-- ["@keyword.coroutine"] = {},
		-- ["@keyword.function"] = {},
		["@keyword.operator"] = { fg = palette.text },
		["@keyword.import"] = { fg = palette.text },
		["@keyword.storage"] = { fg = palette.text },
		["@keyword.repeat"] = { fg = palette.text },
		["@keyword.return"] = { fg = palette.text },
		["@keyword.debug"] = { fg = palette.text },
		["@keyword.exception"] = { fg = palette.text },
		["@keyword.conditional"] = { fg = palette.text },
		["@keyword.conditional.ternary"] = { fg = palette.text },
		["@keyword.directive"] = { fg = palette.text },
		["@keyword.directive.define"] = { fg = palette.text },

		--- Punctuation
		["@punctuation.delimiter"] = { fg = palette.text },
		["@punctuation.bracket"] = { fg = palette.text },
		["@punctuation.special"] = { fg = palette.text },

		--- Comments
		["@comment"] = { link = "Comment" },
		-- ["@comment.documentation"] = {},

		["@comment.error"] = { fg = groups.error },
		["@comment.warning"] = { fg = groups.warn },
		["@comment.todo"] = { fg = groups.todo, bg = groups.todo, blend = 20 },
		["@comment.hint"] = { fg = groups.hint, bg = groups.hint, blend = 20 },
		["@comment.info"] = { fg = groups.info, bg = groups.info, blend = 20 },
		["@comment.note"] = { fg = groups.note, bg = groups.note, blend = 20 },

		--- Markup
		["@markup.strong"] = { bold = true },
		["@markup.italic"] = { italic = true },
		["@markup.strikethrough"] = { strikethrough = true },
		["@markup.underline"] = { underline = true },

		["@markup.heading"] = { fg = palette.text, bold = true },

		["@markup.quote"] = { fg = palette.text },
		["@markup.math"] = { link = "Special" },
		["@markup.environment"] = { link = "Macro" },
		["@markup.environment.name"] = { link = "@type" },

		-- ["@markup.link"] = {},
		["@markup.link.markdown_inline"] = { fg = palette.text },
		["@markup.link.label.markdown_inline"] = { fg = palette.text },
		["@markup.link.url"] = { fg = groups.link },

		-- ["@markup.raw"] = { bg = palette.surface },
		-- ["@markup.raw.block"] = { bg = palette.surface },
		["@markup.raw.delimiter.markdown"] = { fg = palette.text },

		["@markup.list"] = { fg = palette.text },
		["@markup.list.checked"] = { fg = palette.text, bg = palette.text, blend = 10 },
		["@markup.list.unchecked"] = { fg = palette.text },

		-- Markdown headings
		["@markup.heading.1.markdown"] = { link = "markdownH1" },
		["@markup.heading.2.markdown"] = { link = "markdownH2" },
		["@markup.heading.3.markdown"] = { link = "markdownH3" },
		["@markup.heading.4.markdown"] = { link = "markdownH4" },
		["@markup.heading.5.markdown"] = { link = "markdownH5" },
		["@markup.heading.6.markdown"] = { link = "markdownH6" },
		["@markup.heading.1.marker.markdown"] = { link = "markdownH1Delimiter" },
		["@markup.heading.2.marker.markdown"] = { link = "markdownH2Delimiter" },
		["@markup.heading.3.marker.markdown"] = { link = "markdownH3Delimiter" },
		["@markup.heading.4.marker.markdown"] = { link = "markdownH4Delimiter" },
		["@markup.heading.5.marker.markdown"] = { link = "markdownH5Delimiter" },
		["@markup.heading.6.marker.markdown"] = { link = "markdownH6Delimiter" },

		["@diff.plus"] = { fg = groups.git_add, bg = groups.git_add, blend = 20 },
		["@diff.minus"] = { fg = groups.git_delete, bg = groups.git_delete, blend = 20 },
		["@diff.delta"] = { bg = groups.git_change, blend = 20 },

		["@tag"] = { link = "Tag" },
		["@tag.attribute"] = { fg = palette.text },
		["@tag.delimiter"] = { fg = palette.text },

		--- Non-highlighting captures
		-- ["@none"] = {},
		["@conceal"] = { link = "Conceal" },
		["@conceal.markdown"] = { fg = palette.text },

		-- ["@spell"] = {},
		-- ["@nospell"] = {},

		--- Semantic
		["@lsp.type.comment"] = {},
		["@lsp.type.comment.c"] = { link = "@comment" },
		["@lsp.type.comment.cpp"] = { link = "@comment" },
		["@lsp.type.enum"] = { link = "@type" },
		["@lsp.type.interface"] = { link = "@interface" },
		["@lsp.type.keyword"] = { link = "@keyword" },
		["@lsp.type.namespace"] = { link = "@namespace" },
		["@lsp.type.namespace.python"] = { link = "@variable" },
		["@lsp.type.parameter"] = { link = "@parameter" },
		["@lsp.type.property"] = { link = "@property" },
		["@lsp.type.variable"] = {}, -- defer to treesitter for regular variables
		["@lsp.type.variable.svelte"] = { link = "@variable" },
		["@lsp.typemod.function.defaultLibrary"] = { link = "@function.builtin" },
		["@lsp.typemod.operator.injected"] = { link = "@operator" },
		["@lsp.typemod.string.injected"] = { link = "@string" },
		["@lsp.typemod.variable.constant"] = { link = "@constant" },
		["@lsp.typemod.variable.defaultLibrary"] = { link = "@variable.builtin" },
		["@lsp.typemod.variable.injected"] = { link = "@variable" },

		--- Plugins
		-- romgrk/barbar.nvim
		BufferCurrent = { fg = palette.text, bg = palette.overlay },
		BufferCurrentIndex = { fg = palette.text, bg = palette.overlay },
		BufferCurrentMod = { fg = palette.cyan_two, bg = palette.overlay },
		BufferCurrentSign = { fg = palette.text, bg = palette.overlay },
		BufferCurrentTarget = { fg = palette.text, bg = palette.overlay },
		BufferInactive = { fg = palette.text },
		BufferInactiveIndex = { fg = palette.text },
		BufferInactiveMod = { fg = palette.cyan_two },
		BufferInactiveSign = { fg = palette.muted },
		BufferInactiveTarget = { fg = palette.text },
		BufferTabpageFill = { fg = "NONE", bg = "NONE" },
		BufferVisible = { fg = palette.text },
		BufferVisibleIndex = { fg = palette.text },
		BufferVisibleMod = { fg = palette.cyan_two },
		BufferVisibleSign = { fg = palette.muted },
		BufferVisibleTarget = { fg = palette.text },

		-- lewis6991/gitsigns.nvim
		GitSignsAdd = { link = "SignAdd" },
		GitSignsChange = { link = "SignChange" },
		GitSignsDelete = { link = "SignDelete" },
		GitSignsAddInline = { fg = groups.git_add },
		GitSignsChangeInline = { fg = groups.git_change },
		GitSignsDeleteInline = { fg = groups.git_delete },
		SignAdd = { fg = groups.git_add, bg = "NONE" },
		SignChange = { fg = groups.git_change, bg = "NONE" },
		SignDelete = { fg = groups.git_delete, bg = "NONE" },

		-- mvllow/modes.nvim
		ModesCopy = { bg = palette.orange_two },
		ModesDelete = { bg = palette.red_two },
		ModesInsert = { bg = palette.cyan_two },
		ModesReplace = { bg = palette.blue_two },
		ModesVisual = { bg = palette.purple_two },

		-- kyazdani42/nvim-tree.lua
		NvimTreeEmptyFolderName = { fg = palette.muted },
		NvimTreeFileDeleted = { fg = groups.git_delete },
		NvimTreeFileDirty = { fg = groups.git_dirty },
		NvimTreeFileMerge = { fg = groups.git_merge },
		NvimTreeFileNew = { fg = palette.text },
		NvimTreeFileRenamed = { fg = groups.git_rename },
		NvimTreeFileStaged = { fg = groups.git_stage },
		NvimTreeFolderIcon = { fg = palette.text },
		NvimTreeFolderName = { fg = palette.text },
		NvimTreeGitDeleted = { fg = groups.git_delete },
		NvimTreeGitDirty = { fg = groups.git_dirty },
		NvimTreeGitIgnored = { fg = groups.git_ignore },
		NvimTreeGitMerge = { fg = groups.git_merge },
		NvimTreeGitNew = { fg = groups.git_add },
		NvimTreeGitRenamed = { fg = groups.git_rename },
		NvimTreeGitStaged = { fg = groups.git_stage },
		NvimTreeImageFile = { fg = palette.text },
		NvimTreeNormal = { link = "Normal" },
		NvimTreeOpenedFile = { fg = palette.text, bg = palette.overlay },
		NvimTreeOpenedFolderName = { link = "NvimTreeFolderName" },
		NvimTreeRootFolder = { fg = palette.text, bold = true },
		NvimTreeSpecialFile = { link = "NvimTreeNormal" },
		NvimTreeWindowPicker = { link = "StatusLineTerm" },

		-- nvim-neotest/neotest
		NeotestAdapterName = { fg = palette.text },
		NeotestBorder = { fg = palette.highlight_med },
		NeotestDir = { fg = palette.text },
		NeotestExpandMarker = { fg = palette.highlight_med },
		NeotestFailed = { fg = palette.red_two },
		NeotestFile = { fg = palette.text },
		NeotestFocused = { fg = palette.text, bg = palette.highlight_med },
		NeotestIndent = { fg = palette.highlight_med },
		NeotestMarked = { fg = palette.text, bold = true },
		NeotestNamespace = { fg = palette.text },
		NeotestPassed = { fg = palette.blue_two },
		NeotestRunning = { fg = palette.text },
		NeotestWinSelect = { fg = palette.muted },
		NeotestSkipped = { fg = palette.text },
		NeotestTarget = { fg = palette.red_two },
		NeotestTest = { fg = palette.text },
		NeotestUnknown = { fg = palette.text },
		NeotestWatching = { fg = palette.text },

		-- nvim-neo-tree/neo-tree.nvim
		NeoTreeGitAdded = { fg = groups.git_add },
		NeoTreeGitConflict = { fg = groups.git_merge },
		NeoTreeGitDeleted = { fg = groups.git_delete },
		NeoTreeGitIgnored = { fg = groups.git_ignore },
		NeoTreeGitModified = { fg = groups.git_dirty },
		NeoTreeGitRenamed = { fg = groups.git_rename },
		NeoTreeGitUntracked = { fg = groups.git_untracked },
		NeoTreeTabActive = { fg = palette.text, bg = palette.overlay },
		NeoTreeTabInactive = { fg = palette.text },
		NeoTreeTabSeparatorActive = { link = "WinSeparator" },
		NeoTreeTabSeparatorInactive = { link = "WinSeparator" },
		NeoTreeTitleBar = { link = "StatusLineTerm" },

		-- folke/flash.nvim
		FlashLabel = { fg = palette.base, bg = palette.red_two },

		-- folke/which-key.nvim
		WhichKey = { fg = palette.text },
		WhichKeyBorder = make_border(),
		WhichKeyDesc = { fg = palette.text },
		WhichKeyFloat = { bg = groups.panel },
		WhichKeyGroup = { fg = palette.text },
		WhichKeyIcon = { fg = palette.text },
		WhichKeyIconAzure = { fg = palette.text },
		WhichKeyIconBlue = { fg = palette.text },
		WhichKeyIconCyan = { fg = palette.text },
		WhichKeyIconGreen = { fg = palette.text },
		WhichKeyIconGrey = { fg = palette.text },
		WhichKeyIconOrange = { fg = palette.text },
		WhichKeyIconPurple = { fg = palette.text },
		WhichKeyIconRed = { fg = palette.text },
		WhichKeyIconYellow = { fg = palette.text },
		WhichKeyNormal = { link = "NormalFloat" },
		WhichKeySeparator = { fg = palette.text },
		WhichKeyTitle = { link = "FloatTitle" },
		WhichKeyValue = { fg = palette.text },

		-- lukas-reineke/indent-blankline.nvim
		IblIndent = { fg = palette.overlay },
		IblScope = { fg = palette.text },
		IblWhitespace = { fg = palette.overlay },

		-- hrsh7th/nvim-cmp
		CmpItemAbbr = { fg = palette.text },
		CmpItemAbbrDeprecated = { fg = palette.text, strikethrough = true },
		CmpItemAbbrMatch = { fg = palette.text, bold = true },
		CmpItemAbbrMatchFuzzy = { fg = palette.text, bold = true },
		CmpItemKind = { fg = palette.text },
		CmpItemKindClass = { link = "StorageClass" },
		CmpItemKindFunction = { link = "Function" },
		CmpItemKindInterface = { link = "Type" },
		CmpItemKindMethod = { link = "PreProc" },
		CmpItemKindSnippet = { link = "String" },
		CmpItemKindVariable = { link = "Identifier" },

		-- NeogitOrg/neogit
		NeogitChangeAdded = { fg = groups.git_add, bold = true },
		NeogitChangeBothModified = { fg = groups.git_change, bold = true },
		NeogitChangeCopied = { fg = groups.git_untracked, bold = true },
		NeogitChangeDeleted = { fg = groups.git_delete, bold = true },
		NeogitChangeModified = { fg = groups.git_change, bold = true },
		NeogitChangeNewFile = { fg = groups.git_stage, bold = true },
		NeogitChangeRenamed = { fg = groups.git_rename, bold = true },
		NeogitChangeUpdated = { fg = groups.git_change, bold = true },
		NeogitDiffAddHighlight = { link = "DiffAdd" },
		NeogitDiffContextHighlight = { bg = palette.surface },
		NeogitDiffDeleteHighlight = { link = "DiffDelete" },
		NeogitFilePath = { fg = palette.text },
		NeogitHunkHeader = { bg = groups.panel },
		NeogitHunkHeaderHighlight = { bg = groups.panel },

		-- vimwiki/vimwiki
		VimwikiHR = { fg = palette.text },
		VimwikiHeader1 = { link = "markdownH1" },
		VimwikiHeader2 = { link = "markdownH2" },
		VimwikiHeader3 = { link = "markdownH3" },
		VimwikiHeader4 = { link = "markdownH4" },
		VimwikiHeader5 = { link = "markdownH5" },
		VimwikiHeader6 = { link = "markdownH6" },
		VimwikiHeaderChar = { fg = palette.text },
		VimwikiLink = { link = "markdownUrl" },
		VimwikiList = { fg = palette.text },
		VimwikiNoExistsLink = { fg = palette.red_two },

		-- nvim-neorg/neorg
		NeorgHeading1Prefix = { link = "markdownH1Delimiter" },
		NeorgHeading1Title = { link = "markdownH1" },
		NeorgHeading2Prefix = { link = "markdownH2Delimiter" },
		NeorgHeading2Title = { link = "markdownH2" },
		NeorgHeading3Prefix = { link = "markdownH3Delimiter" },
		NeorgHeading3Title = { link = "markdownH3" },
		NeorgHeading4Prefix = { link = "markdownH4Delimiter" },
		NeorgHeading4Title = { link = "markdownH4" },
		NeorgHeading5Prefix = { link = "markdownH5Delimiter" },
		NeorgHeading5Title = { link = "markdownH5" },
		NeorgHeading6Prefix = { link = "markdownH6Delimiter" },
		NeorgHeading6Title = { link = "markdownH6" },
		NeorgMarkerTitle = { fg = palette.text, bold = true },

		-- tami5/lspsaga.nvim (fork of glepnir/lspsaga.nvim)
		DefinitionCount = { fg = palette.text },
		DefinitionIcon = { fg = palette.text },
		DefinitionPreviewTitle = { fg = palette.text, bold = true },
		LspFloatWinBorder = make_border(),
		LspFloatWinNormal = { bg = groups.panel },
		LspSagaAutoPreview = { fg = palette.text },
		LspSagaCodeActionBorder = make_border(palette.text),
		LspSagaCodeActionContent = { fg = palette.text },
		LspSagaCodeActionTitle = { fg = palette.text, bold = true },
		LspSagaCodeActionTruncateLine = { link = "LspSagaCodeActionBorder" },
		LspSagaDefPreviewBorder = make_border(),
		LspSagaDiagnosticBorder = make_border(palette.text),
		LspSagaDiagnosticHeader = { fg = palette.text, bold = true },
		LspSagaDiagnosticTruncateLine = { link = "LspSagaDiagnosticBorder" },
		LspSagaDocTruncateLine = { link = "LspSagaHoverBorder" },
		LspSagaFinderSelection = { fg = palette.text },
		LspSagaHoverBorder = { link = "LspFloatWinBorder" },
		LspSagaLspFinderBorder = { link = "LspFloatWinBorder" },
		LspSagaRenameBorder = make_border(palette.text),
		LspSagaRenamePromptPrefix = { fg = palette.red_two },
		LspSagaShTruncateLine = { link = "LspSagaSignatureHelpBorder" },
		LspSagaSignatureHelpBorder = make_border(palette.text),
		ReferencesCount = { fg = palette.text },
		ReferencesIcon = { fg = palette.text },
		SagaShadow = { bg = palette.overlay },
		TargetWord = { fg = palette.text },

		-- ray-x/lsp_signature.nvim
		LspSignatureActiveParameter = { bg = palette.overlay },

		-- rlane/pounce.nvim
		PounceAccept = { fg = palette.red_two, bg = palette.red_two, blend = 20 },
		PounceAcceptBest = { fg = palette.text, bg = palette.text, blend = 20 },
		PounceGap = { link = "Search" },
		PounceMatch = { link = "Search" },

		-- ggandor/leap.nvim
		LeapLabelPrimary = { link = "IncSearch" },
		LeapLabelSecondary = { link = "StatusLineTerm" },
		LeapMatch = { link = "MatchParen" },

		-- phaazon/hop.nvim
		-- smoka7/hop.nvim
		HopNextKey = { fg = palette.red_two, bg = palette.red_two, blend = 20 },
		HopNextKey1 = { fg = palette.text, bg = palette.text, blend = 20 },
		HopNextKey2 = { fg = palette.text, bg = palette.text, blend = 20 },
		HopUnmatched = { fg = palette.muted },

		-- nvim-telescope/telescope.nvim
		TelescopeBorder = make_border(),
		TelescopeMatching = { fg = palette.text },
		TelescopeNormal = { link = "NormalFloat" },
		TelescopePromptNormal = { link = "TelescopeNormal" },
		TelescopePromptPrefix = { fg = palette.text },
		TelescopeSelection = { fg = palette.text, bg = palette.overlay },
		TelescopeSelectionCaret = { fg = palette.text, bg = palette.overlay },
		TelescopeTitle = { fg = palette.text, bold = true },

		-- ibhagwan/fzf-lua
		FzfLuaBorder = make_border(),
		FzfLuaBufFlagAlt = { fg = palette.text },
		FzfLuaBufFlagCur = { fg = palette.text },
		FzfLuaCursorLine = { fg = palette.text, bg = palette.overlay },
		FzfLuaFilePart = { fg = palette.text },
		FzfLuaHeaderBind = { fg = palette.text },
		FzfLuaHeaderText = { fg = palette.text },
		FzfLuaNormal = { link = "NormalFloat" },
		FzfLuaTitle = { link = "FloatTitle" },

		-- rcarriga/nvim-notify
		NotifyDEBUGBorder = make_border(),
		NotifyDEBUGIcon = { link = "NotifyDEBUGTitle" },
		NotifyDEBUGTitle = { fg = palette.muted },
		NotifyERRORBorder = make_border(groups.error),
		NotifyERRORIcon = { link = "NotifyERRORTitle" },
		NotifyERRORTitle = { fg = groups.error },
		NotifyINFOBorder = make_border(groups.info),
		NotifyINFOIcon = { link = "NotifyINFOTitle" },
		NotifyINFOTitle = { fg = groups.info },
		NotifyTRACEBorder = make_border(palette.text),
		NotifyTRACEIcon = { link = "NotifyTRACETitle" },
		NotifyTRACETitle = { fg = palette.text },
		NotifyWARNBorder = make_border(groups.warn),
		NotifyWARNIcon = { link = "NotifyWARNTitle" },
		NotifyWARNTitle = { fg = groups.warn },
		NotifyBackground = { bg = palette.surface },

		-- rcarriga/nvim-dap-ui
		DapUIBreakpointsCurrentLine = { fg = palette.text, bold = true },
		DapUIBreakpointsDisabledLine = { fg = palette.muted },
		DapUIBreakpointsInfo = { link = "DapUIThread" },
		DapUIBreakpointsLine = { link = "DapUIBreakpointsPath" },
		DapUIBreakpointsPath = { fg = palette.text },
		DapUIDecoration = { link = "DapUIBreakpointsPath" },
		DapUIFloatBorder = make_border(),
		DapUIFrameName = { fg = palette.text },
		DapUILineNumber = { link = "DapUIBreakpointsPath" },
		DapUIModifiedValue = { fg = palette.text, bold = true },
		DapUIScope = { link = "DapUIBreakpointsPath" },
		DapUISource = { fg = palette.text },
		DapUIStoppedThread = { link = "DapUIBreakpointsPath" },
		DapUIThread = { fg = palette.text },
		DapUIValue = { fg = palette.text },
		DapUIVariable = { fg = palette.text },
		DapUIWatchesEmpty = { fg = palette.red_two },
		DapUIWatchesError = { link = "DapUIWatchesEmpty" },
		DapUIWatchesValue = { link = "DapUIThread" },

		-- glepnir/dashboard-nvim
		DashboardCenter = { fg = palette.text },
		DashboardFooter = { fg = palette.text },
		DashboardHeader = { fg = palette.text },
		DashboardShortcut = { fg = palette.text },

		-- SmiteshP/nvim-navic
		NavicIconsArray = { fg = palette.text },
		NavicIconsBoolean = { fg = palette.text },
		NavicIconsClass = { fg = palette.text },
		NavicIconsConstant = { fg = palette.text },
		NavicIconsConstructor = { fg = palette.text },
		NavicIconsEnum = { fg = palette.text },
		NavicIconsEnumMember = { fg = palette.text },
		NavicIconsEvent = { fg = palette.text },
		NavicIconsField = { fg = palette.text },
		NavicIconsFile = { fg = palette.muted },
		NavicIconsFunction = { fg = palette.text },
		NavicIconsInterface = { fg = palette.text },
		NavicIconsKey = { fg = palette.text },
		NavicIconsKeyword = { fg = palette.text },
		NavicIconsMethod = { fg = palette.text },
		NavicIconsModule = { fg = palette.text },
		NavicIconsNamespace = { fg = palette.muted },
		NavicIconsNull = { fg = palette.text },
		NavicIconsNumber = { fg = palette.text },
		NavicIconsObject = { fg = palette.text },
		NavicIconsOperator = { fg = palette.text },
		NavicIconsPackage = { fg = palette.muted },
		NavicIconsProperty = { fg = palette.text },
		NavicIconsString = { fg = palette.cyan_two },
		NavicIconsStruct = { fg = palette.text },
		NavicIconsTypeParameter = { fg = palette.text },
		NavicIconsVariable = { fg = palette.text },
		NavicSeparator = { fg = palette.text },
		NavicText = { fg = palette.text },

		-- folke/noice.nvim
		NoiceCursor = { fg = palette.highlight_high, bg = palette.text },

		-- folke/trouble.nvim
		TroubleText = { fg = palette.text },
		TroubleCount = { fg = palette.text, bg = palette.surface },
		TroubleNormal = { fg = palette.text, bg = groups.panel },

		-- echasnovski/mini.nvim
		MiniAnimateCursor = { reverse = true, nocombine = true },
		MiniAnimateNormalFloat = { link = "NormalFloat" },

		MiniClueBorder = { link = "FloatBorder" },
		MiniClueDescGroup = { link = "DiagnosticFloatingWarn" },
		MiniClueDescSingle = { link = "NormalFloat" },
		MiniClueNextKey = { link = "DiagnosticFloatingHint" },
		MiniClueNextKeyWithPostkeys = { link = "DiagnosticFloatingError" },
		MiniClueSeparator = { link = "DiagnosticFloatingInfo" },
		MiniClueTitle = { bg = groups.panel, bold = true },

		MiniCompletionActiveParameter = { underline = true },

		MiniCursorword = { underline = true },
		MiniCursorwordCurrent = { underline = true },

		MiniDepsChangeAdded = { fg = groups.git_add },
		MiniDepsChangeRemoved = { fg = groups.git_delete },
		MiniDepsHint = { link = "DiagnosticHint" },
		MiniDepsInfo = { link = "DiagnosticInfo" },
		MiniDepsMsgBreaking = { link = "DiagnosticWarn" },
		MiniDepsPlaceholder = { link = "Comment" },
		MiniDepsTitle = { link = "Title" },
		MiniDepsTitleError = { link = "DiffDelete" },
		MiniDepsTitleSame = { link = "DiffText" },
		MiniDepsTitleUpdate = { link = "DiffAdd" },

		MiniDiffOverAdd = { fg = groups.git_add, bg = groups.git_add, blend = 20 },
		MiniDiffOverChange = { fg = groups.git_change, bg = groups.git_change, blend = 20 },
		MiniDiffOverContext = { bg = palette.surface },
		MiniDiffOverDelete = { fg = groups.git_delete, bg = groups.git_delete, blend = 20 },
		MiniDiffSignAdd = { fg = groups.git_add },
		MiniDiffSignChange = { fg = groups.git_change },
		MiniDiffSignDelete = { fg = groups.git_delete },

		MiniFilesBorder = { link = "FloatBorder" },
		MiniFilesBorderModified = { link = "DiagnosticFloatingWarn" },
		MiniFilesCursorLine = { link = "CursorLine" },
		MiniFilesDirectory = { link = "Directory" },
		MiniFilesFile = { fg = palette.text },
		MiniFilesNormal = { link = "NormalFloat" },
		MiniFilesTitle = { link = "FloatTitle" },
		MiniFilesTitleFocused = { fg = palette.text, bg = groups.panel, bold = true },

		MiniHipatternsFixme = { fg = palette.base, bg = groups.error, bold = true },
		MiniHipatternsHack = { fg = palette.base, bg = groups.warn, bold = true },
		MiniHipatternsNote = { fg = palette.base, bg = groups.info, bold = true },
		MiniHipatternsTodo = { fg = palette.base, bg = groups.hint, bold = true },

		MiniIconsAzure = { fg = palette.text },
		MiniIconsBlue = { fg = palette.text },
		MiniIconsCyan = { fg = palette.text },
		MiniIconsGreen = { fg = palette.text },
		MiniIconsGrey = { fg = palette.text },
		MiniIconsOrange = { fg = palette.text },
		MiniIconsPurple = { fg = palette.text },
		MiniIconsRed = { fg = palette.text },
		MiniIconsYellow = { fg = palette.text },

		MiniIndentscopeSymbol = { fg = palette.muted },
		MiniIndentscopeSymbolOff = { fg = palette.text },

		MiniJump = { sp = palette.text, undercurl = true },

		MiniJump2dDim = { fg = palette.text },
		MiniJump2dSpot = { fg = palette.text, bold = true, nocombine = true },
		MiniJump2dSpotAhead = { fg = palette.text, bg = palette.surface, nocombine = true },
		MiniJump2dSpotUnique = { fg = palette.text, bold = true, nocombine = true },

		MiniMapNormal = { link = "NormalFloat" },
		MiniMapSymbolCount = { link = "Special" },
		MiniMapSymbolLine = { link = "Title" },
		MiniMapSymbolView = { link = "Delimiter" },

		MiniNotifyBorder = { link = "FloatBorder" },
		MiniNotifyNormal = { link = "NormalFloat" },
		MiniNotifyTitle = { link = "FloatTitle" },

		MiniOperatorsExchangeFrom = { link = "IncSearch" },

		MiniPickBorder = { link = "FloatBorder" },
		MiniPickBorderBusy = { link = "DiagnosticFloatingWarn" },
		MiniPickBorderText = { bg = groups.panel },
		MiniPickIconDirectory = { link = "Directory" },
		MiniPickIconFile = { link = "MiniPickNormal" },
		MiniPickHeader = { link = "DiagnosticFloatingHint" },
		MiniPickMatchCurrent = { link = "CursorLine" },
		MiniPickMatchMarked = { link = "Visual" },
		MiniPickMatchRanges = { fg = palette.text },
		MiniPickNormal = { link = "NormalFloat" },
		MiniPickPreviewLine = { link = "CursorLine" },
		MiniPickPreviewRegion = { link = "IncSearch" },
		MiniPickPrompt = { bg = groups.panel, bold = true },

		MiniStarterCurrent = { nocombine = true },
		MiniStarterFooter = { fg = palette.text },
		MiniStarterHeader = { link = "Title" },
		MiniStarterInactive = { link = "Comment" },
		MiniStarterItem = { link = "Normal" },
		MiniStarterItemBullet = { link = "Delimiter" },
		MiniStarterItemPrefix = { link = "WarningMsg" },
		MiniStarterSection = { fg = palette.text },
		MiniStarterQuery = { link = "MoreMsg" },

		MiniStatuslineDevinfo = { fg = palette.text, bg = palette.overlay },
		MiniStatuslineFileinfo = { link = "MiniStatuslineDevinfo" },
		MiniStatuslineFilename = { fg = palette.muted, bg = palette.surface },
		MiniStatuslineInactive = { link = "MiniStatuslineFilename" },
		MiniStatuslineModeCommand = { fg = palette.base, bg = palette.red_two, bold = true },
		MiniStatuslineModeInsert = { fg = palette.base, bg = palette.cyan_two, bold = true },
		MiniStatuslineModeNormal = { fg = palette.base, bg = palette.text, bold = true },
		MiniStatuslineModeOther = { fg = palette.base, bg = palette.text, bold = true },
		MiniStatuslineModeReplace = { fg = palette.base, bg = palette.blue_two, bold = true },
		MiniStatuslineModeVisual = { fg = palette.base, bg = palette.text, bold = true },

		MiniSurround = { link = "IncSearch" },

		MiniTablineCurrent = { fg = palette.text, bg = palette.overlay, bold = true },
		MiniTablineFill = { link = "TabLineFill" },
		MiniTablineHidden = { fg = palette.text, bg = groups.panel },
		MiniTablineModifiedCurrent = { fg = palette.overlay, bg = palette.text, bold = true },
		MiniTablineModifiedHidden = { fg = groups.panel, bg = palette.text },
		MiniTablineModifiedVisible = { fg = groups.panel, bg = palette.text },
		MiniTablineTabpagesection = { link = "Search" },
		MiniTablineVisible = { fg = palette.text, bg = groups.panel },

		MiniTestEmphasis = { bold = true },
		MiniTestFail = { fg = palette.red_two, bold = true },
		MiniTestPass = { fg = palette.text, bold = true },

		MiniTrailspace = { bg = palette.red_two },

		-- goolord/alpha-nvim
		AlphaButtons = { fg = palette.text },
		AlphaFooter = { fg = palette.text },
		AlphaHeader = { fg = palette.text },
		AlphaShortcut = { fg = palette.text },

		-- github/copilot.vim
		CopilotSuggestion = { fg = palette.muted, italic = true },

		-- nvim-treesitter/nvim-treesitter-context
		TreesitterContext = { bg = palette.overlay },
		TreesitterContextLineNumber = { fg = palette.text, bg = palette.overlay },

		-- RRethy/vim-illuminate
		IlluminatedWordRead = { bg = palette.overlay },
		IlluminatedWordText = { bg = palette.overlay },
		IlluminatedWordWrite = { bg = palette.overlay },

		-- HiPhish/rainbow-delimiters.nvim
		RainbowDelimiterBlue = { fg = palette.text },
		RainbowDelimiterCyan = { fg = palette.text },
		RainbowDelimiterGreen = { fg = palette.text },
		RainbowDelimiterOrange = { fg = palette.text },
		RainbowDelimiterRed = { fg = palette.text },
		RainbowDelimiterViolet = { fg = palette.text },
		RainbowDelimiterYellow = { fg = palette.text },

		-- MeanderingProgrammer/render-markdown.nvim
		RenderMarkdownBullet = { fg = palette.text },
		RenderMarkdownChecked = { fg = palette.text },
		RenderMarkdownCode = { bg = palette.overlay },
		RenderMarkdownCodeInline = { fg = palette.text, bg = palette.overlay },
		RenderMarkdownDash = { fg = palette.muted },
		RenderMarkdownH1Bg = { bg = groups.h1, blend = 20 },
		RenderMarkdownH2Bg = { bg = groups.h2, blend = 20 },
		RenderMarkdownH3Bg = { bg = groups.h3, blend = 20 },
		RenderMarkdownH4Bg = { bg = groups.h4, blend = 20 },
		RenderMarkdownH5Bg = { bg = groups.h5, blend = 20 },
		RenderMarkdownH6Bg = { bg = groups.h6, blend = 20 },
		RenderMarkdownQuote = { fg = palette.text },
		RenderMarkdownTableFill = { link = "Conceal" },
		RenderMarkdownTableHead = { fg = palette.text },
		RenderMarkdownTableRow = { fg = palette.text },
		RenderMarkdownUnchecked = { fg = palette.text },

		-- MagicDuck/grug-far.nvim
		GrugFarHelpHeader = { fg = palette.text },
		GrugFarHelpHeaderKey = { fg = palette.text },
		GrugFarHelpWinActionKey = { fg = palette.text },
		GrugFarHelpWinActionPrefix = { fg = palette.text },
		GrugFarHelpWinActionText = { fg = palette.text },
		GrugFarHelpWinHeader = { link = "FloatTitle" },
		GrugFarInputLabel = { fg = palette.text },
		GrugFarInputPlaceholder = { link = "Comment" },
		GrugFarResultsActionMessage = { fg = palette.text },
		GrugFarResultsChangeIndicator = { fg = groups.git_change },
		GrugFarResultsHeader = { fg = palette.text },
		GrugFarResultsLineNo = { fg = palette.text },
		GrugFarResultsLineColumn = { link = "GrugFarResultsLineNo" },
		GrugFarResultsMatch = { link = "CurSearch" },
		GrugFarResultsPath = { fg = palette.text },
		GrugFarResultsStats = { fg = palette.text },

		-- yetone/avante.nvim
		AvanteTitle = { fg = palette.highlight_high, bg = palette.text },
		AvanteReversedTitle = { fg = palette.text },
		AvanteSubtitle = { fg = palette.highlight_med, bg = palette.text },
		AvanteReversedSubtitle = { fg = palette.text },
		AvanteThirdTitle = { fg = palette.highlight_med, bg = palette.text },
		AvanteReversedThirdTitle = { fg = palette.text },

		-- folke/todo-comments.nvim
		TodoBgTODO = { link = "@comment.todo" },
		TodoBgWARN = { fg = groups.warn, bg = groups.warn, blend = 20 },
		TodoBgHACK = { link = "@comment.warn" },
		TodoBgFIX = { fg = groups.error, bg = groups.error, blend = 20 },
		TodoBgNOTE = { link = "@comment.note" },
		TodoBgPERF = { link = "@comment.info" },
		TodoBgTEST = { link = "@comment.info" },
		TodoFgTODO = { fg = groups.todo },
		TodoFgWARN = { fg = groups.warn },
		TodoFgHACK = { link = "TodoFgWARN" },
		TodoFgFIX = { fg = groups.error },
		TodoFgNOTE = { fg = groups.note },
		TodoFgPERF = { fg = groups.info },
		TodoFgTEST = { link = "TodoFgPERF" },
		TodoSignTODO = { fg = groups.todo },
		TodoSignWARN = { fg = groups.warn },
		TodoSignHACK = { link = "TodoSignWARN" },
		TodoSignFIX = { fg = groups.error },
		TodoSignNOTE = { fg = groups.note },
		TodoSignPERF = { fg = groups.info },
		TodoSignTEST = { link = "TodoSignPERF" },

		InclineNormal = { bg = palette.overlay },
		InclineNormalNC = { bg = palette.overlay },
	}
	local transparency_highlights = {
		DiagnosticVirtualTextError = { fg = groups.error },
		DiagnosticVirtualTextHint = { fg = groups.hint },
		DiagnosticVirtualTextInfo = { fg = groups.info },
		DiagnosticVirtualTextOk = { fg = groups.ok },
		DiagnosticVirtualTextWarn = { fg = groups.warn },

		FloatBorder = { fg = palette.muted, bg = "NONE" },
		FloatTitle = { fg = palette.text, bg = "NONE", bold = true },
		Folded = { fg = palette.text, bg = "NONE" },
		NormalFloat = { bg = "NONE" },
		Normal = { fg = palette.text, bg = "NONE" },
		NormalNC = { fg = palette.text, bg = config.options.dim_inactive_windows and palette._nc or "NONE" },
		Pmenu = { fg = palette.text, bg = "NONE" },
		PmenuKind = { fg = palette.text, bg = "NONE" },
		SignColumn = { fg = palette.text, bg = "NONE" },
		StatusLine = { fg = palette.text, bg = "NONE" },
		StatusLineNC = { fg = palette.muted, bg = "NONE" },
		TabLine = { bg = "NONE", fg = palette.text },
		TabLineFill = { bg = "NONE" },
		TabLineSel = { fg = palette.text, bg = "NONE", bold = true },

		-- ["@markup.raw"] = { bg = "none" },
		["@markup.raw.markdown_inline"] = { fg = palette.cyan_two },
		-- ["@markup.raw.block"] = { bg = "none" },

		TelescopeNormal = { fg = palette.text, bg = "NONE" },
		TelescopePromptNormal = { fg = palette.text, bg = "NONE" },
		TelescopeSelection = { fg = palette.text, bg = "NONE", bold = true },
		TelescopeSelectionCaret = { fg = palette.text },

		TroubleNormal = { bg = "NONE" },

		WhichKeyFloat = { bg = "NONE" },
		WhichKeyNormal = { bg = "NONE" },

		IblIndent = { fg = palette.overlay, bg = "NONE" },
		IblScope = { fg = palette.text, bg = "NONE" },
		IblWhitespace = { fg = palette.overlay, bg = "NONE" },

		TreesitterContext = { bg = "NONE" },
		TreesitterContextLineNumber = { fg = palette.text, bg = "NONE" },

		MiniFilesTitleFocused = { fg = palette.text, bg = "NONE", bold = true },

		MiniPickPrompt = { bg = "NONE", bold = true },
		MiniPickBorderText = { bg = "NONE" },
	}

	if config.options.enable.legacy_highlights then
		for group, highlight in pairs(legacy_highlights) do
			highlights[group] = highlight
		end
	end
	for group, highlight in pairs(default_highlights) do
		highlights[group] = highlight
	end
	if styles.transparency then
		for group, highlight in pairs(transparency_highlights) do
			highlights[group] = highlight
		end
	end

	-- Reconcile highlights with config
	if config.options.highlight_groups ~= nil and next(config.options.highlight_groups) ~= nil then
		for group, highlight in pairs(config.options.highlight_groups) do
			local existing = highlights[group] or {}
			-- Traverse link due to
			-- "If link is used in combination with other attributes; only the link will take effect"
			-- see: https://neovim.io/doc/user/api.html#nvim_set_hl()
			while existing.link ~= nil do
				existing = highlights[existing.link] or {}
			end
			local parsed = vim.tbl_extend("force", {}, highlight)

			if highlight.fg ~= nil then
				parsed.fg = utilities.parse_color(highlight.fg) or highlight.fg
			end
			if highlight.bg ~= nil then
				parsed.bg = utilities.parse_color(highlight.bg) or highlight.bg
			end
			if highlight.sp ~= nil then
				parsed.sp = utilities.parse_color(highlight.sp) or highlight.sp
			end

			if (highlight.inherit == nil or highlight.inherit) and existing ~= nil then
				parsed.inherit = nil
				highlights[group] = vim.tbl_extend("force", existing, parsed)
			else
				parsed.inherit = nil
				highlights[group] = parsed
			end
		end
	end

	for group, highlight in pairs(highlights) do
		if config.options.before_highlight ~= nil then
			config.options.before_highlight(group, highlight, palette)
		end
		if highlight.blend ~= nil and (highlight.blend >= 0 and highlight.blend <= 100) and highlight.bg ~= nil then
			highlight.bg = utilities.blend(highlight.bg, highlight.blend_on or palette.base, highlight.blend / 100)
		end
		vim.api.nvim_set_hl(0, group, highlight)
	end

	--- Terminal
	if config.options.enable.terminal then
		vim.g.terminal_color_0 = palette.overlay -- black
		vim.g.terminal_color_8 = palette.subtle -- bright black
		vim.g.terminal_color_1 = palette.red_two -- red
		vim.g.terminal_color_9 = palette.red_two -- bright red
		vim.g.terminal_color_2 = palette.blue_two -- green
		vim.g.terminal_color_10 = palette.blue_two -- bright green
		vim.g.terminal_color_3 = palette.orange_two -- yellow_two
		vim.g.terminal_color_11 = palette.orange_two -- bright yellow_two
		vim.g.terminal_color_4 = palette.cyan_two -- blue
		vim.g.terminal_color_12 = palette.cyan_two -- bright blue
		vim.g.terminal_color_5 = palette.purple_two -- magenta
		vim.g.terminal_color_13 = palette.purple_two -- bright magenta
		vim.g.terminal_color_6 = palette.magenta_two -- cyan
		vim.g.terminal_color_14 = palette.magenta_two -- bright cyan
		vim.g.terminal_color_7 = palette.text -- white
		vim.g.terminal_color_15 = palette.text -- bright white

		-- Support StatusLineTerm & StatusLineTermNC from vim
		vim.cmd([[
		augroup flowxi
			autocmd!
			autocmd TermOpen * if &buftype=='terminal'
				\|setlocal winhighlight=StatusLine:StatusLineTerm,StatusLineNC:StatusLineTermNC
				\|else|setlocal winhighlight=|endif
			autocmd ColorSchemePre * autocmd! flowxi
		augroup END
		]])
	end
end

---@param variant Variant | nil
function M.colorscheme(variant)
	config.extend_options({ variant = variant })

	vim.opt.termguicolors = true
	if vim.g.colors_name then
		vim.cmd("hi clear")
		vim.cmd("syntax reset")
	end
	vim.g.colors_name = "flowxi"

	set_highlights()
end

---@param options Options
function M.setup(options)
	config.extend_options(options or {})
end

return M
