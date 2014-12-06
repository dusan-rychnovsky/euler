-- Largest prime factor
-- Problem 3
--
-- The prime factors of 13195 are 5, 7, 13 and 29. What is the largest prime factor of the number 600851475143 ?
--

import Data.List

int_sqrt :: Integer -> Integer
int_sqrt x = ceiling (sqrt (fromIntegral x))

is_factor :: Integer -> Integer -> Bool
is_factor n x = n `mod` x == 0

is_prime :: Integer -> Bool
is_prime x = all (\d -> not (is_factor x d)) [2..int_sqrt x]

largest_factor :: Integer -> Integer
largest_factor n = last (filter is_prime (filter (is_factor n) [1..int_sqrt n]))

-- largest_factor 600851475143
