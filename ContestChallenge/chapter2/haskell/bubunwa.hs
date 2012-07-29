-- createSet :: Int -> [Int] -> [Int] -> [Int]
-- createSet 0 [] ys = ys
-- createSet n [] ys = ys
-- createSet n (x:xs) ys = p
--                         where p = createSet (n-x) xs (ys++[x])
--                                   createSet n xs ys
powerset :: [a] -> [[a]]
powerset [] = [[]]
powerset (x:xs) = s ++ map (x:) s
                  where s = powerset xs

sumList :: [Int] -> Int
sumList [] = 0
sumList (x:xs) = x + sum xs

--judgePartial :: [Int] -> Int -> [[Int]]
judgePartial xs n = [ "Yes : " ++  show n ++ " sum of " ++ show y | y <- ps , sumList y == n]
                    where ps = powerset xs