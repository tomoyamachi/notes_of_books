import Data.Char
insert ::Ord a => a -> [a] -> [a]
insert x [] = [x]
insert x (y:ys) | x <= y  = x : y : ys
                | otherwise = y : insert x ys

isort ::Ord a => [a] -> [a]
isort [] = []
isort (x:xs) = insert x (isort xs)

dropRecur :: Int -> [a] -> [a]
dropRecur 0 xs = xs
dropRecur n [] = []
dropRecur n (_:xs) = dropRecur (n-1) xs

evenRecur ::Int ->Bool
evenRecur 0 = True
evenRecur n = oddRecur (n-1)

oddRecur ::Int -> Bool
oddRecur 0 = False
oddRecur n = evenRecur (n-1)

--6_1
(^^^) ::Int -> Int -> Int
base ^^^ 0 = 1
base ^^^ n = base * ( base ^^^ (n-1))

-- 6_2
andR :: [Bool] -> Bool
andR [] = True
andR (x:xs) | x == True = andR xs
            | x == False = False

concatR :: [[a]] -> [a]
concatR [] = []
concatR (x:xs) = x ++ concatR xs

replicateR ::Int -> a -> [a]
replicateR 0 _ = []
replicateR n x = x : replicate (n-1) x

(!!!) :: [a] -> Int -> a
(x:_) !!! 0 = x
(_:xs) !!! n = xs !!! (n-1)

elemR ::Eq a => a -> [a] -> Bool
elemR key [] = False
elemR key (x:xs) | key == x = True
                 | otherwise = elemR key xs

--6_4
merge :: Ord a => [a] -> [a] -> [a]
merge [] [] = []
merge (x:xs) [] = x: merge xs []
merge [] (y:ys) = y: merge [] ys
merge (x:xs) (y:ys) | x >= y = y: merge (x:xs) ys
                    | otherwise = x: merge xs (y:ys)


halveS :: [a]->([a],[a])
halveS x = (take (length x `div` 2) x , drop (length x `div` 2) x)

msort ::Ord a => [a] -> [a]
msort xs = f $ halveS xs
           where
             f ([],zs) = zs
             f (ys,[]) = ys
             f (ys,zs) = merge (msort ys) (msort zs)