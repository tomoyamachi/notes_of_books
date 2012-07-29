import Data.List
type Point = (Int,Int)
type Queue = [[Point]]
type Visited = [Point]
type Grid = [[Bool]]
type Maze = [String]
--付近のポイントをさがす。
neighbors :: Point -> [Point]
neighbors (x,y) = [(x-1,y),(x+1,y),(x,y-1),(x,y+1)]


--スタート位置を探す。
searchStart :: Int -> Maze -> (Maybe Int, Int)
searchStart _ [] = (Nothing,0)
searchStart n (x:xs) | findIndex (== 'S') x /= Nothing   = (findIndex (== 'S') x,n)
                     | otherwise = searchStart (n+1) xs

mazeStartPoint = searchStart 0 maze

printMaze maze = mapM_ print maze
maze =  ["#S######.#",
         "......#..#",
         ".#.##.##.#",
         ".#........",
         "##.##.####",
         "....#....#",
         ".#######.#",
         "....#.....",
         ".####.###.",
         "....#...G#"]
smallMaze = ["#S###",
             ".....",
             "..###",
             "....G"]