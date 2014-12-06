-- 10001st prime
-- Problem 7
--
-- By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13. What is the
-- 10 001st prime number?
--

import Data.List

-- a list identical with {seq} but with omitted multiples of {p}
sieve_once :: [Integer] -> Integer -> [Integer]
sieve_once seq p = filter (\x -> x `mod` p /= 0) seq

-- a list of all prime numbers
sieve :: [Integer]
sieve = unfoldr (\(p:rest) -> Just(p, sieve_once rest p)) [2..]

-- last (take 10001 sieve)
