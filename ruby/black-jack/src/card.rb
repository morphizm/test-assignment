class Card
  CARDS = [*('2'..'10').to_a, 'JACK', 'DAME', 'KING', 'T']
  COLORS = ['^', '+', '<3', '<>']

  attr_reader :cost, :color

  def initialize(cost, color)
    @cost = cost
    @color = color
    validate!
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  private

  def validate!
    card, colour = color.split('-')
    raise 'cost type must be Integer' if cost.class != Integer
    raise 'undefined color' unless CARDS.include?(card) && COLORS.include?(colour)
  end
end
