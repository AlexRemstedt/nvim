return {
  -- Automatically convert standalone letters in text to math (except a, A, I).
  -- { trigger = [[([^'])\b([B-HJ-Zb-rt-z])\b([\n\s.,?!:])]], replacement = "[[0]]$[[1]]$[[2]]", options = "rtA" },
  { trigger = [[([A-Za-z])([\d+])([\n\s.,?!:])]], replacement = "$[[0]]_{[[1]]}$[[2]]", options = "rtAw" },

  -- Automatically convert Greek letters in text to math.
  { trigger = "(${GREEK})([\\n\\s.,?!:])", replacement = "$\\[[0]]$[[1]]", options = "rtAw" },

  -- Automatically convert text of the form "x=2" and "x=n+1" to math.
  { trigger = [[([A-Za-z]=\d+)([\n\s.,?!:])]], replacement = "$[[0]]$[[1]]", options = "rtAw" },
  { trigger = [[([A-Za-z]=[A-Za-z][+-]\d+)([\n\s.,?!:])]], replacement = "$[[0]]$[[1]]", options = "rtAw" },
  { trigger = "(${GREEK}=\\d+)([\\n\\s.,?!:])", replacement = "$\\[[0]]$[[1]]", options = "rtAw" },

  -- math inline replacements
  { trigger = "xnn", replacement = "x_{n}", options = "mA" },
  { trigger = "\\xii", replacement = "x_{i}", options = "mA", priority = 1 },
  { trigger = "xjj", replacement = "x_{j}", options = "mA" },
  { trigger = "xp1", replacement = "x_{n+1}", options = "mA" },
  { trigger = "ynn", replacement = "y_{n}", options = "mA" },
  { trigger = "yii", replacement = "y_{i}", options = "mA" },
  { trigger = "yjj", replacement = "y_{j}", options = "mA" },
  { trigger = "jj", replacement = "_{j}", options = "m" },
  { trigger = "ii", replacement = "_{i}", options = "m" },
  { trigger = "nn", replacement = "_{n}", options = "m" },
}
