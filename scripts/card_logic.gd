extends Node

func _ready():
	var deck = Deck.new()
	var player = Player.new(Player.PlayerColor.BLUE, true, 10000)
	var new_card = deck.draw_card()
	player.hand.add_card(new_card)
	print(player.get_hand())
	print(deck.get_deck_state())
	var second_new_card = deck.draw_card()
	player.hand.add_card(second_new_card)
	print(player.get_hand())
	print(deck.get_deck_state())

	# Some tests to see if the classes are working as expected
