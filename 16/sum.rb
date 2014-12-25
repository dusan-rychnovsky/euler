# Power digit sum
# Problem 16
#
# 2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26. What is the sum of the digits of the number 2^1000?
#

num = 2**1000
digits = num.to_s.chars.map { |c| c.to_i }
sum = digits.reduce(:+)

p sum
p "DONE"
