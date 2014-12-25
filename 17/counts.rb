# Number letter counts
# Problem 17
#
# If the numbers 1 to 5 are written out in words: one, two, three, four, five, then there are 3 + 3 + 5 + 4 + 4 = 19
# letters used in total. If all the numbers from 1 to 1000 (one thousand) inclusive were written out in words, how many
# letters would be used?
#
# NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and forty-two) contains 23 letters and 115 (one
# hundred and fifteen) contains 20 letters. The use of "and" when writing out numbers is in compliance with British
# usage.
#

def to_speech num

  digits = {
      1 => "one",
      2 => "two",
      3 => "three",
      4 => "four",
      5 => "five",
      6 => "six",
      7 => "seven",
      8 => "eight",
      9 => "nine",
      10 => "ten",
      11 => "eleven",
      12 => "twelve",
      13 => "thirteen",
      14 => "fourteen",
      15 => "fifteen",
      16 => "sixteen",
      17 => "seventeen",
      18 => "eighteen",
      19 => "nineteen",
      20 => "twenty",
      30 => "thirty",
      40 => "forty",
      50 => "fifty",
      60 => "sixty",
      70 => "seventy",
      80 => "eighty",
      90 => "ninety"
  }

  result = ""

  thousands = (num % 10000) / 1000

  if thousands >= 1
    result << digits[thousands] << " thousand"

    if thousands > 1
      result << "s"
    end
  end

  hundreds = (num % 1000) / 100

  if hundreds >= 1
    result << " " << digits[hundreds] << " hundred"
  end

  rest = num % 100

  if rest > 0

    unless result.empty?
      result << " and "
    end

    if rest < 20
      result << digits[rest]
    else
      tens = rest / 10
      result << digits[tens * 10]

      units = rest % 10
      if units > 0
        result << "-" << digits[units]
      end
    end
  end

  result
end

def strip str
  str.gsub(/\W+/, '')
end

p (1..1000).to_a.map{ |n| strip(to_speech(n)).size }.reduce(:+)
p "DONE"
