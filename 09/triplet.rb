# Special Pythagorean triplet
# Problem 9
#
# A Pythagorean triplet is a set of three natural numbers, a < b < c, for which, a^2 + b^2 = c^2. For example,
# 3^2 + 4^2 = 9 + 16 = 25 = 5^2. There exists exactly one Pythagorean triplet for which a + b + c = 1000. Find the
# product abc.
#

def triplet? a, b, c
  a**2 + b**2 == c**2
end

result = []
(1..997).each do |c|
  (1..(1000 - c - 1)).each do |b|
    a = 1000 - c - b
    result = [a, b, c] if triplet?(a, b, c)
  end
end

p result
p result.inject { |prd, x| prd * x }
p "DONE"
