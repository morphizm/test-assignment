class Hand
  attr_reader :cards

  def add_card(card)
    @cards ||= []
    cards << card
  end

  def remove_cards
    @cards = []
  end

  def count_points
    points = 0
    cards.sort! { |a, b| b.cost - a.cost }
    index = 0
    len = cards.length
    cards.each do |card|
      index += 1
      cost = card.cost
      if cost == 1 && index == len
        ace = points + 11
        if (21 - ace) >= 0
          points += 11
        else
          points += 1
        end
      else
        points += cost
      end
    end
    points
  end
end
