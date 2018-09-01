require 'minitest/autorun'
require_relative 'poker'

class PokerTest < Minitest::Test

  # OnePair

  def test_onepair_eachdifferent_doesnt_match
    assert_equal false, OnePair.new.match(Hand.parse("4D TC KS 7D 9C"))
  end
  def test_onepair_onetuple_matches
    expected = [ 
      Card.parse("KS"),
      Card.parse("KC")
    ]
    assert_equal expected, OnePair.new.match(Hand.parse("4D TC KS 7D KC"))
  end

  # TwoPairs
  
  def test_twopairs_eachdifferent_doesnt_match
    assert_equal false, TwoPairs.new.match(Hand.parse("4D TC KS 7D 9C"))
  end
  def test_twopairs_onetuple_doesnt_match
    assert_equal false, TwoPairs.new.match(Hand.parse("4D TC KS 7D KC"))
  end
  def test_twopairs_onetriple_doesnt_match
    assert_equal false, TwoPairs.new.match(Hand.parse("4D KC KS 7D KD"))
  end
  def test_twopairs_twotuples_matches
    expected = [
      Card.parse("7C"),
      Card.parse("7D"),
      Card.parse("KS"),
      Card.parse("KC")
    ]
    assert_equal expected, TwoPairs.new.match(Hand.parse("4D 7C KS 7D KC"))
  end

  # ThreeOfAKind

  def test_threeofakind_eachdifferent_doesnt_match
    assert_equal false, ThreeOfAKind.new.match(Hand.parse("4D TC KS 7D 9C"))
  end
  def test_threeofakind_onetuple_doesnt_match
    assert_equal false, ThreeOfAKind.new.match(Hand.parse("4D TC KS 7D KC"))
  end
  def test_threeofakind_twotuples_doesnt_match
    assert_equal false, ThreeOfAKind.new.match(Hand.parse("4D 7C KS 7D KC"))
  end
  def test_threeofakind_onetriple_matches
    expected = [
      Card.parse("KC"),
      Card.parse("KS"),
      Card.parse("KD")
    ]
    assert_equal expected, ThreeOfAKind.new.match(Hand.parse("4D KC KS 7D KD"))
  end

  # Flush

  def test_flush_differentsuits_doesnt_match
    assert_equal false, Flush.new.match(Hand.parse("4D 7C KS 7D KC"))
  end
  def test_flush_allsamesuit_match
    expected = [
      Card.parse("4C"),
      Card.parse("7C"),
      Card.parse("QC"),
      Card.parse("AC"),
      Card.parse("KC")
    ]
    assert_equal expected, Flush.new.match(Hand.parse("4C 7C QC AC KC"))
  end

  # FullHouse

  def test_fullhouse_eachdifferent_doesnt_match
    assert_equal false, FullHouse.new.match(Hand.parse("4D TC KS 7D 9C"))
  end
  def test_fullhouse_onetuple_doesnt_match
    assert_equal false, FullHouse.new.match(Hand.parse("4D TC KS 7D KC"))
  end
  def test_fullhouse_onetriple_doesnt_match
    assert_equal false, FullHouse.new.match(Hand.parse("4D KC KS 7D KD"))
  end
  def test_fullhouse_onequadruple_doesnt_match
    assert_equal false, FullHouse.new.match(Hand.parse("KD KC KS 7D KH"))
  end
  def test_fullhouse_twotuples_doesnt_match
    assert_equal false, FullHouse.new.match(Hand.parse("4D 7C KS 7D KC"))
  end
  def test_fullhouse_onetupleonetriple_matches
    expected = [
      Card.parse("4D"),
      Card.parse("KC"),
      Card.parse("KS"),
      Card.parse("4C"),
      Card.parse("KD")
    ]
    assert_equal expected, FullHouse.new.match(Hand.parse("4D KC KS 4C KD"))
  end

  # FourOfAKind

  def test_fourofakind_eachdifferent_doesnt_match
    assert_equal false, FourOfAKind.new.match(Hand.parse("4D TC KS 7D 9C"))
  end
  def test_fourofakind_onetuple_doesnt_match
    assert_equal false, FourOfAKind.new.match(Hand.parse("4D TC KS 7D KC"))
  end
  def test_fourofakind_onetriple_doesnt_match
    assert_equal false, FourOfAKind.new.match(Hand.parse("4D KC KS 7D KD"))
  end
  def test_fourofakind_twotuples_doesnt_match
    assert_equal false, FourOfAKind.new.match(Hand.parse("4D 7C KS 7D KC"))
  end
  def test_fourofakind_onequadruple_matches
    expected = [
      Card.parse("KD"),
      Card.parse("KC"),
      Card.parse("KS"),
      Card.parse("KH")
    ]
    assert_equal expected, FourOfAKind.new.match(Hand.parse("KD KC KS 7D KH"))
  end

  # Straight

  def test_straight_nonconsecutivefaces_doesnt_match
    assert_equal false, Straight.new.match(Hand.parse("9D TD QD KS AC"))
  end
  def test_straight_consecutivefaces_matches
    expected = [
      Card.parse("4D"),
      Card.parse("5C"),
      Card.parse("6S"),
      Card.parse("7D"),
      Card.parse("8D")
    ]
    assert_equal expected, Straight.new.match(Hand.parse("4D 5C 6S 7D 8D"))
  end
  def test_straight_consecutivefaces_fromtwo_matches
    expected = [
      Card.parse("2C"),
      Card.parse("3S"),
      Card.parse("4C"),
      Card.parse("5C"),
      Card.parse("6C")
    ]
    assert_equal expected, Straight.new.match(Hand.parse("2C 3S 4C 5C 6C"))
  end
  def test_straight_consecutivefaces_toace_matches
    expected = [
      Card.parse("TD"),
      Card.parse("JD"),
      Card.parse("QD"),
      Card.parse("KS"),
      Card.parse("AC")
    ]
    assert_equal expected, Straight.new.match(Hand.parse("TD JD QD KS AC"))
  end
  
  # StraightFlush

  def test_straightflush_notstraight_doesnt_match
    assert_equal false, StraightFlush.new.match(Hand.parse("4D 5D 6D 7D 9D"))
  end
  def test_straightflush_notflush_doesnt_match
    assert_equal false, StraightFlush.new.match(Hand.parse("9D TD JD AS KC"))
  end
  def test_straightflush_consecutivefacessamesuit_matches
    expected = [
      Card.parse("7D"),
      Card.parse("8D"),
      Card.parse("9D"),
      Card.parse("TD"),
      Card.parse("JD")
    ]
    assert_equal expected, StraightFlush.new.match(Hand.parse("7D 8D 9D TD JD"))
  end

  # RoyalFlush

  def test_royalflush_notflush_doesnt_match
    assert_equal false, RoyalFlush.new.match(Hand.parse("TD JC QD KD AD"))
  end
  def test_royalflush_notstraight_doesnt_match
    assert_equal false, RoyalFlush.new.match(Hand.parse("9D JD QD KD AD"))
  end
  def test_royalflush_doesntendwithace_doesnt_match
    assert_equal false, RoyalFlush.new.match(Hand.parse("9D TD JD QD KD"))
  end
  def test_royalflush_tentoacesamecolor_matches
    expected = [
      Card.parse("TD"),
      Card.parse("JD"),
      Card.parse("QD"),
      Card.parse("KD"),
      Card.parse("AD")
    ]
    assert_equal expected, RoyalFlush.new.match(Hand.parse("TD JD QD KD AD"))
  end
end
