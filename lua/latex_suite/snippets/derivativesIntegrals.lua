return {
  { trigger = "par", replacement = "\\frac{ \\partial ${0:y} }{ \\partial ${1:x} } $2", options = "m" },
  {
    trigger = [[pa([A-Za-z])([A-Za-z])]],
    replacement = "\\frac{ \\partial [[0]] }{ \\partial [[1]] } ",
    options = "rm",
  },

  { trigger = [[(^|[^\\])int]], replacement = "[[0]]\\int", options = "rmA", priority = -1 },
  { trigger = "\\int", replacement = "\\int $0 \\, d${1:x} $2", options = "m" },
  { trigger = "dint", replacement = "\\int_{${0:0}}^{${1:1}} $2 \\, \\mathrm{d}${3:x} $4", options = "mA" },
  { trigger = "oint", replacement = "\\oint", options = "mA" },
  { trigger = "iint", replacement = "\\iint_{$0} $1 \\, \\mathrm{d}${2:x} $3", options = "mA" },
  { trigger = "iiint", replacement = "\\iiint_{$0} $1 \\, \\mathrm{d}${2:x} $3", options = "mA" },
  { trigger = "oinf", replacement = "\\int_{0}^{\\infty} $0 \\, d${1:x} $2", options = "mA" },
  { trigger = "infi", replacement = "\\int_{-\\infty}^{\\infty} $0 \\, d${1:x} $2", options = "mA" },
  { trigger = [[d([\w])]], replacement = "\\mathrm{d}[[0]] $0", options = "rm" },
  { trigger = [[d([\w])d([\w])]], replacement = "\\frac{\\mathrm{d}[[0]]$0}{\\mathrm{d}[[1]]$1}", options = "rmA" },
  {
    trigger = [[([\d])d([\w])d([\w])]],
    replacement = "\\frac{\\mathrm{d}^{[[0]]}[[1]]$0}{\\mathrm{d}[[2]]^{[[0]]}$1}",
    options = "rmA",
  },
  { trigger = [[dd([\w])]], replacement = "\\frac{\\mathrm{d}}{\\mathrm{d}[[0]]$0}", options = "rmA" },
  {
    trigger = [[([\d])dd([\w])]],
    replacement = "\\frac{\\mathrm{d}^{[[0]]}$1}{\\mathrm{d}[[1]]^{[[0]]}$2}",
    options = "rmA",
  },
}
