-- file: ch01/WC.hs
-- lines beginning with "--" are comments

lineCount input =
  show (length (lines input)) ++ "\n"

wordCount input =
  show (length (words input)) ++ "\n"

charCount input =
  show (length input) ++ "\n"

main = interact lineCount
