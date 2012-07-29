isZero :: Int -> Bool
isZero 0 = True
isZero n = False

isZero :: Int -> Bool
isZero 0 = True
isZero n | n /= 0 =False

replicate :: Int -> a -> [a]
replicate 0 _ = []
replicate n c = c : replicate (n-1) c

length (replicate 0 c)
       = length []
       = 0

length (replicate x c) = x

length (replicate (x+1) c)
       = length (c:replicate x c)
       = 1 + length (replicate x c)
       = 1 + x
       = x + 1