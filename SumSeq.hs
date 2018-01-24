module SumSeq where

import Prelude hiding (sum)

sum :: Num a => [a] -> a
sum = go 0
  where
    go acc []     = {-# SCC go #-} acc
    go acc (x:xs) = {-# SCC go #-} let acc' = x + acc
                    in acc' `seq` go acc' xs

main = print $ sum [1..10^7]
