# Largest palindrome product
# Problem 4
#
# A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is
# 9009 = 91 × 99. Find the largest palindrome made from the product of two 3-digit numbers.
#

def palindrom? word
  word.chars.zip(word.reverse.chars).all? {|c1, c2| c1 == c2}
end

largest = -1
(100..999).each do |a|
  (100..999).each do |b|
    product = (a * b)
    if (product > largest) && palindrom?(product.to_s) then
      largest = product
    end
  end
end

p largest
p "DONE"
