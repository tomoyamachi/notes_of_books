absif n = if n >= 0 then n else -(n)

absbar n | n >= 0 = 0
         | otherwise = -(n)

(&) :: Bool -> Bool ->Bool
True & True = True
_ & _ = False

b &&& c | b == c = b
        | otherwise =False

myfst ::(a,b)->a
myfst (x,_) =x

sconst :: a -> (b -> a)
sconst x = \_ -> x

odds ::Int -> [Int]
odds n = map f [0..n-1]
         where f x = x * 2 + 1
odds' n = map (\x -> x * 2 + 1) [0..n-1]

myhoge :: [Int] -> Int
myhoge [x,y,z] = 3
myhoge (x:xs) = 4

ほげ :: Int
ほげ = 1

hoge7 :: [Int] -> Int
hoge7 [] = 0
hoge7 (x:xs) = x + hoge7 xs

-- 第4章 練習問題
halve :: [a]->([a],[a])
halve x | length x `mod` 2 == 0 = (take (length x `div` 2) x , drop (length x `div` 2) x)
        | otherwise = undefined

safetailA ::[a] -> [a]
safetail  x = if x == [] then [] else tail x
safetailA xs = if null xs then [] else tail xs
safetailB ::[a] -> [a]
safetailB xs | null xs = []
            | otherwise = tail xs

safetailC :: [a] -> [a]
safetailC [] = []
safetailC x = tail x

mult = (\x -> (\y -> (\z -> x*y*z)))
