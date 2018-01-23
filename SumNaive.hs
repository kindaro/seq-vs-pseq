{-# LANGUAGE
    NoImplicitPrelude
  #-}

module SumNaive where

import Prelude hiding (sum)

sum :: Num a => [a] -> a
sum = go 0
  where
    go acc []     = acc
    go acc (x:xs) = go (x + acc) xs

main = print $ sum [1..10^7]
