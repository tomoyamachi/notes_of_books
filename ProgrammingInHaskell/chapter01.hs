import Prelude hiding(product)
product[] = 1
product (x:xs) = x * product xs


n = a `div` (length xs)
    where
      a = 10
      xs = [1,2,3,4,5]

add ::(Int,Int) -> Int
add (x,y) = x + y

add' ::Int -> Int -> Int
add' x y = x + y

scnd xs = head (tail xs)
p3_2_2 (x,y) = (y,x)
p3_2_3 x y =(x,y)
p3_2_4 x = x * 2
p3_2_5 f x = f (f x)

count := 0
total := 0
repeat
  count := count + 1
  total := total + count
until
  count = n

double x = x + x
-- sum[] = 0
-- sum(x:xs) = x + sum xs
qsort[] = []
qsort(x:xs) = qsort smaller ++ [x] ++ qsort larger
  where
    smaller = [a|a<-xs,a<=x]
    larger = [b|b<-xs,b>x]


n = a `div` length xs
    where
      a = 10
      xs = [1,2,3,4,5]