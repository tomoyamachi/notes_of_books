import Data.Char
import Monad
import Char

--import Text.Parsec
twice :: (a -> a) -> a -> a
twice f x = f $ f x

compose :: [a -> a] -> (a -> a)
compose = foldr (.) id

--reverseR = foldr snoc []

suml = sum' 0
       where
         sum' v [] = v
         sum' v (x:xs) = sum' (v+x) xs

sumsqreven = sum.map(^2).filter even

type Bit = Int
bin2int ::[Bit] -> Int
bin2int bits = sum [w*b | (w,b) <- zip weights bits]
               where weights = iterate (*2) 1

bin2int2 = foldr (\x y -> x + 2 * y) 0

int2bin :: Int -> [Bit]
int2bin 0 = []
int2bin n = mod n 2 : int2bin (div n 2)

make8 :: [Bit] -> [Bit]
make8 bits = take 8 (bits ++ repeat 0)

encode :: String -> [Bit]
encode = concat.map (make8.int2bin.ord)

chop8 :: [Bit] -> [[Bit]]
chop8 [] = []
chop8 bits = take 8 bits:chop8 (drop 8 bits)

decode :: [Bit] -> String
decode = map (chr.bin2int).chop8


channel :: [Bit] -> [Bit]
channel = id

transmit ::String -> String
transmit = decode.encode

--[f x| x <- xs,p x]
-- test xs = [x*2 | x <- xs, even x]
-- test2 xs = map (*2) $ filter even xs

--q7_1 xs = map f $ filter p xs

allHigher :: (a -> Bool) -> [a] -> Bool
allHigher func = and.map func

anyHigher :: (a -> Bool) -> [a] -> Bool
anyHigher func = or.map func

takeWhileHigher :: (a -> Bool) -> [a] -> [a]
takeWhileHigher func [] = []
takeWhileHigher func (x:xs) | func x = x:takeWhileHigher func xs
                            | otherwise = []

dropWhileHigher :: (a -> Bool) -> [a] -> [a]
dropWhileHigher func [] = []
dropWhileHigher func (x:xs) | func x = dropWhileHigher func xs
                            | otherwise = (x:xs)

mapR ::(a -> b) -> [a] -> [b]
mapR func list = foldr (\x xs -> ((func x):xs)) [] list

filterR ::(a -> Bool) -> [a] -> [a]
filterR func list = foldr (\x xs -> if func x then x:xs else xs) [] list

q7_4 :: [Int] -> Int
q7_4  = foldl (\x y -> x * 10 + y) 0

add :: (Int,Int) -> Int
add (x,y) = x + y

-- to curry
q7_5_1 :: ((a,b) -> c) -> (a -> b -> c)
q7_5_1 f = \ x y -> f (x,y)

add1 = q7_5_1 add

-- to uncurry
q7_5_2 :: (a -> b -> c) -> ((a,b) -> c)
q7_5_2 f = \(x,y) -> f x y

add2 = q7_5_2 add1

unfold p h t x | p x = []
               | otherwise = h x : unfold p h t (t x)

qmap :: (a -> b) -> [a] -> [b]
qmap f = unfold null (f.head) tail

