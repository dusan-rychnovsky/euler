# Names scores
# Problem 22
#
# Using names.txt (right click and 'Save Link/Target As...'), a 46K text file containing over five-thousand first names,
# begin by sorting it into alphabetical order. Then working out the alphabetical value for each name, multiply this
# value by its alphabetical position in the list to obtain a name score.
#
# For example, when the list is sorted into alphabetical order, COLIN, which is worth 3 + 15 + 12 + 9 + 14 = 53, is the
# 938th name in the list. So, COLIN would obtain a score of 938 × 53 = 49714.
#
# What is the total of all the name scores in the file?
#

def value name
  name.bytes.map { |b| b - 64 }.inject(:+)
end

def score name, pos
  value(name) * pos
end

def trim_quotes word
  word.chomp('"').reverse.chomp('"').reverse
end

names = File.read("names.txt").split(",").map { |word| trim_quotes word }
names = names.sort
total_score = names.each_with_index.map { |name, i| score(name, i + 1) }.inject(:+)

p total_score
p "DONE"
