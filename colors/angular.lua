-- Angular-inspired colorscheme
-- Gruvbox-influenced: earthy warm brown backgrounds, parchment foregrounds
-- Syntax: vintage wine/crimson reds + dusty pinks + aged purples throughout

vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "angular"
vim.opt.termguicolors = true

local c = {
  -- Backgrounds (gruvbox-style warm brown/earthy — subtle red-brown undertone)
  bg0       = "#1c1814", -- near-black warm brown with red tint
  bg1       = "#28201c", -- normal background, gruvbox-dark brown
  bg2       = "#322824", -- cursorline / selection — warm brown lift
  bg3       = "#3c3028", -- floating windows / popups — earthy brown
  bg4       = "#504038", -- borders / inactive UI — gruvbox warm gray

  -- Foregrounds (gruvbox-style parchment — warm yellow-cream)
  fg0       = "#fbf1c7", -- bright gruvbox parchment
  fg1       = "#ebdbb2", -- classic gruvbox fg
  fg2       = "#d5c4a1", -- gruvbox fg1
  fg3       = "#a89984", -- gruvbox fg2

  -- ── Red palette: 9 vintage shades, light → dark ──────────────────────────
  --
  --  red_rose    #d4687a  dusty rose      → string escapes, light accents
  --  red_hot     #c93048  aged crimson    → errors, cursor search, numbers
  --  red_vivid   #b82840  deep crimson    → return/exceptions, booleans, constructors
  --  red_primary #a82038  vintage brick   → regular keywords (if/for/class)
  --  red_warm    #944040  warm earthy     → builtins (vars, functions, constants)
  --  red_mid     #7a1e2e  burgundy        → types, storage class, defines
  --  red_muted   #5c1828  deep wine       → labels, attributes, punctuation specials
  --  red_dark    #3e1018  very dark wine  → indent scope, subtle UI tints
  --  red_shadow  #280a10  near-black wine → visual bg, diff-delete bg
  --
  red_rose    = "#d4687a",
  red_hot     = "#c93048",
  red_vivid   = "#b82840",
  red_primary = "#a82038",
  red_warm    = "#944040",
  red_mid     = "#7a1e2e",
  red_muted   = "#5c1828",
  red_dark    = "#3e1018",
  red_shadow  = "#280a10",

  -- ── Pink palette: 4 vintage dusty shades ─────────────────────────────────
  --
  --  pink_light  #c988a2  dusty blossom   → string escapes, member access accents
  --  pink_mid    #a86882  vintage mauve   → decorators/@Component, tag attributes
  --  pink_deep   #884862  antique rose    → method definitions, member fields
  --  pink_dark   #5a2842  deep old rose   → subtle pink tints
  --
  pink_light  = "#c988a2",
  pink_mid    = "#a86882",
  pink_deep   = "#884862",
  pink_dark   = "#5a2842",

  -- ── Purple palette: 4 vintage dusty shades ───────────────────────────────
  --
  --  purple_light  #9878b8  dusty lavender  → types, constructors
  --  purple_mid    #7858a0  vintage violet  → namespaces, storage class
  --  purple_deep   #5c4080  deep amethyst   → type builtins, keyword operators
  --  purple_dark   #3c2860  dark amethyst   → subtle UI tints
  --
  purple_light = "#9878b8",
  purple_mid   = "#7858a0",
  purple_deep  = "#5c4080",
  purple_dark  = "#3c2860",

  -- Accents (gruvbox-warm parchment / tan)
  silver    = "#d8c9a0", -- warm parchment tan — strings/constants
  muted     = "#8a7c6e", -- gruvbox-style warm muted gray

  -- Semantic (slightly desaturated to match vintage feel)
  warn      = "#c87840", -- aged amber warning
  info      = "#4878aa", -- faded slate blue info
  hint      = "#9878b8", -- dusty lavender hint (now matches purple_light)
  ok        = "#3a8c58", -- aged forest green
}

local function hi(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- ─── Editor ──────────────────────────────────────────────────────────────────
hi("Normal",        { fg = c.fg1,        bg = c.bg1 })
hi("NormalFloat",   { fg = c.fg1,        bg = c.bg3 })
hi("NormalNC",      { fg = c.fg2,        bg = c.bg0 })
hi("FloatBorder",   { fg = c.red_mid,    bg = c.bg3 })
hi("FloatTitle",    { fg = c.red_primary,bg = c.bg3, bold = true })
hi("SignColumn",    { fg = c.fg3,        bg = c.bg1 })
hi("ColorColumn",   { bg = c.bg2 })
hi("CursorLine",    { bg = c.bg2 })
hi("CursorColumn",  { bg = c.bg2 })
hi("CursorLineNr",  { fg = c.red_primary,bold = true })
hi("LineNr",        { fg = c.fg3 })
hi("EndOfBuffer",   { fg = c.bg3 })
hi("Folded",        { fg = c.fg3,        bg = c.bg2 })
hi("FoldColumn",    { fg = c.muted,      bg = c.bg1 })
hi("VertSplit",     { fg = c.bg4 })
hi("WinSeparator",  { fg = c.red_dark })
hi("StatusLine",    { fg = c.fg1,        bg = c.bg3 })
hi("StatusLineNC",  { fg = c.fg3,        bg = c.bg2 })
hi("TabLine",       { fg = c.fg3,        bg = c.bg2 })
hi("TabLineFill",   { bg = c.bg0 })
hi("TabLineSel",    { fg = c.fg0,        bg = c.red_mid,     bold = true })
hi("WildMenu",      { fg = c.fg0,        bg = c.red_mid })
hi("Pmenu",         { fg = c.fg1,        bg = c.bg3 })
hi("PmenuSel",      { fg = c.fg0,        bg = c.red_muted,   bold = true })
hi("PmenuSbar",     { bg = c.bg4 })
hi("PmenuThumb",    { bg = c.red_mid })
hi("PmenuMatch",    { fg = c.red_hot,    bold = true })
hi("PmenuMatchSel", { fg = c.red_rose,   bg = c.red_muted,   bold = true })

hi("Visual",        { fg = c.fg0,        bg = c.red_muted })
hi("VisualNOS",     { fg = c.fg0,        bg = c.red_muted })
hi("Search",        { fg = c.fg0,        bg = c.red_dark })
hi("IncSearch",     { fg = c.bg0,        bg = c.red_primary, bold = true })
hi("CurSearch",     { fg = c.bg0,        bg = c.red_hot,     bold = true })
hi("Substitute",    { fg = c.bg0,        bg = c.red_vivid })
hi("MatchParen",    { fg = c.red_rose,   bold = true, underline = true })

hi("NonText",       { fg = c.bg4 })
hi("SpecialKey",    { fg = c.bg4 })
hi("Conceal",       { fg = c.muted })
hi("Whitespace",    { fg = c.bg4 })

hi("SpellBad",      { sp = c.red_hot,    undercurl = true })
hi("SpellCap",      { sp = c.warn,       undercurl = true })
hi("SpellRare",     { sp = c.hint,       undercurl = true })
hi("SpellLocal",    { sp = c.info,       undercurl = true })

-- ─── Syntax ───────────────────────────────────────────────────────────────────
hi("Comment",       { fg = c.fg3,        italic = true })
hi("Constant",      { fg = c.silver })
hi("String",        { fg = c.silver })
hi("Character",     { fg = c.red_rose })    -- soft pink: char literals distinct from strings
hi("Number",        { fg = c.red_hot })     -- neon: numerics pop
hi("Boolean",       { fg = c.red_vivid,   bold = true })  -- vivid: true/false stand out
hi("Float",         { fg = c.red_hot })
hi("Identifier",    { fg = c.fg1 })
hi("Function",      { fg = c.fg0,         bold = true })
hi("Statement",     { fg = c.red_primary })
hi("Conditional",   { fg = c.red_primary })
hi("Repeat",        { fg = c.red_primary })
hi("Label",         { fg = c.red_muted })   -- dusty: labels are less important
hi("Operator",      { fg = c.fg2 })
hi("Keyword",       { fg = c.red_primary,  bold = true })
hi("Exception",     { fg = c.red_vivid,    bold = true })  -- vivid: throw/raise stand out
hi("PreProc",       { fg = c.silver })
hi("Include",       { fg = c.silver })
hi("Define",        { fg = c.red_mid })     -- deep: preprocessor defs
hi("Macro",         { fg = c.red_mid })
hi("PreCondit",     { fg = c.red_mid })
hi("Type",          { fg = c.purple_light })               -- dusty lavender: types distinct from keywords
hi("StorageClass",  { fg = c.purple_mid })                 -- vintage violet: static/const/let
hi("Structure",     { fg = c.purple_light })               -- dusty lavender: struct/class/interface
hi("Typedef",       { fg = c.purple_mid })
hi("Special",       { fg = c.red_hot })
hi("SpecialChar",   { fg = c.red_rose })    -- rose: escape sequences inside strings
hi("Tag",           { fg = c.red_primary })
hi("Delimiter",     { fg = c.fg3 })
hi("SpecialComment",{ fg = c.muted,        italic = true })
hi("Debug",         { fg = c.warn })
hi("Underlined",    { underline = true })
hi("Bold",          { bold = true })
hi("Italic",        { italic = true })
hi("Error",         { fg = c.red_hot,      bold = true })
hi("Todo",          { fg = c.fg0,          bg = c.red_dark, bold = true })

-- ─── Treesitter ───────────────────────────────────────────────────────────────
hi("@comment",               { link = "Comment" })
hi("@variable",              { fg = c.fg1 })
hi("@variable.builtin",      { fg = c.red_warm })         -- warm: self/this/super
hi("@variable.parameter",    { fg = c.fg2,   italic = true })
hi("@variable.member",       { fg = c.pink_deep })          -- antique rose: member fields
hi("@constant",              { fg = c.silver })
hi("@constant.builtin",      { fg = c.red_warm,  bold = true }) -- warm: nil/null/undefined
hi("@string",                { fg = c.silver })
hi("@string.escape",         { fg = c.pink_light })        -- dusty blossom: \n \t inside strings
hi("@string.special",        { fg = c.pink_mid })          -- vintage mauve: regex / special strings
hi("@number",                { link = "Number" })
hi("@boolean",               { link = "Boolean" })
hi("@float",                 { link = "Float" })
hi("@function",              { fg = c.fg0,   bold = true })
hi("@function.builtin",      { fg = c.red_warm,  bold = true }) -- warm: print/len/etc
hi("@function.call",         { fg = c.fg1 })
hi("@function.method",       { fg = c.pink_deep, bold = true }) -- antique rose: method defs distinct from functions
hi("@function.method.call",  { fg = c.pink_deep })             -- antique rose: method calls
hi("@constructor",           { fg = c.purple_light, bold = true }) -- dusty lavender: new Foo()
hi("@keyword",               { fg = c.red_primary, bold = true })
hi("@keyword.function",      { fg = c.red_primary, bold = true })
hi("@keyword.operator",      { fg = c.purple_deep })       -- deep amethyst: 'and'/'or'/'not' ops
hi("@keyword.import",        { fg = c.silver })
hi("@keyword.return",        { fg = c.red_vivid,  bold = true }) -- vivid: return/yield
hi("@operator",              { fg = c.fg2 })
hi("@punctuation.delimiter", { fg = c.fg3 })
hi("@punctuation.bracket",   { fg = c.fg2 })
hi("@punctuation.special",   { fg = c.red_muted })        -- dusty: template ${} etc
hi("@type",                  { fg = c.purple_light })      -- dusty lavender: types
hi("@type.builtin",          { fg = c.purple_mid })        -- vintage violet: int/str/bool types
hi("@type.qualifier",        { fg = c.red_primary })       -- primary: const/readonly
hi("@tag",                   { fg = c.red_primary })
hi("@tag.builtin",           { fg = c.red_vivid })         -- vivid: <html>/<div> builtins
hi("@tag.attribute",         { fg = c.pink_mid })          -- vintage mauve: class="..." id="..."
hi("@tag.delimiter",         { fg = c.fg3 })
hi("@namespace",             { fg = c.purple_mid })        -- vintage violet: namespaces
hi("@module",                { fg = c.purple_mid })        -- vintage violet: modules
hi("@label",                 { fg = c.pink_mid })          -- vintage mauve: labels
hi("@attribute",             { fg = c.pink_mid })          -- vintage mauve: decorators/@Component

-- ─── LSP ──────────────────────────────────────────────────────────────────────
hi("DiagnosticError",            { fg = c.red_hot })
hi("DiagnosticWarn",             { fg = c.warn })
hi("DiagnosticInfo",             { fg = c.info })
hi("DiagnosticHint",             { fg = c.hint })
hi("DiagnosticOk",               { fg = c.ok })
hi("DiagnosticUnderlineError",   { sp = c.red_hot,    undercurl = true })
hi("DiagnosticUnderlineWarn",    { sp = c.warn,       undercurl = true })
hi("DiagnosticUnderlineInfo",    { sp = c.info,       undercurl = true })
hi("DiagnosticUnderlineHint",    { sp = c.hint,       undercurl = true })
hi("DiagnosticVirtualTextError", { fg = c.red_vivid,  italic = true })  -- vivid: readable but not neon
hi("DiagnosticVirtualTextWarn",  { fg = c.warn,       italic = true })
hi("DiagnosticVirtualTextInfo",  { fg = c.info,       italic = true })
hi("DiagnosticVirtualTextHint",  { fg = c.hint,       italic = true })
hi("LspReferenceText",           { bg = c.bg3 })
hi("LspReferenceRead",           { bg = c.bg3 })
hi("LspReferenceWrite",          { bg = c.red_shadow, underline = true })
hi("LspInlayHint",               { fg = c.purple_deep, bg = c.bg2, italic = true }) -- deep amethyst tint
hi("LspCodeLens",                { fg = c.fg3,        italic = true })
hi("LspSignatureActiveParameter",{ fg = c.red_rose,   bold = true, underline = true })

-- ─── Git / Diff ───────────────────────────────────────────────────────────────
hi("DiffAdd",       { fg = c.ok,          bg = "#0d2518" })
hi("DiffDelete",    { fg = c.red_primary, bg = c.red_shadow })
hi("DiffChange",    { fg = c.warn,        bg = "#2a1800" })
hi("DiffText",      { fg = c.fg0,         bg = "#3d2000", bold = true })
hi("GitSignsAdd",          { fg = c.ok })
hi("GitSignsChange",       { fg = c.warn })
hi("GitSignsDelete",       { fg = c.red_primary })
hi("GitSignsAddNr",        { fg = c.ok })
hi("GitSignsChangeNr",     { fg = c.warn })
hi("GitSignsDeleteNr",     { fg = c.red_primary })

-- ─── Telescope ────────────────────────────────────────────────────────────────
hi("TelescopeNormal",          { fg = c.fg1,        bg = c.bg3 })
hi("TelescopeBorder",          { fg = c.red_mid,    bg = c.bg3 })
hi("TelescopeTitle",           { fg = c.red_primary,bg = c.bg3, bold = true })
hi("TelescopePromptNormal",    { fg = c.fg0,        bg = c.bg2 })
hi("TelescopePromptBorder",    { fg = c.red_primary,bg = c.bg2 })
hi("TelescopePromptTitle",     { fg = c.fg0,        bg = c.red_muted, bold = true })
hi("TelescopePromptPrefix",    { fg = c.red_hot })
hi("TelescopeSelection",       { fg = c.fg0,        bg = c.red_shadow, bold = true })
hi("TelescopeSelectionCaret",  { fg = c.red_vivid })
hi("TelescopeMatching",        { fg = c.red_hot,    bold = true })

-- ─── nvim-tree / neo-tree ─────────────────────────────────────────────────────
hi("NeoTreeNormal",            { fg = c.fg2,        bg = c.bg0 })
hi("NeoTreeNormalNC",          { fg = c.fg3,        bg = c.bg0 })
hi("NeoTreeRootName",          { fg = c.red_primary,bold = true })
hi("NeoTreeDirectoryName",     { fg = c.fg1 })
hi("NeoTreeDirectoryIcon",     { fg = c.red_mid })
hi("NeoTreeFileName",          { fg = c.fg2 })
hi("NeoTreeFileIcon",          { fg = c.muted })
hi("NeoTreeGitAdded",          { fg = c.ok })
hi("NeoTreeGitModified",       { fg = c.warn })
hi("NeoTreeGitDeleted",        { fg = c.red_primary })
hi("NeoTreeIndentMarker",      { fg = c.bg4 })
hi("NeoTreeExpander",          { fg = c.muted })
hi("NeoTreeTitleBar",          { fg = c.fg0,        bg = c.red_muted, bold = true })

-- ─── Which-key ────────────────────────────────────────────────────────────────
hi("WhichKey",          { fg = c.pink_light })    -- dusty blossom: key names
hi("WhichKeyGroup",     { fg = c.purple_light, bold = true }) -- dusty lavender: group labels
hi("WhichKeyDesc",      { fg = c.fg1 })
hi("WhichKeySeparator", { fg = c.fg3 })
hi("WhichKeyFloat",     { bg = c.bg3 })
hi("WhichKeyBorder",    { fg = c.red_mid,    bg = c.bg3 })

-- ─── Indent Blankline ─────────────────────────────────────────────────────────
hi("IblIndent",         { fg = c.bg3 })
hi("IblScope",          { fg = c.red_dark })   -- dark: subtle scope highlight

-- ─── Notify ───────────────────────────────────────────────────────────────────
hi("NotifyERRORBorder", { fg = c.red_mid })
hi("NotifyWARNBorder",  { fg = c.warn })
hi("NotifyINFOBorder",  { fg = c.info })
hi("NotifyDEBUGBorder", { fg = c.muted })
hi("NotifyERRORIcon",   { fg = c.red_hot })
hi("NotifyWARNIcon",    { fg = c.warn })
hi("NotifyINFOIcon",    { fg = c.info })
hi("NotifyERRORTitle",  { fg = c.red_vivid, bold = true })
hi("NotifyWARNTitle",   { fg = c.warn,      bold = true })
hi("NotifyINFOTitle",   { fg = c.info,      bold = true })

-- ─── Mini / Snacks ────────────────────────────────────────────────────────────
hi("MiniStatuslineModeNormal",  { fg = c.bg0, bg = c.red_primary, bold = true })
hi("MiniStatuslineModeInsert",  { fg = c.bg0, bg = c.purple_light, bold = true })
hi("MiniStatuslineModeVisual",  { fg = c.bg0, bg = c.red_vivid,   bold = true })
hi("MiniStatuslineModeReplace", { fg = c.bg0, bg = c.warn,        bold = true })
hi("MiniStatuslineModeCommand", { fg = c.bg0, bg = c.red_warm,    bold = true })
hi("MiniStatuslineFilename",    { fg = c.fg2, bg = c.bg2 })
hi("MiniStatuslineFileinfo",    { fg = c.fg3, bg = c.bg2 })
hi("MiniStatuslineInactive",    { fg = c.fg3, bg = c.bg0 })
hi("MiniPickBorder",            { fg = c.red_mid })
hi("MiniPickBorderText",        { fg = c.red_primary, bold = true })
hi("MiniPickMatchCurrent",      { bg = c.red_shadow })
hi("MiniPickMatchMarked",       { fg = c.red_hot,     bold = true })
hi("MiniPickPromptCursor",      { fg = c.red_vivid })
hi("SnacksPickerMatch",         { fg = c.red_hot,     bold = true })
hi("SnacksPickerTitle",         { fg = c.red_primary, bold = true })

-- ─── Misc ─────────────────────────────────────────────────────────────────────
hi("Title",             { fg = c.red_primary, bold = true })
hi("Directory",         { fg = c.red_warm })
hi("Question",          { fg = c.red_primary })
hi("MoreMsg",           { fg = c.ok })
hi("WarningMsg",        { fg = c.warn })
hi("ErrorMsg",          { fg = c.red_hot })
hi("ModeMsg",           { fg = c.fg1,         bold = true })
