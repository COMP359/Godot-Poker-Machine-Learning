@tool
extends EditorScript



func _run():
	#create dealer and players
	var dealer: Dealer = Dealer.new()


	# Deal two cards to each player
	for player in dealer.players:
		var hand: Hand = Hand.new()
		hand.add_card(dealer.deck_of_cards.draw_card())
		hand.add_card(dealer.deck_of_cards.draw_card())
		player.hand = hand

	# Deal turn
	dealer.community_cards.add_card(dealer.deck_of_cards.draw_card())
	dealer.community_cards.add_card(dealer.deck_of_cards.draw_card())
	dealer.community_cards.add_card(dealer.deck_of_cards.draw_card())
	dealer.community_cards.add_card(dealer.deck_of_cards.draw_card())

	#print out player and community cards
	print("Player 1 Hand: ", dealer.players[0].hand.cards[0].suit, dealer.players[0].hand.cards[0].value," ", dealer.players[0].hand.cards[1].suit, dealer.players[0].hand.cards[1].value)
	print("Player 2 Hand: ", dealer.players[1].hand.cards[0].suit, dealer.players[1].hand.cards[0].value," ", dealer.players[1].hand.cards[1].suit, dealer.players[1].hand.cards[1].value)
	print("Player 3 Hand: ", dealer.players[2].hand.cards[0].suit, dealer.players[2].hand.cards[0].value," ", dealer.players[2].hand.cards[1].suit, dealer.players[2].hand.cards[1].value)
	print("Player 4 Hand: ", dealer.players[3].hand.cards[0].suit, dealer.players[3].hand.cards[0].value," ", dealer.players[3].hand.cards[1].suit, dealer.players[3].hand.cards[1].value)
	print("Community Cards: ", dealer.community_cards.cards[0].suit, dealer.community_cards.cards[0].value," ", dealer.community_cards.cards[1].suit, dealer.community_cards.cards[1].value," ", dealer.community_cards.cards[2].suit, dealer.community_cards.cards[2].value," ", dealer.community_cards.cards[3].suit, dealer.community_cards.cards[3].value)
	print("\n")
	calculate_percentage(dealer,true,false)

		

func calculate_percentage(dealer,turn,flop):
	#make dictionary to store the number of wins for each player, only if player has not folded
	var player_wins: Dictionary = {}
	for player in dealer.players:
		if not player.has_folded:
			player_wins[player] = 0.0

	#calculate size of deck
	var deck_size = dealer.deck_of_cards.deck_of_cards.size()
	print("Deck size: ",deck_size)

	if turn:
		#determine who is the winner on every turn and add them to the total
		for i in range(0,deck_size):
			#declare current card to be the turn card
			var turn_card = dealer.deck_of_cards.deck_of_cards[i]
			#add the turn card to the community cards
			dealer.community_cards.add_card(turn_card)
			#print out the community cards with the current turn card
			print(dealer.community_cards.cards[0].suit, dealer.community_cards.cards[0].value," ", dealer.community_cards.cards[1].suit, dealer.community_cards.cards[1].value," ", dealer.community_cards.cards[2].suit, dealer.community_cards.cards[2].value," ", dealer.community_cards.cards[3].suit, dealer.community_cards.cards[3].value, " ", dealer.community_cards.cards[4].suit, dealer.community_cards.cards[4].value)


			#assign player ranks with the new community card added
			for player in dealer.players:
				var player_and_community = player.hand.cards + dealer.community_cards.cards
				player.hand.ranking.rank = player.hand.ranking.determine_hand_ranking(player_and_community)

			#determine the winner
			var winners = dealer.determine_winner()

			#print out who won and with what rank
			for player in winners:
				print(player.player_color," wins with ",player.hand.ranking.rank)

			for winner in winners:
				player_wins[winner] += 1
			#remove the turn card from the community cards
			dealer.community_cards.cards.remove_at(4)

		return(calculate_win_percentage(player_wins, deck_size))

	elif flop:
		
		pass
	else:
		# Implement this function to calculate the percentage of winning for each player after the river
		pass
	
	

func calculate_win_percentage(player_wins, deck_size):
	# Convert the number of wins to a win percentage
	for player in player_wins:
		player_wins[player] = (player_wins[player] / deck_size) *100
		player_wins[player] = round(player_wins[player] * 100) / 100
		
	print(player_wins)
	return player_wins




