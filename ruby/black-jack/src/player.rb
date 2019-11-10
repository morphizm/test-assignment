class Player
  attr_reader :name, :hand, :bank

  def initialize(name, cash)
    @name = name
    @bank = cash
  end

  def add_hand(hand)
    @hand = hand
  end

  def take_bet
    bank.take_bet
  end
end
