require 'test/unit'
require_relative '../src/cards'
require_relative '../src/player'
require_relative '../src/bank'
require_relative '../src/card'
require_relative '../src/hand'
# require_relative 'main.rb'
# require test_helper
# power-assert

class TestCard < Test::Unit::TestCase
  def setup
    @cards = Cards.new
    @player = Player.new('John', 0)
    @bank = Bank.new(100)
  end

  def test_cards
    assert_equal 0, 0
    hand = Hand.new
    hand.add_card(Card.new(2, 'T-+'))
    assert_equal hand.count_points, 2
   # assert_equal @cards.count_points([Card.new(1, '+')]), 11
   # assert_equal @cards.count_points([Card.new(10, '+'), Card.new(10, '+')]), 20
    #assert_equal @cards.count_points([Card.new(10, '+'), Card.new(1, '+')]), 21
    puts @cards.take_card
  end

  def test_player
    hand = Hand.new
    hand.add_card('Card')
    hand.add_card('Card2')
    assert_equal ['Card', 'Card2'], hand.cards
    assert_equal @player.bank, 0
    @player.add_hand(hand)
    @player.hand.remove_cards
    @player.hand.add_card(@cards.take_card)
    @player.hand.add_card(@cards.take_card)
    assert_equal @player.hand.cards.length, 2
    points = @player.hand.count_points
    assert_equal points.class, Integer
  end

  def test_bank
    assert_equal @bank.cash, 100
    assert_equal @bank.pick_up_bank, 100
    assert_equal @bank.cash, 0
  end

  def test_validation_card
    assert_raise('RuntimeError') { Card.new('', '+') }
    assert_raise('RuntimeError') { Card.new(1, '---') }
  end

  def test_hand
    puts 'HAND!!!'
    hand = Hand.new
    hand.add_card(Card.new(10, 'T-+'))
    hand.add_card(Card.new(1, 'T-+'))
    hand.add_card(Card.new(10, 'T-+'))
    assert_equal 21, hand.count_points
    hand1 = Hand.new
    hand1.add_card(Card.new(1, 'T-+'))
    hand1.add_card(Card.new(10, 'T-+'))
    hand1.add_card(Card.new(1, 'T-+'))
    assert_equal 12, hand1.count_points
    hand2 = Hand.new
    hand2.add_card(Card.new(1, 'T-+'))
    hand2.add_card(Card.new(1, 'T-+'))
    hand2.add_card(Card.new(1, 'T-+'))
    assert_equal 13, hand2.count_points
    hand3 = Hand.new
    hand3.add_card(Card.new(10, 'T-+'))
    hand3.add_card(Card.new(1, 'T-+'))
    assert_equal 21, hand3.count_points
    hand4 = Hand.new
    hand4.add_card(Card.new(1, 'T-+'))
    hand4.add_card(Card.new(1, 'T-+'))
    assert_equal 12, hand4.count_points
  end
end
