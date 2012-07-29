factors ::Int -> [Int]
factors n = [x| x <- [1..n],mod n x == 0]

find :: Eq a => a -> [(a,b)] -> [b]
find key list = [value|(key',value) <- list,key == key']

q5_7_1 :: Int -> Int
q5_7_1 n = sum [x^2 | x <- [1..n]]

q5_7_2 :: Int -> a -> [a]
q5_7_2 n x = [x| _ <- [1..n]]

q5_7_3 :: Int -> [(Int,Int,Int)]
q5_7_3 n = [(x,y,z)| x <- [1..n-1], y <- [1..n-1], z <- [2..n], x^2 + y^2 == z^2]

q5_7_4 :: Int -> [Int]
q5_7_4 n = [x| x <- [1..n] ,sum (factors x) == x * 2]

q5_5 :: [(Int,Int)]
q5_5 = concat [[(x,y)|y<-[4,5,6]]|x<-[1,2,3]]


q5_7_5 :: Eq a => a -> [a] -> [Int]
q5_7_5 x list = find x (zip list [0..])

scalarproduct :: [Int] -> [Int] -> Int
scalarproduct xs ys = sum [x*y| (x,y) <- zip xs ys]
