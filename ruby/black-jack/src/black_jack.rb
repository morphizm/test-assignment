require_relative 'cards'
require_relative 'player'
require_relative 'bank'
require_relative 'interface'
require_relative 'card'
require_relative 'hand'

class BlackJack
  def initialize
    @interface = Interface.new
    @dealer = Player.new('Dealer', Bank.new(100))
    name = @interface.name
    @player = Player.new(name, Bank.new(100))
    @bank = Bank.new(0)
  end

  def run
    deal_cards
  end

  private

  def deal_cards
    @cards = Cards.new

    player_hand = Hand.new
    player_hand.add_card(@cards.take_card)
    player_hand.add_card(@cards.take_card)
    @player.add_hand(player_hand)

    dealer_hand = Hand.new
    dealer_hand.add_card(@cards.take_card)
    dealer_hand.add_card(@cards.take_card)
    @dealer.add_hand(dealer_hand)

    current_round_bank = @dealer.take_bet + @player.take_bet
    @bank.add_cash(current_round_bank)
    act_player
  end

  def act_player
    player_points = @player.hand.count_points
    @interface.show_table(@dealer.hand.cards, @player.hand.cards, player_points)
    @interface.show_players_act
    act_end_game if game_end?
    answer = @interface.receive_player_action.to_i
    if answer == 1
      act_dealer
    elsif answer == 2
      @player.hand.add_card(@cards.take_card) if @player.hand.cards.length == 2
      act_dealer
    elsif answer == 3
      act_end_game
    end
  end

  def act_dealer
    act_end_game if game_end?
    dealer_points = @dealer.hand.count_points
    if dealer_points < 17
      card = @cards.take_card
      @dealer.hand.add_card(card)
    end
    act_player
  end

  def act_end_game
    dealer_points = @dealer.hand.count_points
    player_points = @player.hand.count_points
    player_cards = @player.hand.cards
    dealer_cards = @dealer.hand.cards
    # total: 0 - ничья, 1 - дилер, 2 - игрок
    total = 0
    if dealer_points == player_points
      total = 0
      bank_cash = @bank.pick_up_bank / 2
      @dealer.bank.add_cash(bank_cash)
      @player.bank.add_cash(bank_cash)
    elsif dealer_points <= 21 && player_points <= 21
      if player_points > dealer_points
        total = 2
      else
        total = 1
      end
    elsif player_points > 21
      total = 1
    else
      total = 2
    end
    if total != 0
      total == 2 ? @player.bank.add_cash(@bank.pick_up_bank) : @dealer.bank.add_cash(@bank.pick_up_bank)
    end
    @interface.end_game(total, dealer_cards, dealer_points, player_cards, player_points)
    @interface.show_play_more
    answer = @interface.receive_play_more.to_i
    deal_cards if answer == 1
    exit 0
  end

  def game_end?
    true if @player.hand.cards.length >= 3 && @dealer.hand.cards.length >= 3
  end
end
