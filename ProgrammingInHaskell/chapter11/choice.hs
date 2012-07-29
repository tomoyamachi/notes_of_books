subs :: [a] -> [[a]]
subs [] = [[]]
subs (x:xs) = yss ++ map (x:) yss
              where yss = subs xs

interleave :: a -> [a] -> [[a]]
interleave x [] = [[x]]
interleave x (y:ys) = (x:y:ys): map (y:) (interleave x ys)

perms :: [a] -> [[a]]
perms [] = [[]]
perms (x:xs) = concat (map (interleave x) (perms xs))

split :: [a] -> [([a],[a])]
split [] = []
split [_] =  []
split (x:xs) = ([x],xs):[(x:ls,rs) | (ls,rs) <- split xs ]


choices :: [a] -> [[a]]
choices xs = concat (map perms (subs xs))

choices' :: [a] -> [[a]]
choices' xs = [y| x <- subs xs, y <- perms x]

isChoice :: Eq a => [a] -> [a] -> Bool
isChoice xs [] = False
isChoice [] ys = True
isChoice (x:xs) ys = isChoice xs $ findChoice x ys

findChoice :: Eq a => a -> [a] -> [a]
findChoice x [] = []
findChoice x ys = filter (x/=) ys
