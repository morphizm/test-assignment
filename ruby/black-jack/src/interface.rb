class Interface
  def name
    puts 'Введите ваше имя'
    gets.chomp
  end

  def receive_player_action
    gets.chomp
  end

  def receive_play_more
    gets.chomp
  end

  def end_game(total, dealer_cards, dealer_points, player_cards, player_points)
    puts 'Конец игры!'
    puts 'Карты дилера'
    dealer_cards.each { |card| print card.color, ' ' }
    puts
    puts 'Очки дилера'
    puts dealer_points
    puts 'Ваши карты'
    player_cards.each { |card| print card.color, ' ' }
    puts
    puts 'Ваши очки'
    puts player_points
    if total == 0
      puts 'Ничья!'
    elsif total == 1
      puts 'Дилер выиграл!'
    else
      puts 'Вы выиграли!'
    end
  end

  def show_play_more
    puts 'Введите'
    puts '1 - Сыграть ещё раз'
  end

  def show_players_act
    puts 'Введите'
    puts '1 - Пропустить'
    puts '2 - Добавить карту'
    puts '3 - Открыть карты'
  end

  def show_table(dealer_cards, player_cards, player_points)
    puts 'Карты дилера'
    len = dealer_cards.length
    len.times { print '*' }
    puts
    puts 'Ваши карты'
    player_cards.each { |card| print card.color, ' ' }
    puts
    puts 'Ваши очки'
    puts player_points
  end
end
