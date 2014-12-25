# Longest Collatz sequence
# Problem 14
#
# The following iterative sequence is defined for the set of positive integers:
#
# n → n/2 (n is even)
# n → 3n + 1 (n is odd)

# Using the rule above and starting with 13, we generate the following sequence:
#
# 13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1
#
# It can be seen that this sequence (starting at 13 and finishing at 1) contains 10 terms. Although it has not been
# proved yet (Collatz Problem), it is thought that all starting numbers finish at 1. Which starting number, under one
# million, produces the longest chain?
#
# NOTE: Once the chain starts the terms are allowed to go above one million.
#

class Cell

  def initialize n
    @n = n
  end

  def n
    @n
  end

  def next
    if @n == 1
      nil
    else
      Cell.new(@n % 2 == 0 ? (@n / 2) : (3 * @n + 1))
    end
  end
end

class Cache

  def initialize
    @data = { 1 => 1}
  end

  def length! cell

    if @data[cell.n] != nil
      return @data[cell.n]
    end

    l = length!(cell.next)
    @data[cell.n] = l + 1
  end

  def max_length
    @data.max_by { |_, v| v}[0]
  end
end

cache = Cache.new
(1..999_999).each { |n| cache.length! Cell.new(n) }

p cache.max_length
p "DONE"
