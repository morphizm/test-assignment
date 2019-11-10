require_relative 'card'

class Cards
  attr_reader :cards
  def initialize
    @cards = []
    make
  end

  def take_card
    random_index = rand * @cards.length
    card = @cards[random_index.round - 1]
    @cards.delete(card)
    card
  end

  private

  def make
    Card::CARDS.each do |i|
      Card::COLORS.each do |j|
        cost = i.to_i.zero? ? 10 : i.to_i
        if i == 'T'
          @cards << Card.new(1, "#{i}-#{j}")
        else
          @cards << Card.new(cost, "#{i}-#{j}")
        end
      end
    end
  end
end
