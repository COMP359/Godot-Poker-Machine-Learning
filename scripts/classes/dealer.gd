class_name Dealer
extends Node

var pot_balance: int
var community_cards: Hand
var deck_of_cards: Deck

func _init():
	deck_of_cards = Deck.new()
	deck_of_cards.shuffle_deck()
	community_cards = Hand.new()
	pot_balance = 0

func deal_player_cards(players: Array[Player]):
	for player in players:
		for i in range(2):
			var card_dealt = deck_of_cards.draw_card()
			player.hand.add_card(card_dealt)
			GlobalSignalHandler.emit_signal("ui_add_card_signal", player, card_dealt)

func deal_community_cards(amount_of_cards: int):
	for i in range(amount_of_cards):
		var card_dealt = deck_of_cards.draw_card()
		community_cards.add_card(card_dealt)
		GlobalSignalHandler.emit_signal("ui_add_community_card_signal", card_dealt)

func update_pot(pot_increase: int):
	pot_balance += pot_increase
	GlobalSignalHandler.emit_signal("ui_update_pot_amount", pot_balance)

func deal_flop():
	deal_community_cards(3)

func deal_turn():
	deal_community_cards(1)

func deal_river():
	deal_community_cards(1)
