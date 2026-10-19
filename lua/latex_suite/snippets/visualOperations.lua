return {
  -- Visual operations: select text, press <Tab>, then type the trigger.
  { trigger = "A", replacement = "\\left( ${VISUAL} \\right)", options = "mA" },
  { trigger = "U", replacement = "\\underbrace{ ${VISUAL} }_{ $0 }", options = "mA" },
  { trigger = "O", replacement = "\\overbrace{ ${VISUAL} }^{ $0 }", options = "mA" },
  { trigger = "B", replacement = "\\underset{ $0 }{ ${VISUAL} }", options = "mA" },
  { trigger = "C", replacement = "\\cancel{ ${VISUAL} }", options = "mA" },
  { trigger = "K", replacement = "\\cancelto{ $0 }{ ${VISUAL} }", options = "mA" },
  { trigger = "S", replacement = "\\sqrt{ ${VISUAL} }", options = "mA" },
  { trigger = "W", replacement = "\\boxed{ ${VISUAL} }", options = "mA" },
}
