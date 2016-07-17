-- file: ch03/NestedLets.hs

-- Nesting let with different names for bound expressions:
foo = let a = 1
      in let b = 2
         in a + b

-- Nesting let with same name for expressions (shadowing):
bar = let x = 1
      in (let x = "foo" in x, x)

-- Shadowing function arguments:
quux a = let a = "foo"
         in a ++ "eek!"
