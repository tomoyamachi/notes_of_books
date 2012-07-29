import Chapter08
import Practice08 hiding(eval)
import Calculate09

-- -- 1

-- readLine2 = get ""
-- get xs = do x <- getChar
--             case x of
--               '\n' -> return xs
--               '\DEL' -> if null xs then
--                           get xs
--                         else
--                           do putStr "\ESC[1D \ESC[1D"
--                              get (init xs)
--               _ -> get (xs ++ [x])

-- 2
-- 3
-- 4
-- 5
-- 6


type Nim = [Int]

height :: Int
height = 5

initial :: Nim
initial = reverse [1..height]

isEnd :: Nim -> Bool
isEnd nim = if sum nim == 0 then True else False

nimBox :: [Int]
nimBox = [0..(height - 1)]

putNim :: [Int] -> Nim -> IO ()
putNim [] nim = putChar '\n'
putNim (n:ns) nim = do putStr (show (n+1) ++ ":")
                       putStar (nim!!n)
                       putChar '\n'
                       putNim ns nim

putStar :: Int -> IO ()
putStar n = putStr $ concat $ replicate n "*"

putCurrentNim nim = putNim nimBox nim

removeNim :: Int -> Int -> Nim -> Nim
removeNim line n nim = [if y == line then x - n else x | (x,y) <- zip nim [1..height]]

getNumber :: String -> IO Int
getNumber str = do putStr str
                   num <- getLine
                   putChar '\n'
                   return (read num::Int)

play :: Int -> Nim -> IO ()
play player nim = if isEnd nim
                  then
                    do putStr "Game won by "
                       putStr (show $ next player)
                  else
                    do putCurrentNim nim
                       putStr "Now playing player "
                       putStr (show player)
                       putChar '\n'
                       lnum <- getNumber "line number? : "
                       rnum <- getNumber "remove num? : "
                       if valid lnum rnum nim
                       then  play (next player) (removeNim lnum rnum nim)
                       else
                         do putStr "valid!!"
                            putChar '\n'
                            play player nim
next :: Int -> Int
next 1 = 2
next 2 = 1

valid :: Int -> Int -> Nim -> Bool
valid line num nim = if line <= height && nim!!(line-1) >= num && num > 0 then True else False