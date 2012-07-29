import Char
import Monad

newtype Parser a              =  Parser (String -> [(a,String)])

instance Monad Parser where
   return v                   =  Parser (\inp -> [(v,inp)])
   p >>= f                    =  Parser (\inp -> case parse p inp of
                                               []        -> []
                                               [(v,out)] -> parse (f v) out)

instance MonadPlus Parser where
   mzero                      =  Parser (\inp -> [])
   p `mplus` q                =  Parser (\inp -> case parse p inp of
                                               []        -> parse q inp
                                               [(v,out)] -> [(v,out)])

failure                       :: Parser a
failure                       =  mzero

item                          :: Parser Char
item                          =  Parser (\inp -> case inp of
                                               []     -> []
                                               (x:xs) -> [(x,xs)])

parse                         :: Parser a -> String -> [(a,String)]
parse (Parser p) inp               =  p inp


-- -- ret :: a -> Parser a
-- -- ret v = \inp -> [(v,inp)]

(+++) :: Parser a -> Parser a -> Parser a
p +++ q = p `mplus` q
-- p +++ q = \inp -> case parse p inp of
--                     [] -> parse q inp
--                     [(v,out)] -> [(v,out)]


sat :: (Char -> Bool) -> Parser Char
sat p = do x <- item
           if p x then return x else failure

digit ::Parser Char
digit = sat isDigit

many :: Parser a -> Parser [a]
many p = many1 p +++ return []

-- 1度は適用(パース)が成功しなければ[]を返す
many1 :: Parser a -> Parser [a]
many1 p = do v <- p
             vs <- many p
             return (v:vs)

nat :: Parser Int
nat = do xs <- many1 digit
         return (read xs)

space :: Parser ()
space = do many (sat isSpace)
           return ()

char :: Char -> Parser Char
char x = sat (== x)

string ::String -> Parser String
string [] = return []
string (x:xs) = do char x
                   string xs
                   return (x:xs)

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
token :: Parser a -> Parser a
token p = do space
             v <- p
             space
             return v

natural :: Parser Int
natural = token nat

symbol :: String -> Parser String
symbol xs = token (string xs)

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
