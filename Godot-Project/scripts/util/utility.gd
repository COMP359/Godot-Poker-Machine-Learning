class_name Utility
extends Node

# Returns an array of players who have won the round. If there is a tie, the array will contain all players who have tied.
func determine_winner(players: Array[Player]) -> Array[Player]:
	var highest_ranked_players: Array[Player] = []
	var highest_rank = -1

	for player in players:
		if player.has_folded:
			continue
		if player.hand.ranking.rank > highest_rank:
			highest_rank = player.hand.ranking.rank
			highest_ranked_players.clear()
			highest_ranked_players.append(player)
		elif player.hand.ranking.rank == highest_rank:
			highest_ranked_players.append(player)

	if highest_ranked_players.size() > 1:
		var winners: Array[Player] = []
		winners = determine_tie(highest_ranked_players, highest_rank)
		return winners
	else:
		return highest_ranked_players

# Determines the winner(s) in the event of a tie.
func determine_tie(players_with_same_rank: Array[Player], tied_rank: int) -> Array[Player]:
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
