# Factorial digit sum
# Problem 20
#
# n! means n × (n − 1) × ... × 3 × 2 × 1
#
# For example, 10! = 10 × 9 × ... × 3 × 2 × 1 = 3628800, and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 +
# 8 + 0 + 0 = 27.
#
# Find the sum of the digits in the number 100!
#

def digits num
  num.to_s.chars.map { |c| c.to_i }
end

fact = 100.downto(1).inject(:*)
sum = digits(fact).inject(:+)

p sum
p "DONE"
