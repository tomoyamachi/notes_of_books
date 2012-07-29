reverseFoldl = foldl (\xs x -> x:xs) []

reverseN :: [a] -> [a]
reverseN [] = []
reverseN (x:xs) = reverseN xs ++ [x]

reverse' :: [a] -> [a] -> [a]
reverse' [] ys = ys
reverse' (x:xs) ys = reverse' xs (x:ys)