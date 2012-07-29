module Practice08 where
import Chapter08
--- problems from here
--1
int :: Parser Int
int = do char '-'
         n <- nat
         return (-n)
       +++ nat
--2
comment :: Parser ()
comment = do string "--"
             many (sat (/= '\n'))
             return ()

--3 2+3+4
-- 別紙

--4
-- 別紙

--5
-- 改良後の規則だと、expr,term,factorそれぞれ一度ずつしか呼ばれない。
-- 改良前の場合、exprが単なるtermだった場合、termを2度評価する。
-- 最終的にはすべてnatの要素になるので、4倍以上効率の差がある

--6
expr :: Parser Int
expr = do t <- term
          do symbol "+"
             e <- expr
             return (t + e)
           +++ do symbol "-"
                  e <- expr
                  return (t - e)
           +++ return t

-- term :: Parser Int
-- term = do f <- factor
--           do symbol "*"
--              t <- term
--              return (f * t)
--            +++ do symbol "/"
--                   t <- term
--                   return (f `div` t)
--            +++ return f

factor :: Parser Int
factor = do symbol "("
            e <- expr
            symbol ")"
            return e
          +++ natural
eval :: String -> Int
eval xs = case parse expr xs of
  [(n,[])] -> n
  [(_,out)] -> error("unused input" ++ out)
  [] -> error "invalid"

--7

term :: Parser Int
term = do r <- root
          do symbol "*"
             t <- term
             return (r * t)
           +++ do symbol "/"
                  t <- term
                  return (r `div` t)
           +++ return r

root :: Parser Int
root = do f <- factor
          do symbol "^"
             r <- root
             return (f ^ r)
           +++ return f

--8
-- a
-- b
-- c
-- d
