class Bank
  BET = 10
  attr_reader :cash

  def initialize(start_cash = 0)
    @cash = start_cash
  end

  def pick_up_bank
    money = cash
    @cash = 0
    money
  end

  def add_cash(money)
    @cash += money if money > 0
  end

  def take_cash(money)
    if cash - money > 0
      @cash -= money
      money
    end
  end

  def take_bet
    take_cash(BET)
  end
end
