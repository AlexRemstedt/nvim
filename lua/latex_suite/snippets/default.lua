return {
  -- Math mode
  { trigger = "mk", replacement = "$$0$", options = "tA" },
  { trigger = "dm", replacement = "\\[\n\t$0\n\\]", options = "tAw" },
  { trigger = [[(?<=\S.*)dm]], replacement = "\n\\[\n\t$0\n\\]", options = "rtAw", priority = 1 },

  { trigger = [[(^|[^\\])beg]], replacement = "[[0]]\\begin{$0}\n\t$1\n\\end{$0}", options = "rMA" },
  { trigger = [[(^|[^\\])beg]], replacement = "[[0]]\\begin{$0} $1 \\end{$0}", options = "rnA" },

  -- Greek letters
  { trigger = "@a", replacement = "\\alpha", options = "mA" },
  { trigger = "@b", replacement = "\\beta", options = "mA" },
  { trigger = "@g", replacement = "\\gamma", options = "mA" },
  { trigger = "@G", replacement = "\\Gamma", options = "mA" },
  { trigger = "@d", replacement = "\\delta", options = "mA" },
  { trigger = "@D", replacement = "\\Delta", options = "mA" },
  { trigger = "@e", replacement = "\\epsilon", options = "mA" },
  { trigger = ":e", replacement = "\\varepsilon", options = "mA" },
  { trigger = "@z", replacement = "\\zeta", options = "mA" },
  { trigger = "@t", replacement = "\\theta", options = "mA" },
  { trigger = "@T", replacement = "\\Theta", options = "mA" },
  { trigger = ":t", replacement = "\\vartheta", options = "mA" },
  { trigger = "@i", replacement = "\\iota", options = "mA" },
  { trigger = "@k", replacement = "\\kappa", options = "mA" },
  { trigger = "@l", replacement = "\\lambda", options = "mA" },
  { trigger = "@L", replacement = "\\Lambda", options = "mA" },
  { trigger = "@s", replacement = "\\sigma", options = "mA" },
  { trigger = "@S", replacement = "\\Sigma", options = "mA" },
  { trigger = "@u", replacement = "\\upsilon", options = "mA" },
  { trigger = "@U", replacement = "\\Upsilon", options = "mA" },
  { trigger = "@o", replacement = "\\omega", options = "mA" },
  { trigger = "@O", replacement = "\\Omega", options = "mA" },
  { trigger = "ome", replacement = "\\omega", options = "mA" },
  { trigger = "Ome", replacement = "\\Omega", options = "mA" },

  -- Text environment
  { trigger = "text", replacement = "\\text{$0}$1", options = "mA" },
  { trigger = '"', replacement = "\\text{$0}$1", options = "mA" },

  -- Basic operations
  { trigger = "sr", replacement = "^{2}", options = "mA" },
  { trigger = "cb", replacement = "^{3}", options = "mA" },
  { trigger = "rd", replacement = "^{$0}$1", options = "mA" },
  { trigger = "_", replacement = "_{$0}$1", options = "mA" },
  { trigger = "sts", replacement = "_\\text{$0}", options = "mA" },
  { trigger = "sq", replacement = "\\sqrt{ $0 }$1", options = "mA" },
  { trigger = "//", replacement = "\\frac{$0}{$1}$2", options = "mA" },
  { trigger = "ee", replacement = "e^{ $0 }$1", options = "mA" },
  { trigger = "invs", replacement = "^{-1}", options = "mA" },

  { trigger = [[(^|[^\\])(exp|log|ln)]], replacement = "[[0]]\\[[1]]", options = "rmA" },
  { trigger = "conj", replacement = "^{*}", options = "mA" },
  { trigger = "Re", replacement = "\\mathrm{Re}", options = "mA" },
  { trigger = "Im", replacement = "\\mathrm{Im}", options = "mA" },
  { trigger = "bf", replacement = "\\mathbf{$0}", options = "mA" },
  { trigger = "rm", replacement = "\\mathrm{$0}$1", options = "mA" },

  -- Linear algebra
  { trigger = [[(^|[^\\])(det)]], replacement = "[[0]]\\[[1]]", options = "rmA" },
  { trigger = "trace", replacement = "\\mathrm{Tr}", options = "mA" },

  -- More operations
  { trigger = "([a-zA-Z])hat", replacement = "\\hat{[[0]]}", options = "rmA" },
  { trigger = "([a-zA-Z])bar", replacement = "\\bar{[[0]]}", options = "rmA" },
  { trigger = "([a-zA-Z])dot", replacement = "\\dot{[[0]]}", options = "rmA", priority = -1 },
  { trigger = "([a-zA-Z])ddot", replacement = "\\ddot{[[0]]}", options = "rmA", priority = 1 },
  { trigger = "([a-zA-Z])tilde", replacement = "\\tilde{[[0]]}", options = "rmA" },
  { trigger = "([a-zA-Z])und", replacement = "\\underline{[[0]]}", options = "rmA" },
  { trigger = "([a-zA-Z])vec", replacement = "\\vec{[[0]]}", options = "rmA" },
  { trigger = "([a-zA-Z]),\\.", replacement = "\\mathbf{[[0]]}", options = "rmA" },
  { trigger = "([a-zA-Z])\\.,", replacement = "\\mathbf{[[0]]}", options = "rmA" },
  { trigger = "\\\\(${GREEK}),\\.", replacement = "\\boldsymbol{\\[[0]]}", options = "rmA" },
  { trigger = "\\\\(${GREEK})\\.,", replacement = "\\boldsymbol{\\[[0]]}", options = "rmA" },

  { trigger = "hat", replacement = "\\hat{$0}$1", options = "mA" },
  { trigger = "bar", replacement = "\\bar{$0}$1", options = "mA" },
  { trigger = "dot", replacement = "\\dot{$0}$1", options = "mA", priority = -1 },
  { trigger = "ddot", replacement = "\\ddot{$0}$1", options = "mA" },
  { trigger = "cdot", replacement = "\\cdot", options = "mA" },
  { trigger = "tilde", replacement = "\\tilde{$0}$1", options = "mA" },
  { trigger = "und", replacement = "\\underline{$0}$1", options = "mA" },
  { trigger = "vec", replacement = "\\vec{$0}$1", options = "mA" },
  {
    trigger = "pmod",
    replacement = "\\pmod{${0:n}}$1",
    options = "mA",
    description = "Parenthesized modulo (\\pmod{n})",
  },

  -- Auto letter subscript
  --
  -- x3 -> x_{3}, \alpha3 -> \alpha_{3}
  { trigger = "(\\\\${GREEK}|[A-Za-z])(\\d)", replacement = "[[0]]_{[[1]]}", options = "rmA", priority = -1 },
  -- x_{3}4 -> x_{34}, \alpha_{3}4 -> \alpha_{34}
  {
    trigger = "(\\\\${GREEK}|[A-Za-z])_{(\\d+)}(\\d)",
    replacement = "[[0]]_{[[1]][[2]]}",
    options = "rmA",
    priority = -1,
  },
  -- \dot{x}3 -> \dot{x}_{3}, \dot{\alpha}3 -> \dot{\alpha}_{3}
  {
    trigger = "\\\\(${ACCENT})\\{(\\\\${GREEK}|[A-Za-z])\\}(\\d)",
    replacement = "\\[[0]]{[[1]]}_{[[2]]}",
    options = "rmA",
    priority = -1,
  },
  -- \dot{x}_{3}4 -> \dot{x}_{34}
  {
    trigger = "\\\\(${ACCENT})\\{(\\\\${GREEK}|[A-Za-z])\\}_\\{(\\d+)\\}(\\d)",
    replacement = "\\[[0]]{[[1]]}_{[[2]][[3]]}",
    options = "rmA",
    priority = -1,
  },
  -- \dot{\vec{a}}3 -> \dot{\vec{a}}_{3}
  {
    trigger = "\\\\(${ACCENT})\\{\\\\(${ACCENT})\\{(\\\\${GREEK}|[A-Za-z])\\}\\}(\\d)",
    replacement = "\\[[0]]{\\[[1]]{[[2]]}}_{[[3]]}",
    options = "rmA",
    priority = -1,
  },
  -- \dot{\vec{a}}_{3}4 -> \dot{\vec{a}}_{34}
  {
    trigger = "\\\\(${ACCENT})\\{\\\\(${ACCENT})\\{(\\\\${GREEK}|[A-Za-z])\\}\\}_\\{(\\d+)\\}(\\d)",
    replacement = "\\[[0]]{\\[[1]]{[[2]]}}_{[[3]][[4]]}",
    options = "rmA",
    priority = -1,
  },

  { trigger = "xnn", replacement = "x_{n}", options = "mA" },
  { trigger = "\\xii", replacement = "x_{i}", options = "mA", priority = 1 },
  { trigger = "xjj", replacement = "x_{j}", options = "mA" },
  { trigger = "xp1", replacement = "x_{n+1}", options = "mA" },
  { trigger = "ynn", replacement = "y_{n}", options = "mA" },
  { trigger = "yii", replacement = "y_{i}", options = "mA" },
  { trigger = "yjj", replacement = "y_{j}", options = "mA" },

  -- Symbols
  { trigger = "ooo", replacement = "\\infty", options = "mA" },
  { trigger = "sum", replacement = "\\sum", options = "mA" },
  { trigger = "prod", replacement = "\\prod", options = "mA" },
  { trigger = "\\sum", replacement = "\\sum_{${0:i}=${1:1}}^{${2:N}} $3", options = "m" },
  { trigger = "\\prod", replacement = "\\prod_{${0:i}=${1:1}}^{${2:N}} $3", options = "m" },
  { trigger = "lim", replacement = "\\lim_{ ${0:n} \\to ${1:\\infty} } $2", options = "mA" },
  { trigger = "+-", replacement = "\\pm", options = "mA" },
  { trigger = "-+", replacement = "\\mp", options = "mA" },
  { trigger = "...", replacement = "\\dots", options = "mA" },
  { trigger = "nabl", replacement = "\\nabla", options = "mA" },
  { trigger = "xx", replacement = "\\times", options = "mA" },
  { trigger = "**", replacement = "\\cdot", options = "mA" },
  { trigger = "para", replacement = "\\parallel", options = "mA" },

  { trigger = "===", replacement = "\\equiv", options = "mA" },
  { trigger = "!=", replacement = "\\neq", options = "mA" },
  { trigger = ">=", replacement = "\\geq", options = "mA" },
  { trigger = "<=", replacement = "\\leq", options = "mA" },
  { trigger = ">>", replacement = "\\gg", options = "mA" },
  { trigger = "<<", replacement = "\\ll", options = "mA" },
  { trigger = "simm", replacement = "\\sim", options = "mA" },
  { trigger = "sim=", replacement = "\\simeq", options = "mA" },
  { trigger = "prop", replacement = "\\propto", options = "mA" },

  { trigger = "<->", replacement = "\\leftrightarrow ", options = "mA" },
  { trigger = "->", replacement = "\\to", options = "mA" },
  { trigger = "!>", replacement = "\\mapsto", options = "mA" },
  { trigger = "=>", replacement = "\\implies", options = "mA" },
  { trigger = "=<", replacement = "\\impliedby", options = "mA" },

  { trigger = "and", replacement = "\\cap", options = "mA" },
  { trigger = "orr", replacement = "\\cup", options = "mA" },
  { trigger = "inn", replacement = "\\in", options = "mA" },
  { trigger = "notin", replacement = "\\not\\in", options = "mA" },
  { trigger = "\\\\\\", replacement = "\\setminus", options = "mA" },
  { trigger = "sub=", replacement = "\\subseteq", options = "mA" },
  { trigger = "sup=", replacement = "\\supseteq", options = "mA" },
  { trigger = "eset", replacement = "\\emptyset", options = "mA" },
  { trigger = "set", replacement = "\\{ $0 \\}$1", options = "mA" },
  { trigger = "e\\xi sts", replacement = "\\exists", options = "mA", priority = 1 },

  -- Add backslash before Greek letters and symbols
  {
    trigger = "(^|[^\\\\])(${GREEK})",
    replacement = "[[0]]\\[[1]]",
    options = "rmA",
    description = "Add backslash before Greek letters",
  },
  {
    trigger = "(^|[^\\\\])(${SYMBOL})",
    replacement = "[[0]]\\[[1]]",
    options = "rmA",
    description = "Add backslash before symbols",
  },

  -- Insert space after Greek letters and symbols
  { trigger = "\\\\(${GREEK}|${SYMBOL}|${MORE_SYMBOLS})([A-Za-z])", replacement = "\\[[0]] [[1]]", options = "rmA" },
  { trigger = "\\\\(${GREEK}|${SYMBOL}) sr", replacement = "\\[[0]]^{2}", options = "rmA" },
  { trigger = "\\\\(${GREEK}|${SYMBOL}) cb", replacement = "\\[[0]]^{3}", options = "rmA" },
  { trigger = "\\\\(${GREEK}|${SYMBOL}) rd", replacement = "\\[[0]]^{$0}$1", options = "rmA" },
  { trigger = "\\\\(${GREEK}) hat", replacement = "\\hat{\\[[0]]}", options = "rmA" },
  { trigger = "\\\\(${GREEK}) dot", replacement = "\\dot{\\[[0]]}", options = "rmA" },
  { trigger = "\\\\(${GREEK}) bar", replacement = "\\bar{\\[[0]]}", options = "rmA" },
  { trigger = "\\\\(${GREEK}) vec", replacement = "\\vec{\\[[0]]}", options = "rmA" },
  { trigger = "\\\\(${GREEK}) tilde", replacement = "\\tilde{\\[[0]]}", options = "rmA" },
  { trigger = "\\\\(${GREEK}) und", replacement = "\\underline{\\[[0]]}", options = "rmA" },

  -- Physics
  { trigger = "kbt", replacement = "k_{B}T", options = "mA" },
  { trigger = "msun", replacement = "M_{\\odot}", options = "mA" },

  -- Quantum mechanics
  { trigger = "dag", replacement = "^{\\dagger}", options = "mA" },
  { trigger = "o+", replacement = "\\oplus ", options = "mA" },
  { trigger = "ox", replacement = "\\otimes ", options = "m" },
  { trigger = "bra", replacement = "\\bra{$0} $1", options = "mA" },
  { trigger = "ket", replacement = "\\ket{$0} $1", options = "mA" },
  { trigger = "brk", replacement = "\\braket{ $0 | $1 } $2", options = "mA" },
  { trigger = "outer", replacement = "\\ket{${0:\\psi}} \\bra{${0:\\psi}} $1", options = "mA" },

  -- Chemistry
  { trigger = "pu", replacement = "\\pu{ $0 }", options = "mA" },
  { trigger = "cee", replacement = "\\ce{ $0 }", options = "mA" },
  { trigger = "he4", replacement = "{}^{4}_{2}He ", options = "mA" },
  { trigger = "he3", replacement = "{}^{3}_{2}He ", options = "mA" },
  { trigger = "iso", replacement = "{}^{${0:4}}_{${1:2}}${2:He}", options = "mA" },

  -- Environments
  {
    trigger = [[([pbBvV]mat)]],
    replacement = "\\begin{[[0]]rix}\n$0\n\\end{[[0]]rix}",
    options = "rMA",
    description = "Matrix environments with new lines",
  },
  {
    trigger = [[(matrix|cases|align|array)]],
    replacement = "\\begin{[[0]]}\n$0\n\\end{[[0]]}",
    options = "rMA",
    description = "Miscellaneous environments with new lines",
  },
  { trigger = [[([pbBvV]mat)]], replacement = "\\begin{[[0]]rix}$0\\end{[[0]]rix}", options = "rnA" },
  { trigger = [[(matrix|cases|align|array)]], replacement = "\\begin{[[0]]}$0\\end{[[0]]}", options = "rnA" },

  -- Snippet replacements can have placeholders.
  {
    trigger = "tayl",
    replacement = "${0:f}(${1:x} + ${2:h}) = ${0:f}(${1:x}) + ${0:f}'(${1:x})${2:h} + ${0:f}''(${1:x}) \\frac{${2:h}^{2}}{2!} + \\dots$3",
    options = "mA",
    description = "Taylor expansion",
  },

  {
    trigger = [[iden(\d)]],
    replacement = function(captures)
      local n = tonumber(captures[1])
      local rows = {}
      for j = 1, n do
        local row = {}
        for i = 1, n do
          row[i] = i == j and "1" or "0"
        end
        rows[j] = table.concat(row, " & ")
      end
      return "\\begin{pmatrix}\n" .. table.concat(rows, " \\\\\n") .. "\n\\end{pmatrix}"
    end,
    options = "rmA",
    description = "N x N identity matrix",
  },
}
