# Maximum path sum I
# Problem 18
#
# By starting at the top of the triangle below and moving to adjacent numbers on the row below, the maximum total from
# top to bottom is 23.
#
# 3
# 7 4
# 2 4 6
# 8 5 9 3
#
# That is, 3 + 7 + 4 + 9 = 23. Find the maximum total from top to bottom of the triangle below:
#
# 75
# 95 64
# 17 47 82
# 18 35 87 10
# 20 04 82 47 65
# 19 01 23 75 03 34
# 88 02 77 73 07 63 67
# 99 65 04 28 06 16 70 92
# 41 41 26 56 83 40 80 70 33
# 41 48 72 33 47 32 37 16 94 29
# 53 71 44 65 25 43 91 52 97 51 14
# 70 11 33 28 77 73 17 78 39 68 17 57
# 91 71 52 38 17 14 91 43 58 50 27 29 48
# 63 66 04 68 89 53 67 30 73 16 69 87 40 31
# 04 62 98 27 23 09 70 98 73 93 38 53 60 04 23
#
# NOTE: As there are only 16384 routes, it is possible to solve this problem by trying every route. However, Problem 67,
# is the same challenge with a triangle containing one-hundred rows; it cannot be solved by brute force, and requires a
# clever method! ;o)

str = <<-EOS
75
95 64
17 47 82
18 35 87 10
20 04 82 47 65
19 01 23 75 03 34
88 02 77 73 07 63 67
99 65 04 28 06 16 70 92
41 41 26 56 83 40 80 70 33
41 48 72 33 47 32 37 16 94 29
53 71 44 65 25 43 91 52 97 51 14
70 11 33 28 77 73 17 78 39 68 17 57
91 71 52 38 17 14 91 43 58 50 27 29 48
63 66 04 68 89 53 67 30 73 16 69 87 40 31
04 62 98 27 23 09 70 98 73 93 38 53 60 04 23
EOS

class Node
  attr_accessor :value, :left, :right

  def initialize value
    @value = value
  end

  def inspect
    @value
  end
end

def connectify nodes
  (1..nodes.size-1).each do |row|
    (0..nodes[row].size-1).each do |col|
      node = nodes[row][col]
      node.left = nodes[row-1][col-1]
      node.right = nodes[row-1][col]
    end
  end
end

def flood nodes
  nodes.each do |line|
    line.each do |node|

      leftVal = rightVal = 0
      leftVal = node.left.value if node.left != nil
      rightVal = node.right.value if node.right != nil

      node.value += [ leftVal, rightVal ].max
    end
  end
end

nodes = str.split("\n").map { |line| line.split(" ").map { |val| Node.new val.to_i } }
connectify nodes
flood nodes

p nodes[-1].max_by { |node| node.value }.value
p "DONE"
