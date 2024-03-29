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
		
