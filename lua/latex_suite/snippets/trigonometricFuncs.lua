return {
  { trigger = [[\\sinc]], replacement = "\\operatorname{sinc}$0", options = "rmA", description = "sinc function" },
  {
    trigger = [[(^|[^\\])(arcsin|sin|arccos|cos|arctan|tan|csc|sec|cot)]],
    replacement = "[[0]]\\[[1]]",
    options = "rmA",
    description = "Add backslash before trig funcs",
  },
  {
    trigger = [[\\(arcsin|sin|arccos|cos|arctan|tan|csc|sec|cot)([A-Za-bd-gi-z])]],
    replacement = "\\[[0]] [[1]]",
    options = "rmA",
    description = "Add space after trig funcs. Skips letters c, h to allow sinc, sinh, cosh, etc.",
  },
  {
    trigger = [[\\(sinh|cosh|tanh|coth)([A-Za-z])]],
    replacement = "\\[[0]] [[1]]",
    options = "rmA",
    description = "Add space after hyperbolic trig funcs",
  },
  {
    trigger = [[(arccsc|arcsec|arccot)]],
    replacement = "\\operatorname{[[0]]}$0",
    options = "rmA",
    description = "Inverse trig functions, Are not built-in MathJax functions",
    priority = 1,
  },
}
