# extends Control

# var flipped_card_texture
# var flipped_texture_rect
# var new_card
# var node

# func _ready():
# 	node = get_node("/root/Main/UI")
# 	var deck = Deck.new()
# 	var player = Player.new(Player.PlayerColor.BLUE, true, 100000)

# 	var aiGreen = Player.new(Player.PlayerColor.GREEN, false, 100000)
# 	var aiRed = Player.new(Player.PlayerColor.RED, false, 100000)
# 	var aiYellow = Player.new(Player.PlayerColor.YELLOW, false, 100000)

# 	# Generate 2 cards for each player
# 	for i in range(2):
# 		# flipped_card_texture = load("res://assets/ui/cards_alt/card_back_pix.png")

# 		new_card = deck.draw_card()
# 		flipped_card_texture = load("res://assets/ui/cards_pixel/" + str(new_card.suit) + str(new_card.value) + ".png")
# 		# Send a signal to the ui script to update the player's hand
		

# 	# Add 5 cards to the table
# 	for i in range(5):
# 		# var flipped_card_texture = load("res://assets/ui/cards_alt/card_back_pix.png")
# 		var flipped_card_texture = load("res://assets/ui/cards_pixel/2_spades.png")
# 		# var flipped_texture_rect = TextureRect.new()
# 		# flipped_texture_rect.texture = flipped_card_texture

# 		# # Add to hboxcontainer (visual representation of cards)
# 		# $Pot/table.add_child(flipped_texture_rect)

# 	# var new_card = deck.draw_card()
# 	# player.hand.add_card(new_card)

# 	# print(player.get_hand())
# 	# print(deck.get_deck_state())

# 	# var second_new_card = deck.draw_card()
# 	# player.hand.add_card(second_new_card)

# 	# print(player.get_hand())
# 	# print(deck.get_deck_state())
	
# 	# for i in range(5):
# 	# 	player.hand.add_card(deck.draw_card())
# 	# for i in range(5):
# 	# 	print(player.hand.cards[i].suit,player.hand.cards[i].value)
# 	# player.hand.rank_hand()
	
# 	# Some tests to see if the classes are working as expected
# 	pass

# # Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta):
# 	pass
