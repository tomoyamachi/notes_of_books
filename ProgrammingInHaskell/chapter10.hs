data Shape = Circle Float | Rect Float Float

data Nat = Zero | Succ Nat

nat2int :: Nat -> Int
nat2int Zero = 0
nat2int (Succ n) = 1 + nat2int n

int2nat :: Int -> Nat
int2nat 0 = Zero
int2nat n = Succ (int2nat (n-1))



add :: Nat -> Nat -> Nat
add m n = int2nat (nat2int m + nat2int n)

-- add Zero n = n
-- add (Succ m) n = Succ (add m n)

data Tree = Leaf Int | Node Tree Int Tree

t :: Tree
t = Node (Node (Leaf 1) 3 (Leaf 4)) 5 (Node (Leaf 6) 7 (Leaf 9))

flatten :: Tree -> [Int]
flatten (Leaf n) = [n]
flatten (Node l n r) = flatten l ++ [n] ++ flatten r



type Assoc k v = [(k,v)]
data Prop = Const Bool | Var Char | Not Prop | And Prop Prop | Imply Prop Prop

p1 :: Prop
p1 = And (Var 'A') (Not (Var 'A'))
p2 :: Prop
p2 = Imply (And (Var 'A') (Var 'B'))(Var 'A')

type Subst = Assoc Char Bool

find                          :: Eq k => k -> Assoc k v -> v
find k t                      =  head [v | (k',v) <- t, k == k']

eval                          :: Subst -> Prop -> Bool
eval _ (Const b)              =  b
eval s (Var x)                =  find x s
eval s (Not p)                =  not (eval s p)
eval s (And p q)              =  eval s p && eval s q
eval s (Imply p q)            =  eval s p <= eval s q

vars                          :: Prop -> [Char]
vars (Const _)                =  []
vars (Var x)                  =  [x]
vars (Not p)                  =  vars p
vars (And p q)                =  vars p ++ vars q
vars (Imply p q)              =  vars p ++ vars q

bools                         :: Int -> [[Bool]]
bools 0                       =  [[]]
bools n                   =  map (False:) bss ++ map (True:) bss
                                 where bss = bools (n-1)

rmdups                        :: Eq a => [a] -> [a]
rmdups []                     =  []
rmdups (x:xs)                 =  x : rmdups (filter (/= x) xs)

substs                        :: Prop -> [Subst]
substs p                      =  map (zip vs) (bools (length vs))
                                 where vs = rmdups (vars p)

isTaut                        :: Prop -> Bool
isTaut p                      =  and [eval s p | s <- substs p]

