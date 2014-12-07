# Summation of primes
# Problem 10
#
# The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17. Find the sum of all the primes below two million.
#

def drop_while! arr, &block
  unless arr.empty?
    x = arr.first
    if block.call(x)
      arr.shift
      drop_while! arr, &block
    end
  end
end

def sieve_once arr, p
  arr.map! { |x| x % p == 0 ? -1 : x }
end

def sieve_rec arr
  drop_while!(arr) { |x| x == -1 }
  if arr.empty? then
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
