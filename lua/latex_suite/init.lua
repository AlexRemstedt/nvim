-- Port of the Obsidian LaTeX Suite snippets to LuaSnip, for tex buffers.
--
-- Snippet files in `latex_suite/snippets/` keep the LaTeX Suite format:
--   { trigger = ..., replacement = ..., options = "mA", priority = 0, description = ... }
-- Options: m (any math), M (display math), n (inline math), t (text), A (auto),
-- r (regex, ECMAScript syntax), w (word boundary). `${VISUAL}` snippets only
-- fire on a selection stored with <Tab> in visual mode.
local M = {}

M.files = {
  "default",
  "brackets",
  "derivativesIntegrals",
  "inlineReplacements",
  "misc",
  "symbols",
  "trigonometricFuncs",
  "units",
  "visualOperations",
}

local INLINE_ZONES = { texMathZoneTI = true, texMathZoneLI = true, texMathZoneEnsured = true }
local WORD_DELIMITERS = "., +-\\\n\t:;!?/{}[]()=~$"

---@return "inline"|"display"|nil
function M.math_kind()
  local ok, stack = pcall(vim.fn["vimtex#syntax#stack"])
  if not ok then
    return nil
  end
  -- Same rule as vimtex#syntax#in_mathzone: the innermost relevant group decides.
  for i = #stack, 1, -1 do
    local name = stack[i]
    if name:match("^texMathText") or name:match("^texMathTag") or name:match("^texRefArg") then
      return nil
    elseif name:match("^texMathZone") then
      for _, outer in ipairs(stack) do
        if INLINE_ZONES[outer] then
          return "inline"
        end
      end
      return "display"
    end
  end
  return nil
end

function M.in_math()
  return M.math_kind() ~= nil
end

local function has_selection()
  return vim.b.LUASNIP_SELECT_RAW ~= nil
end

local function mode_condition(options)
  local m, M_, n, t = options:find("m"), options:find("M"), options:find("n"), options:find("t")
  if not (m or M_ or n or t) then
    return nil
  end
  return function()
    local kind = M.math_kind()
    if kind == nil then
      return t ~= nil
    end
    return m ~= nil or (M_ ~= nil and kind == "display") or (n ~= nil and kind == "inline")
  end
end

local function word_condition(line_to_cursor, matched)
  local before = line_to_cursor:sub(-#matched - 1, -#matched - 1)
  return #line_to_cursor == #matched or WORD_DELIMITERS:find(before, 1, true) ~= nil
end

-- Translate a LaTeX Suite replacement into LSP snippet syntax.
-- LaTeX Suite visits $0 first, LSP visits $0 last, so every tabstop shifts by one.
local function to_lsp(repl)
  local out, i, depth = {}, 1, 0
  while i <= #repl do
    local cap = repl:match("^%[%[(%d+)%]%]", i)
    local stop = repl:match("^%$(%d+)", i)
    local placeholder = repl:match("^%${(%d+):", i)
    local c = repl:sub(i, i)
    if cap then
      out[#out + 1] = "${LS_CAPTURE_" .. (cap + 1) .. "}"
      i = i + #cap + 4
    elseif repl:find("^%${VISUAL}", i) then
      out[#out + 1] = "${LS_SELECT_RAW}"
      i = i + 9
    elseif stop then
      out[#out + 1] = "$" .. (stop + 1)
      i = i + #stop + 1
    elseif placeholder then
      out[#out + 1] = "${" .. (placeholder + 1) .. ":"
      depth = depth + 1
      i = i + #placeholder + 3
    elseif c == "}" and depth > 0 then
      out[#out + 1] = "}"
      depth = depth - 1
      i = i + 1
    else
      out[#out + 1] = (c == "\\" or c == "$" or c == "}") and "\\" .. c or c
      i = i + 1
    end
  end
  return table.concat(out)
end

local function expand_variables(trigger, variables)
  for name, value in pairs(variables) do
    trigger = trigger:gsub(vim.pesc(name), (value:gsub("%%", "%%%%")))
  end
  return trigger
end

local function build(spec, trigger, priority)
  local ls = require("luasnip")
  local options = spec.options or ""
  local mode = mode_condition(options)
  local word = options:find("w") ~= nil
  local visual = type(spec.replacement) == "string" and spec.replacement:find("${VISUAL}", 1, true) ~= nil

  local context = {
    trig = trigger,
    trigEngine = options:find("r") and "ecma" or "plain",
    wordTrig = false,
    priority = priority,
    desc = spec.description,
    hidden = options:find("A") ~= nil,
    condition = function(line_to_cursor, matched)
      return (not visual or has_selection())
        and (not word or word_condition(line_to_cursor, matched))
        and (mode == nil or mode())
    end,
  }

  if type(spec.replacement) == "function" then
    -- Function replacements receive the regex captures and return plain text.
    return ls.snippet(context, {
      ls.function_node(function(_, parent)
        return vim.split(spec.replacement(parent.snippet.captures), "\n")
      end),
      ls.insert_node(0),
    })
  end
  local body = to_lsp(spec.replacement)
  if body:sub(1, 1) == "\n" then
    -- The parser drops a leading line break, so add it as a separate node.
    return ls.snippet(context, { ls.text_node({ "", "" }), ls.parser.parse_snippet(1, body:sub(2)) })
  end
  return ls.parser.parse_snippet(context, body)
end

function M.load()
  local ls = require("luasnip")
  local variables = require("latex_suite.variables")
  local entries = {}
  for _, file in ipairs(M.files) do
    for _, spec in ipairs(require("latex_suite.snippets." .. file)) do
      local trigger = expand_variables(spec.trigger, variables)
      entries[#entries + 1] = { spec = spec, trigger = trigger, index = #entries }
    end
  end
  -- LaTeX Suite tries snippets by priority, then longest trigger first.
  table.sort(entries, function(a, b)
    local pa, pb = a.spec.priority or 0, b.spec.priority or 0
    if pa ~= pb then
      return pa > pb
    elseif #a.trigger ~= #b.trigger then
      return #a.trigger > #b.trigger
    end
    return a.index < b.index
  end)

  local snippets, autosnippets = {}, {}
  for rank, entry in ipairs(entries) do
    local list = (entry.spec.options or ""):find("A") and autosnippets or snippets
    list[#list + 1] = build(entry.spec, entry.trigger, 1000 + #entries - rank)
  end
  M.snippets = snippets
  ls.add_snippets("tex", snippets, { key = "latex_suite" })
  ls.add_snippets("tex", autosnippets, { type = "autosnippets", key = "latex_suite_auto" })
end

-- Expand a non-auto LaTeX Suite snippet at the cursor (other snippet sources are
-- left alone, like Tab in Obsidian). Returns whether one was expanded.
function M.expand()
  local ls = require("luasnip")
  local line = vim.api.nvim_get_current_line():sub(1, vim.api.nvim_win_get_cursor(0)[2])
  for _, snip in ipairs(M.snippets or {}) do
    local params = snip:matches(line)
    if params then
      local row, col = unpack(vim.api.nvim_win_get_cursor(0))
      ls.snip_expand(snip, {
        expand_params = params,
        clear_region = params.clear_region or { from = { row - 1, col - #params.trigger }, to = { row - 1, col } },
      })
      return true
    end
  end
  return false
end

-- Let the bracket snippets do the pairing inside math; keep mini.pairs elsewhere.
function M.setup_buffer(buf)
  for _, pair in ipairs({ "()", "[]", "{}" }) do
    local open, close = pair:sub(1, 1), pair:sub(2, 2)
    vim.keymap.set("i", open, function()
      if M.in_math() then
        return open
      end
      return _G.MiniPairs and MiniPairs.open(pair, "[^\\].") or open
    end, { buffer = buf, expr = true, replace_keycodes = false, desc = "LaTeX Suite pair" })
    vim.keymap.set("i", close, function()
      local col = vim.api.nvim_win_get_cursor(0)[2]
      if M.in_math() and vim.api.nvim_get_current_line():sub(col + 1, col + 1) == close then
        return vim.keycode("<Right>")
      end
      return _G.MiniPairs and MiniPairs.close(pair, "[^\\].") or close
    end, { buffer = buf, expr = true, replace_keycodes = false, desc = "LaTeX Suite pair" })
  end
  vim.keymap.set("i", '"', function()
    if M.in_math() then
      return '"'
    end
    return _G.MiniPairs and MiniPairs.closeopen('""', "[^\\].") or '"'
  end, { buffer = buf, expr = true, replace_keycodes = false, desc = "LaTeX Suite pair" })
end

return M
