# Lattice paths
# Problem 15
#
# Starting in the top left corner of a 2×2 grid, and only being able to move to the right and down, there are exactly 6
# routes to the bottom right corner. How many such routes are there through a 20×20 grid?
#

def paths rows, cols

  array = []

  (0..rows).each do |r|
    array[r] = []
    array[r][cols] = 1
  end

  (0..cols).each do |c|
    array[rows][c] = 1
  end

  (rows - 1).downto(0) do |r|
    (cols - 1).downto(0) do |c|
      array[r][c] = array[r][c+1] + array[r+1][c]
    end
  end

  array[0][0]
end

p paths 20, 20
p "DONE"
