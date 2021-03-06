# Non-abundant sums
# Problem 22
#
# A perfect number is a number for which the sum of its proper divisors is
# exactly equal to the number. For example, the sum of the proper divisors
# of 28 would be 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect
# number.
#
# A number n is called deficient if the sum of its proper divisors is less
# than n and it is called abundant if this sum exceeds n.

# As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the smallest
# number that can be written as the sum of two abundant numbers is 24. By
# mathematical analysis, it can be shown that all integers greater than 28123
# can be written as the sum of two abundant numbers. However, this upper limit
# cannot be reduced any further by analysis even though it is known that the
# greatest number that cannot be expressed as the sum of two abundant numbers
# is less than this limit.
#
# Find the sum of all the positive integers which cannot be written as the sum
# of two abundant numbers.
#

def abundants max

  nums = Hash.new
  (1..max).each { |num| nums[num] = 0 }

  (1..max/2).each do |div|
    num = div * 2
    while num <= max do
      nums[num] += div
      num += div
    end
  end

  nums.select { |num, sum| sum > num}.collect { |num, _| num}
end

MAX = 28123

abundants = abundants(MAX)

nums = Hash.new
(1..MAX).each { |num| nums[num] = true }

abundants.each do |a1|
  abundants.each do |a2|

    sum = a1 + a2
    break if sum > MAX

    if nums[sum] === true
      nums[sum] = false
    end
  end
end

p nums.select { |_, incl| incl === true }.collect { |num, _| num}.inject(:+)
p "DONE"
