# Poker hands
# Problem 54 

# In the card game poker, a hand consists of five cards and are ranked,
# from lowest to highest, in the following way:

# * High Card: Highest value card.
# * One Pair: Two cards of the same value.
# * Two Pairs: Two different pairs.
# * Three of a Kind: Three cards of the same value.
# * Straight: All cards are consecutive values.
# * Flush: All cards of the same suit.
# * Full House: Three of a kind and a pair.
# * Four of a Kind: Four cards of the same value.
# * Straight Flush: All cards are consecutive values of same suit.
# * Royal Flush: Ten, Jack, Queen, King, Ace, in same suit.
#
# The cards are valued in the order:
# 2, 3, 4, 5, 6, 7, 8, 9, 10, Jack, Queen, King, Ace.
#
# If two players have the same ranked hands then the rank made up of the highest
# value wins; for example, a pair of eights beats a pair of fives (see example 1 below).
# But if two ranks tie, for example, both players have a pair of queens, then highest
# cards in each hand are compared (see example 4 below); if the highest cards tie then
# the next highest cards are compared, and so on.
#
# Consider the following five hands dealt to two players:
# 
# Hand    Player 1           Player 2             Winner
# 1       5H 5C 6S 7S KD     2C 3S 8S 8D TD       Player 2
#         Pair of Fives      Pair of Eights
# 2       5D 8C 9S JS AC     2C 5C 7D 8S QH       Player 1
#         Highest card Ace   Highest card Queen
# 3       2D 9C AS AH AC     3D 6D 7D TD QD       Player 2
#         Three Aces         Flush with Diamonds
# 4       4D 6S 9H QH QC     3D 6D 7H QD QS       Player 1
#         Pair of Queens     Pair of Queens
#         Highest card Nine  Highest card Seven
# 5       2H 2D 4C 4D 4S     3C 3D 3S 9S 9D       Player 1
#         Full House         Full House
#         With Three Fours   with Three Threes
#
# The file, poker.txt, contains one-thousand random hands dealt to two players. 
# Each line of the file contains ten cards (separated by a single space): 
# the first five are Player 1's cards and the last five are Player 2's cards.
# You can assume that all hands are valid (no invalid characters or repeated cards),
# each player's hand is in no specific order, and in each hand there is a clear winner.
#
# How many hands does Player 1 win?
#

Card = Struct.new(:face, :suit) do
  
  def self.parse(value)
    Card.new(value[0], value[1])
  end

  def ord
    case face
      when "T"
        10
      when "J"
        11
      when "Q"
        12
      when "K"
        13
      when "A"
        14
      else
        face.to_i
    end
  end
end

Hand = Struct.new(:cards) do
  
  def self.parse(line)
    tokens = line.split(" ")
    cards = tokens.map { |t| Card.parse(t) }
    Hand.new(cards)
  end
  
  def group_by
    result = {}
    cards.each do |card|
      key = yield card
      result[key] = [] unless result[key]
      result[key] << card
    end
    result
  end

  def order_by_face_asc
    Hand.new(cards.sort_by { |card| card.ord })
  end
end

class OnePair
  def matches(hand)
    faces = hand.group_by { |card| card.face }
    faces.any? { |_, cards| cards.count >= 2 }
  end
  def cards(hand)
    faces = hand.group_by { |card| card.face }
    faces.select { |_, cards| cards.count >= 2 }.first[1]
  end
end

class TwoPairs
  def matches(hand)
    faces = hand.group_by { |card| card.face }
    pairs = faces.select { |_, cards| cards.count >= 2 }
    pairs.count >= 2
  end
  def cards(hand)
    faces = hand.group_by { |card| card.face}
    pairs = faces.select { |_, cards| cards.count >= 2 }.map { |_, cards| cards }
    pairs.flatten
  end
end

class ThreeOfAKind
  def matches(hand)
    faces = hand.group_by { |card| card.face }
    faces.any? { |_, cards| cards.count >= 3 }
  end
  def cards(hand)
    faces = hand.group_by { |card| card.face }
    faces.select { |_, cards| cards.count >= 3 }.first[1]
  end
end

class FourOfAKind
  def matches(hand)
    faces = hand.group_by { |card| card.face }
    faces.any? { |_, cards| cards.count == 4 }
  end
  def cards(hand)
    faces = hand.group_by { |card| card.face }
    faces.select { |_, cards| cards.count == 4 }.first[1]
  end
end

class FullHouse
  def matches(hand)
    faces = hand.group_by { |card| card.face }
    return (
      faces.count == 2 && 
      faces.any? { |_, cards| cards.count == 3 } &&
      faces.any? { |_, cards| cards.count == 2 }
    )
  end
  def cards(hand)
    hand.cards
  end
end

class Straight
  def matches(hand)
    sorted = hand.order_by_face_asc
    cards = sorted.cards
    i = cards.first.ord - 1
    cards.each do |card|
      i += 1
      return false unless card.ord == i
    end
    true
  end
  def cards(hand)
    hand.cards
  end
end

class Flush
  def matches(hand)
    suits = hand.group_by { |card| card.suit }
    suits.count == 1
  end
  def cards(hand)
    hand.cards
  end
end

class StraightFlush
  def matches(hand)
    Straight.new.matches(hand) && Flush.new.matches(hand)
  end
  def cards(hand)
    hand.cards
  end
end

class RoyalFlush
  def matches(hand)
    sorted = hand.order_by_face_asc
    cards = sorted.cards
    suit = cards.first.suit

    return (
      cards[0] == Card.new("T", suit) &&
      cards[1] == Card.new("J", suit) &&
      cards[2] == Card.new("Q", suit) &&
      cards[3] == Card.new("K", suit) &&
      cards[4] == Card.new("A", suit)
      )
  end
  def cards(hand)
    hand.cards
  end
end

$ranks = [
  RoyalFlush.new,
  StraightFlush.new,
  FourOfAKind.new,
  FullHouse.new,
  Flush.new,
  Straight.new,
  ThreeOfAKind.new,
  TwoPairs.new,
  OnePair.new
]

def highest_card(first_cards, second_cards)
  first_cards = first_cards.sort_by { |card| card.ord }.reverse
  second_cards = second_cards.sort_by { |card| card.ord }.reverse
  first_cards.zip(second_cards).each do |f, s|
    if f.ord > s.ord
      return :first
    end
    if s.ord > f.ord
      return :second
    end
  end
  :draw
end

def winner(first_hand, second_hand)
  $ranks.each do |rank|
    if rank.matches(first_hand) && !rank.matches(second_hand)
      return :first
    end
    if !rank.matches(first_hand) && rank.matches(second_hand)
      return :second
    end
    if rank.matches(first_hand) && rank.matches(second_hand)
      first_ranked_cards = rank.cards(first_hand)
      second_ranked_cards = rank.cards(second_hand)
      winner = highest_card(first_ranked_cards, second_ranked_cards)
      if winner != :draw
        return winner
      else
        break
      end
    end
  end
  highest_card(first_hand.cards, second_hand.cards)
end

def parse(line)
  first = Hand.parse(line[0..13])
  second = Hand.parse(line[15..28])
  return first, second
end

lineNo = 0
numWins = 0;
File.open('poker.txt').each do |line|
  lineNo += 1
  # break if lineNo >= 0
  first, second = parse(line)
  numWins += 1 if winner(first, second) == :first
end

puts numWins
puts "done"
