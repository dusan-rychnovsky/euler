# Summation of primes
# Problem 10
#
# The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17. Find the sum of all the primes below two million.
#

def sieve_once arr, p
  arr.reject! { |x| x % p == 0 }
end

def sieve_rec arr
  if arr.empty?
    []
  else
    p = arr.shift
    [p] + sieve_rec(sieve_once(arr, p))
  end
end

def sieve n
  sieve_rec (2..n).to_a
end

p sieve(2_000_000).inject { |sum, x| sum + x }
p "DONE"
