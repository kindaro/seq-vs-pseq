{-# LANGUAGE
    NoImplicitPrelude
  #-}

module SumPseq where

import Prelude hiding (sum)
import Control.Parallel (pseq)

sum :: Num a => [a] -> a
sum = go 0
  where
    go acc []     = acc
    go acc (x:xs) = let acc' = x + acc
                    in acc' `pseq` go acc' xs

main = print $ sum [1..10^7]

