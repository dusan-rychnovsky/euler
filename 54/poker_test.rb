require 'minitest/autorun'
require_relative 'poker'

class PokerTest < Minitest::Test

  # OnePair

  def test_onepair_eachdifferent_doesnt_match
    assert_equal false, OnePair.new.matches(Hand.parse("4D TC KS 7D 9C"))
  end
  def test_onepair_onetuple_matches
    assert_equal true, OnePair.new.matches(Hand.parse("4D TC KS 7D KC"))
  end
  def test_onepair_onetriple_matches
    assert_equal true, OnePair.new.matches(Hand.parse("4D KC KS 7D KC"))
  end
  def test_onepair_onequadruple_matches
    assert_equal true, OnePair.new.matches(Hand.parse("KD KC KS 7D KC"))
  end

  def test_onepair_cards
    cards = OnePair.new.cards(Hand.parse("4D TC KS 7D KC"))
    assert_equal [ Card.parse("KS"), Card.parse("KC")], cards
  end

  # TwoPairs
  
  def test_twopairs_onequadruple_matches
    assert_equal true, OnePair.new.matches(Hand.parse("4D 7C KS 7D KC"))
  end
  def test_twopairs_eachdifferent_doesnt_match
    assert_equal false, TwoPairs.new.matches(Hand.parse("4D TC KS 7D 9C"))
  end
  def test_twopairs_onetuple_doesnt_match
    assert_equal false, TwoPairs.new.matches(Hand.parse("4D TC KS 7D KC"))
  end
  def test_twopairs_onetriple_doesnt_match
    assert_equal false, TwoPairs.new.matches(Hand.parse("4D KC KS 7D KC"))
  end
  def test_twopairs_twotuples_matches
    assert_equal true, TwoPairs.new.matches(Hand.parse("4D 7C KS 7D KC"))
  end
  def test_twopairs_onetupleonetriple_matches
    assert_equal true, TwoPairs.new.matches(Hand.parse("7D 7C KS 7D KC"))
  end

  def test_twopairs_cards
    cards = TwoPairs.new.cards(Hand.parse("4D 7C KS 7D KC")) 
    expected = [
      Card.parse("7C"),
      Card.parse("7D"),
      Card.parse("KS"),
      Card.parse("KC")
    ]
    assert_equal expected, cards
  end

  # ThreeOfAKind

  def test_threeofakind_eachdifferent_doesnt_match
    assert_equal false, ThreeOfAKind.new.matches(Hand.parse("4D TC KS 7D 9C"))
  end
  def test_threeofakind_onetuple_doesnt_match
    assert_equal false, ThreeOfAKind.new.matches(Hand.parse("4D TC KS 7D KC"))
  end
  def test_threeofakind_onetriple_matches
    assert_equal true, ThreeOfAKind.new.matches(Hand.parse("4D KC KS 7D KD"))
  end
  def test_threeofakind_onequadruple_matches
    assert_equal true, ThreeOfAKind.new.matches(Hand.parse("KD KC KS 7D KC"))
  end
  def test_threeofakind_twotuples_doesnt_match
    assert_equal false, ThreeOfAKind.new.matches(Hand.parse("4D 7C KS 7D KC"))
  end

  def test_threeofakind_cards
    cards = ThreeOfAKind.new.cards(Hand.parse("4D KC KS 7D KD"))
    expected = [
      Card.parse("KC"),
      Card.parse("KS"),
      Card.parse("KD")
    ]
    assert_equal expected, cards
  end

  # Flush

  def test_flush_allsamesuit_match
    assert_equal true, Flush.new.matches(Hand.parse("4C 7C QC AC KC"))
  end
  def test_flush_differentsuits_doesnt_match
    assert_equal false, Flush.new.matches(Hand.parse("4D 7C KS 7D KC"))
  end

  def test_flush_cards
    cards = Flush.new.cards(Hand.parse("4C 7C QC AC KC"))
    expected = [
      Card.parse("4C"),
      Card.parse("7C"),
      Card.parse("QC"),
      Card.parse("AC"),
      Card.parse("KC")
    ]
    assert_equal expected, cards
  end

  # FullHouse

  def test_fullhouse_eachdifferent_doesnt_match
    assert_equal false, FullHouse.new.matches(Hand.parse("4D TC KS 7D 9C"))
  end
  def test_fullhouse_onetuple_doesnt_match
    assert_equal false, FullHouse.new.matches(Hand.parse("4D TC KS 7D KC"))
  end
  def test_fullhouse_onetriple_doesnt_match
    assert_equal false, FullHouse.new.matches(Hand.parse("4D KC KS 7D KC"))
  end
  def test_fullhouse_onequadruple_doesnt_match
    assert_equal false, FullHouse.new.matches(Hand.parse("KD KC KS 7D KC"))
  end
  def test_fullhouse_twotuples_doesnt_match
    assert_equal false, FullHouse.new.matches(Hand.parse("4D 7C KS 7D KC"))
  end
  def test_fullhouse_onetupleonetriple_matches
    assert_equal true, FullHouse.new.matches(Hand.parse("4D KC KS 4C KD"))
  end

  def test_fullhouse_cards
    cards = FullHouse.new.cards(Hand.parse("4D KC KS 4C KD"))
    expected = [
      Card.parse("4D"),
      Card.parse("KC"),
      Card.parse("KS"),
      Card.parse("4C"),
      Card.parse("KD")
    ]
    assert_equal expected, cards
  end

  # FourOfAKind

  def test_fourofakind_eachdifferent_doesnt_match
    assert_equal false, FourOfAKind.new.matches(Hand.parse("4D TC KS 7D 9C"))
  end
  def test_fourofakind_onetuple_doesnt_match
    assert_equal false, FourOfAKind.new.matches(Hand.parse("4D TC KS 7D KC"))
  end
  def test_fourofakind_onetriple_doesnt_match
    assert_equal false, FourOfAKind.new.matches(Hand.parse("4D KC KS 7D KC"))
  end
  def test_fourofakind_onequadruple_matches
    assert_equal true, FourOfAKind.new.matches(Hand.parse("KD KC KS 7D KH"))
  end
  def test_fourofakind_twotuples_doesnt_match
    assert_equal false, FourOfAKind.new.matches(Hand.parse("4D 7C KS 7D KC"))
  end

  def test_fourofakind_cards
    cards = FourOfAKind.new.cards(Hand.parse("KD KC KS 7D KH"))
    expected = [
      Card.parse("KD"),
      Card.parse("KC"),
      Card.parse("KS"),
      Card.parse("KH")
    ]
    assert_equal expected, cards
  end

  # Straight

  def test_straight_consecutivefaces_matches
    assert_equal true, Straight.new.matches(Hand.parse("4D 5C 6S 7D 8D"))
    assert_equal true, Straight.new.matches(Hand.parse("2C 3S 4C 5C 6C"))
    assert_equal true, Straight.new.matches(Hand.parse("TD JD QD KS AC"))
  end
  def test_straight_nonconsecutivefaces_doesnt_match
    assert_equal false, Straight.new.matches(Hand.parse("9D TD QD KS AC"))
  end

  def test_straight_cards
    cards = Straight.new.cards(Hand.parse("4D 5C 6S 7D 8D"))
    expected = [
      Card.parse("4D"),
      Card.parse("5C"),
      Card.parse("6S"),
      Card.parse("7D"),
      Card.parse("8D")
    ]
    assert_equal expected, cards
  end

  # StraightFlush

  def test_straightflush_notstraight_doesnt_match
    assert_equal false, StraightFlush.new.matches(Hand.parse("4D 5D 6D 7D 9D"))
  end
  def test_straightflush_notflush_doesnt_match
    assert_equal false, StraightFlush.new.matches(Hand.parse("9D TD JD AS KC"))
  end
  def test_straightflush_consecutivefacessamesuit_matches
    assert_equal true, StraightFlush.new.matches(Hand.parse("7D 8D 9D TD JD"))
  end

  def test_straightflush_cards
    cards = StraightFlush.new.cards(Hand.parse("4D 5D 6D 7D 8D"))
    expected = [
      Card.parse("4D"),
      Card.parse("5D"),
      Card.parse("6D"),
      Card.parse("7D"),
      Card.parse("8D")
    ]
    assert_equal expected, cards
  end

  # RoyalFlush

  def test_royalflush_notflush_doesnt_match
    assert_equal false, RoyalFlush.new.matches(Hand.parse("TD JC QD KD AD"))
  end
  def test_royalflush_notstraight_doesnt_match
    assert_equal false, RoyalFlush.new.matches(Hand.parse("9D JD QD KD AD"))
  end
  def test_royalflush_doesntendwithace_doesnt_match
    assert_equal false, RoyalFlush.new.matches(Hand.parse("9D TD JD QD KD"))
  end
  def test_royalflush_tentoacesamecolor_matches
    assert_equal true, RoyalFlush.new.matches(Hand.parse("TD JD QD KD AD"))
  end

  def test_royalflush_cards
    cards = RoyalFlush.new.cards(Hand.parse("TD JD QD KD AD"))
    expected = [
      Card.parse("TD"),
      Card.parse("JD"),
      Card.parse("QD"),
      Card.parse("KD"),
      Card.parse("AD")
    ]
    assert_equal expected, cards
  end
end
