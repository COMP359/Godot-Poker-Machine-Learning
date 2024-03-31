class_name Dealer
extends Node
@onready var ui = $"../UI"

signal start_new_game
signal clear_previous_game

var pot_balance: int
var community_cards: Hand
var deck_of_cards: Deck
var players: Array[Player]

func _init():
	reset_dealer_state()
	players = []
	players.append(Player.new(Player.PlayerColor.BLUE, true, 100000))
	players.append(Player.new(Player.PlayerColor.RED, false, 100000))
	players.append(Player.new(Player.PlayerColor.YELLOW, false, 100000))
	players.append(Player.new(Player.PlayerColor.GREEN, false, 100000))

func start_game(player_playing: bool):
	for player in players:
		if (player.player_color != Player.PlayerColor.BLUE): # Always show player ones cards
			player.is_human_player = !player_playing
	deal_player_cards()
	deal_community_cards(3, false)
	deal_community_cards(2, true)

func clear_game():
	reset_dealer_state()
	
	for player in players:
		player.reset_player_state()

func deal_player_cards():
	for player in players:
		player.hand = Hand.new()
		for i in range(2):
			var card_dealt = deck_of_cards.draw_card()
			player.hand.add_card(card_dealt)
			ui.emit_signal("add_card_signal", player, card_dealt, !player.is_human_player)

func deal_community_cards(amount_of_cards: int, hidden_card: bool):
	for i in range(amount_of_cards):
		if (!hidden_card):
			var card_dealt = deck_of_cards.draw_card()
			community_cards.add_card(card_dealt)
			ui.emit_signal("add_community_card_signal", card_dealt)
		else:
			ui.emit_signal("add_hidden_community_card_signal")

	# TESTING
	for player in players:
		var player_rank_enum = player.hand.ranking.determine_hand_ranking(player.hand.cards + community_cards.cards)
		print("Player " + str(player.player_color) + " has " + str(player.hand.ranking.get_rank_string(player_rank_enum)))
	
	# TESTING
	determine_winner()

func reset_dealer_state():
	pot_balance = 0
	self.community_cards = Hand.new()
	self.deck_of_cards = Deck.new()

func determine_winner():
	var highest_ranked_players: Array[Player] = []
	var highest_rank = -1

	for player in players:
		if player.hand.ranking.rank > highest_rank:
			highest_rank = player.hand.ranking.rank
			highest_ranked_players.clear()
			highest_ranked_players.append(player)
		elif player.hand.ranking.rank == highest_rank:
			highest_ranked_players.append(player)

	if highest_ranked_players.size() > 1:
		var winners: Array[Player] = []
		winners = determine_tie(highest_ranked_players, highest_rank)
		handle_pot(winners)
	else:
		handle_pot(highest_ranked_players)

func determine_tie(players_with_same_rank: Array[Player], tied_rank: int):
	var winners: Array[Player] = []

	if (tied_rank == Rank.RankEnum.ROYAL_FLUSH):
		# Impossible to have a tie with a royal flush for 52 cards.
		# This is just here for completeness.
		winners = players_with_same_rank

	elif (tied_rank in [Rank.RankEnum.STRAIGHT_FLUSH, Rank.RankEnum.STRAIGHT]):
		var highest_card = 0

		for player in players_with_same_rank:
				var player_highest_card = 0
				if tied_rank == Rank.RankEnum.STRAIGHT_FLUSH:
						player_highest_card = player.hand.ranking.straight_flush_cards.max()
				elif tied_rank == Rank.RankEnum.STRAIGHT:
						player_highest_card = player.hand.ranking.straight_cards.max()

				if player_highest_card > highest_card:
						highest_card = player_highest_card
						winners = [player]
				elif player_highest_card == highest_card:
						winners.append(player)

	elif tied_rank == Rank.RankEnum.FLUSH:
		var highest_cards = players_with_same_rank[0].hand.ranking.flush_cards  # Get the flush cards of the first player
		var num_cards = len(highest_cards)

		for player in players_with_same_rank:
			var player_cards = player.hand.ranking.flush_cards
			var equal = true  # Flag to track if all cards are equal initially

			# Compare each card from highest to lowest
			for i in range(num_cards):
				if player_cards[i] > highest_cards[i]:
					winners = [player]
					highest_cards = player_cards
					equal = false
					break  # Exit the loop if a higher card is found
				elif player_cards[i] < highest_cards[i]:
					equal = false
					break  # Exit the loop if a lower card is found

			if equal:
				winners.append(player)  # Add the player to winners if all cards are equal
		return winners

	elif (tied_rank in [Rank.RankEnum.FOUR_OF_A_KIND, Rank.RankEnum.THREE_OF_A_KIND]):
		var highest_pair_card = 0

		for player in players_with_same_rank:
			var player_highest_pair_card = 0
			if tied_rank == Rank.RankEnum.FOUR_OF_A_KIND:
					player_highest_pair_card = player.hand.ranking.four_of_a_kind_highcard
			elif tied_rank == Rank.RankEnum.THREE_OF_A_KIND:
					player_highest_pair_card = player.hand.ranking.three_of_a_kind_highcard

			if player_highest_pair_card > highest_pair_card:
					highest_pair_card = player_highest_pair_card
					winners = [player]
			elif player_highest_pair_card == highest_pair_card:
					winners.append(player)

		# If there is a tie, check the next highest card
		if winners.size() > 1:
				var highest_card = 0
				for player in winners:
						for card in player.hand.cards:
								if card.value != highest_pair_card:  # Exclude the cards that are part of the three-of-a-kind or four-of-a-kind
										if card.value > highest_card:
												highest_card = card.value
												winners = [player]
										elif card.value == highest_card and player not in winners:
												winners.append(player)

	elif tied_rank == Rank.RankEnum.FULL_HOUSE:
		var highest_three_kind = -1
		var highest_pair = -1
		winners = []
		for player in players_with_same_rank:
				var player_three_kind = player.hand.ranking.full_house_three_kind_highcard
				var player_two_kind = player.hand.ranking.full_house_pair_highcard
				if player_three_kind > highest_three_kind or (player_three_kind == highest_three_kind and player_two_kind > highest_pair):
						highest_three_kind = player_three_kind
						highest_pair = player_two_kind
						winners = [player]
				elif player_three_kind == highest_three_kind and player_two_kind == highest_pair:
						winners.append(player)

	elif tied_rank == Rank.RankEnum.TWO_PAIR:
		var highest_pair = -1
		var second_highest_pair = -1
		var highest_card = 0
		winners = []
		for player in players_with_same_rank:
				var player_highest_pair = player.hand.ranking.two_pair_high_pair
				var player_second_highest_pair = player.hand.ranking.two_pair_low_pair
				var player_highest_card = 0
				for card in player.hand.cards:
					if card.value != player_highest_pair and card.value != player_second_highest_pair:
						player_highest_card = max(player_highest_card, card.value)
				if player_highest_pair > highest_pair or (player_highest_pair == highest_pair and player_second_highest_pair > second_highest_pair) or (player_highest_pair == highest_pair and player_second_highest_pair == second_highest_pair and player_highest_card > highest_card):
						highest_pair = player_highest_pair
						second_highest_pair = player_second_highest_pair
						highest_card = player_highest_card
						winners = [player]
				elif player_highest_pair == highest_pair and player_second_highest_pair == second_highest_pair and player_highest_card == highest_card:
						winners.append(player)

	elif (tied_rank == Rank.RankEnum.PAIR):
		var highest_pair = -1
		var highest_card = 0
		winners = []
		for player in players_with_same_rank:
				var player_highest_pair = player.hand.ranking.pair_high_card
				var player_highest_card = 0
				for card in player.hand.cards:
					if card.value != player_highest_pair:
						player_highest_card = max(player_highest_card, card.value)
				if player_highest_pair > highest_pair or (player_highest_pair == highest_pair and player_highest_card > highest_card):
						highest_pair = player_highest_pair
						highest_card = player_highest_card
						winners = [player]
				elif player_highest_pair == highest_pair and player_highest_card == highest_card:
						winners.append(player)

	elif tied_rank == Rank.RankEnum.HIGH_CARD:
		var highest_card_value = -1

		for player in players_with_same_rank:
				var player_cards = player.hand.cards
				var player_highest_card_value = -1

				for card in player_cards:
						if card.value > player_highest_card_value:
								player_highest_card_value = card.value

				if player_highest_card_value > highest_card_value:
						winners = [player]
						highest_card_value = player_highest_card_value
				elif player_highest_card_value == highest_card_value:
						var player_card_values = []
						for card in player_cards:
								player_card_values.append(card.value)
						player_card_values.sort()

						var winner_card_values = []
						for card in winners[0].hand.cards:
								winner_card_values.append(card.value)
						winner_card_values.sort()

						if player_card_values > winner_card_values:
								winners = [player]
						elif player_card_values == winner_card_values:
								winners.append(player)

	return winners

func handle_pot(players_with_same_rank: Array[Player]):
	"""Split the pot between one or more players"""
	var split_amount = float(pot_balance) / players_with_same_rank.size()
	for player in players_with_same_rank:
		player.balance += int(split_amount)

	print("Pot split between: " + str(players_with_same_rank.size()) + " players")
	for player in players_with_same_rank:
		print("Player " + str(player.player_color) + " receives: " + str(split_amount))
