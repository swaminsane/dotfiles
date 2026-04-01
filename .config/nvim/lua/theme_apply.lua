local c = require("theme").colors
local set = vim.api.nvim_set_hl

vim.cmd("hi clear")
vim.o.termguicolors = true

-- Detect light/dark automatically
local function is_light(bg)
  local r, g, b = bg:match("#(..)(..)(..)")
  r, g, b = tonumber(r,16), tonumber(g,16), tonumber(b,16)
  local luminance = 0.299*r + 0.587*g + 0.114*b
  return luminance > 140
end

vim.o.background = is_light(c.COL_BG) and "light" or "dark"

-- ── base ─────────────────────────────
set(0, "Normal",       { fg = c.COL_FG, bg = c.COL_BG })
set(0, "CursorLine",   { bg = c.COL_BORDER })
set(0, "Visual",       { bg = c.COL_BORDER })

-- ── UI ─────────────────────────────
set(0, "LineNr",       { fg = c.COL_BORDER })
set(0, "CursorLineNr", { fg = c.COL_ACCENT, bold = true })
set(0, "VertSplit",    { fg = c.COL_BORDER })
set(0, "StatusLine",   { fg = c.COL_FG, bg = c.COL_BORDER })
set(0, "Pmenu",        { fg = c.COL_FG, bg = c.COL_BORDER })
set(0, "PmenuSel",     { fg = c.COL_BG, bg = c.COL_ACCENT })

-- ── syntax ───────────────────────────
set(0, "Comment",      { fg = c.COL_BRIGHT_BLACK, italic = true })
set(0, "String",       { fg = c.COL_GREEN })
set(0, "Keyword",      { fg = c.COL_MAGENTA })
set(0, "Function",     { fg = c.COL_BLUE })
set(0, "Identifier",   { fg = c.COL_CYAN })
set(0, "Type",         { fg = c.COL_YELLOW })
set(0, "Constant",     { fg = c.COL_RED })

-- ── search ───────────────────────────
set(0, "Search",       { fg = c.COL_BG, bg = c.COL_YELLOW })
set(0, "IncSearch",    { fg = c.COL_BG, bg = c.COL_ACCENT })

-- ── diagnostics (LSP) ───────────────
set(0, "DiagnosticError", { fg = c.COL_RED })
set(0, "DiagnosticWarn",  { fg = c.COL_YELLOW })
set(0, "DiagnosticInfo",  { fg = c.COL_BLUE })
set(0, "DiagnosticHint",  { fg = c.COL_CYAN })

-- ── misc ────────────────────────────
set(0, "MatchParen",   { fg = c.COL_ACCENT, bold = true })
