# Sum square difference
# Problem 6
#
# The sum of the squares of the first ten natural numbers is, 1^2 + 2^2 + ... + 10^2 = 385. The square of the sum of the
# first ten natural numbers is, (1 + 2 + ... + 10)^2 = 55^2 = 3025. Hence the difference between the sum of the squares
# of the first ten natural numbers and the square of the sum is 3025 − 385 = 2640. Find the difference between the sum
# of the squares of the first one hundred natural numbers and the square of the sum.
#

sum_of_squares = (1..100).map { |x| x*x }.inject { |sum, x| sum + x }
square_of_sum = (1..100).inject { |sum, x| sum + x} ** 2

p square_of_sum - sum_of_squares
p "DONE"
