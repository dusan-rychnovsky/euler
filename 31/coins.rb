# Coin sums
# Problem 31
#
# In England the currency is made up of pound, £, and pence, p,
# and there are eight coins in general circulation:
# 
# 1p, 2p, 5p, 10p, 20p, 50p, £1 (100p) and £2 (200p).
#
# It is possible to make £2 in the following way:
#
# 1×£1 + 1×50p + 2×20p + 1×5p + 1×2p + 3×1p
#
# How many different ways can £2 be made using any number of coins?
#

$coins = [ 1, 2, 5, 10, 20, 50, 100, 200 ]
$coins = $coins.reverse

def make(value, coins)
  return 1 if value == 0
  return 0 if coins.empty?

  coin, *rest = *coins
  
  result = 0;
  (0..(value / coin)).each do |mul|
    result += make(value - mul * coin, rest)
  end

  result
end

puts make(200, $coins)
puts "done"
