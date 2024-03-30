class_name Dealer
extends Node
@onready var ui = $"../UI"

var pot_balance: int
var community_cards: Hand
var deck_of_cards: Deck
var players: Array[Player]

func _init():
	pot_balance = 0
	community_cards = Hand.new()
	deck_of_cards = Deck.new()
	players = []
	players.append(Player.new(Player.PlayerColor.BLUE, false, 100000))
	players.append(Player.new(Player.PlayerColor.RED, false, 100000))
	players.append(Player.new(Player.PlayerColor.YELLOW, false, 100000))
	players.append(Player.new(Player.PlayerColor.GREEN, false, 100000))

func _ready():
	deal_player_cards()
	deal_community_cards(5)

func deal_player_cards():
	for player in players:
		player.hand = Hand.new()
		for i in range(2):
			var card_dealt = deck_of_cards.draw_card()
			player.hand.add_card(card_dealt)
			ui.emit_signal("add_card_signal", player, card_dealt)

func deal_community_cards(amount_of_cards: int):
	for i in range(amount_of_cards):
		var card_dealt = deck_of_cards.draw_card()
		community_cards.add_card(card_dealt)
		ui.emit_signal("add_community_card_signal", card_dealt)
	# TODO: THIS IS SCUFFED NEEDS TO BE FIXED JUST FOR TESTING
	# MAKE A FUNCTION TO AUTOMATICALLY FILL IN THE REMAINING SPOTS
	#for i in range(2):
		## MAKE THE UI TAKE AWAY THE HIDDEN CARDS AND SHOW THE REAL ONES AFTER
		##var card_dealt = deck_of_cards.draw_card()
		##community_cards.add_card(card_dealt)
		#ui.emit_signal("add_hidden_community_card_signal")
	
	# TESTING
	for player in players:
		var player_rank_enum = player.hand.ranking.determine_hand_ranking(player.hand.cards + community_cards.cards)
		print("Player " + str(player.player_color) + " has " + str(player.hand.ranking.get_rank_string(player_rank_enum)))

func determine_winner():
	var highest_ranked_players: Array[Player] = []
	var highest_rank = -1

	for player in players:
		if player.rank > highest_rank:
			highest_rank = player.rank
			highest_ranked_players.clear()
			highest_ranked_players.append(player)
		elif player.rank == highest_rank:
			highest_ranked_players.append(player)

	if highest_ranked_players.size() == 1:
		# Winner
		return
	else:
		# Tie
		var winners: Array[Player] = []
		winners = determine_tie(highest_ranked_players, highest_rank)
		handle_pot(winners)

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

	elif (tied_rank == Rank.RankEnum.TWO_PAIR):
		pass

	elif (tied_rank == Rank.RankEnum.PAIR):
		pass

	elif tied_rank == Rank.RankEnum.HIGH_CARD:
		var highest_card_value = -1

		for player in players_with_same_rank:
			var player_cards = player.hand.cards
			var player_highest_card_value = -1

			# Compare each card to find the highest card value for the player
			for card in player_cards:
				if card.value > player_highest_card_value:
					player_highest_card_value = card.value

			# Compare the highest card value with the highest found so far
			if player_highest_card_value > highest_card_value:
				winners = [player]
				highest_card_value = player_highest_card_value
			elif player_highest_card_value == highest_card_value:
				# If there's a tie on the highest card value, compare all cards
				if player_cards > winners[0].hand.cards:
					winners = [player]
				elif player_cards == winners[0].hand.cards:
					winners.append(player)

	return winners


func handle_pot(players_with_same_rank: Array[Player]):
	"""Split the pot between one or more players"""
	var split_amount = float(pot_balance) / players_with_same_rank.size()
	for player in players_with_same_rank:
		player.balance += int(split_amount)
