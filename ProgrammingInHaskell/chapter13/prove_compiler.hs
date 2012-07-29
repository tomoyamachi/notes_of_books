-- 式の型をつくり、式を評価する関数をつくる。
data Expr = Val Int | Add Expr Expr
eval :: Expr -> Int
eval (Val n) = n
eval (Add x y) = eval x + eval y

-- スタックを使って、コンパイルしたあと実行するコードを書く。
type Stack = [Int]
type Code = [Op]
data Op = PUSH Int | ADD  deriving (Show)

-- コンパイル後のコードを評価する関数をつくる。
-- PUSHでスタックの上に新しい整数を置く。ADDはスタック上の2つの整数を加算し、置き換える。
exec :: Code -> Stack -> Stack
exec [] s = s
exec (PUSH n:c) s = exec c (n:s)
exec (ADD :c) (m:n:s) = exec c (n+m:s)

-- 式をコードに翻訳(コンパイル)する関数を定義
comp :: Expr -> Code
comp (Val n) = [PUSH n]
-- ADDの定義より、 y を一番上のスタックにしなければならない。
comp (Add x y) = comp x ++ comp y ++ [ADD]

-- 式 (2+3)+4 をつくる。
e = Add (Add (Val 2) (Val 3)) (Val 4)

