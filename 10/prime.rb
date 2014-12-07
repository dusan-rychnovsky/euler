# Summation of primes
# Problem 10
#
# The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17. Find the sum of all the primes below two million.
#

def move arr, pos
  while arr[pos] == -1
    pos += 1
  end
  pos
end

def sieve_once arr, pos
  i = pos
  while arr[i] != nil
    arr[i] = -1
    i += pos
  end
end

def sieve n

  result = []
  arr = (0..n).to_a
  pos = 2

  while arr[pos] != nil
    result << pos
    sieve_once(arr, pos)
    pos = move(arr, pos)
  end

  result
end

p sieve(2_000_000).inject { |sum, x| sum + x }
p "DONE"
