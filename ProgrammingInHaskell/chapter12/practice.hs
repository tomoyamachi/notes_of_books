-- 5
fibs@(_:fs) = 0:1:zipWith (+) fibs fs