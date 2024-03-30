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
#
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
		winners = players_with_same_rank

	elif (tied_rank in [Rank.RankEnum.STRAIGHT_FLUSH, Rank.RankEnum.STRAIGHT]):
		var highest_card = 0

		for player in players_with_same_rank:
				var player_highest_card = 0
				if tied_rank == Rank.RankEnum.STRAIGHT_FLUSH:
						print(player.hand.ranking.straight_flush_cards)
						player_highest_card = player.hand.ranking.straight_flush_cards.max()
				elif tied_rank == Rank.RankEnum.STRAIGHT:
						player_highest_card = player.hand.ranking.straight_cards.max()

				if player_highest_card > highest_card:
						highest_card = player_highest_card
						winners = [player]
				elif player_highest_card == highest_card:
						winners.append(player)

	elif (tied_rank == Rank.RankEnum.FLUSH):
		pass

	elif (tied_rank in [Rank.RankEnum.FOUR_OF_A_KIND, Rank.RankEnum.THREE_OF_A_KIND]):
		pass

	elif (tied_rank == Rank.RankEnum.FULL_HOUSE):
		pass

	elif (tied_rank == Rank.RankEnum.TWO_PAIR):
		pass

	elif (tied_rank == Rank.RankEnum.PAIR):
		pass

	elif (tied_rank == Rank.RankEnum.HIGH_CARD):
		pass

	return winners

func handle_pot(players_with_same_rank: Array[Player]):
	"""Split the pot between one or more players"""
	var split_amount = float(pot_balance) / players_with_same_rank.size()
	for player in players_with_same_rank:
		player.balance += int(split_amount)
