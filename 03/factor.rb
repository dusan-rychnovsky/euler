# Largest prime factor
# Problem 3
#
# The prime factors of 13195 are 5, 7, 13 and 29. What is the largest prime factor of the number 600851475143 ?
#

def prime_factors n
  result = []
  (2..Math.sqrt(n)).each do |x|
    if n % x == 0 && result.none? { |p| x % p == 0 }
      result << x
    end
  end
  result
end

puts prime_factors(600_851_475_143).last
p "DONE"
