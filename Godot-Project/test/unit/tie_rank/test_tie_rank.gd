extends GutTest

class TestRoyalFlushTie:
	extends GutTest
	var dealer = null

	func before_each():
		dealer = Dealer.new()
		# Hands get automatically created on the dealer class
		# This is just to clear the hands so we can test the hands we want
		dealer.community_cards.clear_hand()
		dealer.players[0].hand.clear_hand()

	func test_royal_flush_case_one():
		var dealer_hands: Hand = Hand.new()
		var player_one_hand_cards: Array[Card] = [Card.new('S', 10), Card.new('S', 11)]
		var dealer_hand_cards: Array[Card] = [Card.new('S', 12), Card.new('S', 13), Card.new('S', 14), Card.new('C', 7), Card.new('D', 9)]
		dealer_hands.add_mulitple_cards(dealer_hand_cards)
		dealer.players[0].hand.add_mulitple_cards(player_one_hand_cards)

		dealer.players[0].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_one_hand_cards)

		var player_tied: Array[Player] = [dealer.players[0]]
		assert_eq(dealer.determine_tie(player_tied, Rank.RankEnum.ROYAL_FLUSH), [dealer.players[0]])

class TestStraightFlushTie:
	extends GutTest

	var dealer = null

	func before_each():
		dealer = Dealer.new()
		# Hands get automatically created on the dealer class
		# This is just to clear the hands so we can test the hands we want
		dealer.community_cards.clear_hand()
		dealer.players[0].hand.clear_hand()
		dealer.players[1].hand.clear_hand()
		dealer.players[2].hand.clear_hand()
		dealer.players[3].hand.clear_hand()

	func test_straight_flush_case_one():
		var dealer_hands: Hand = Hand.new()
		var player_one_hand_cards: Array[Card] = [Card.new('H', 2), Card.new('H', 3)]
		var player_two_hand_cards: Array[Card] = [Card.new('H', 7), Card.new('H', 8)]
		var dealer_hand_cards: Array[Card] = [Card.new('H', 4), Card.new('H', 5), Card.new('H', 6), Card.new('C', 7), Card.new('D', 9)]
		dealer_hands.add_mulitple_cards(dealer_hand_cards)
		dealer.players[0].hand.add_mulitple_cards(player_one_hand_cards)
		dealer.players[1].hand.add_mulitple_cards(player_two_hand_cards)

		dealer.players[0].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_one_hand_cards)
		dealer.players[1].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_two_hand_cards)

		var player_tied: Array[Player] = [dealer.players[0], dealer.players[1]]
		assert_eq(dealer.determine_tie(player_tied, Rank.RankEnum.STRAIGHT_FLUSH), [dealer.players[1]])

	func test_straight_flush_case_two():
		var dealer_hands: Hand = Hand.new()
		var player_one_hand_cards: Array[Card] = [Card.new('H', 2), Card.new('H', 3)]
		var player_two_hand_cards: Array[Card] = [Card.new('H', 2), Card.new('H', 3)]
		var dealer_hand_cards: Array[Card] = [Card.new('H', 4), Card.new('H', 5), Card.new('H', 6), Card.new('C', 7), Card.new('D', 9)]
		dealer_hands.add_mulitple_cards(dealer_hand_cards)
		dealer.players[0].hand.add_mulitple_cards(player_one_hand_cards)
		dealer.players[1].hand.add_mulitple_cards(player_two_hand_cards)

		dealer.players[0].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_one_hand_cards)
		dealer.players[1].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_two_hand_cards)

		var player_tied: Array[Player] = [dealer.players[0], dealer.players[1]]
		assert_eq(dealer.determine_tie(player_tied, Rank.RankEnum.STRAIGHT_FLUSH), [dealer.players[0], dealer.players[1]])

	func test_straight_flush_case_three():
		var dealer_hands: Hand = Hand.new()
		var player_one_hand_cards: Array[Card] = [Card.new('H', 2), Card.new('H', 3)]
		var player_two_hand_cards: Array[Card] = [Card.new('H', 3), Card.new('H', 4)]
		var player_three_hand_cards: Array[Card] = [Card.new('H', 9), Card.new('H', 10)]
		var dealer_hand_cards: Array[Card] = [Card.new('H', 4), Card.new('H', 5), Card.new('H', 6), Card.new('H', 7), Card.new('H', 8)]
		dealer_hands.add_mulitple_cards(dealer_hand_cards)
		dealer.players[0].hand.add_mulitple_cards(player_one_hand_cards)
		dealer.players[1].hand.add_mulitple_cards(player_two_hand_cards)
		dealer.players[2].hand.add_mulitple_cards(player_three_hand_cards)

		dealer.players[0].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_one_hand_cards)
		dealer.players[1].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_two_hand_cards)
		dealer.players[2].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_three_hand_cards)

		var player_tied: Array[Player] = [dealer.players[0], dealer.players[1], dealer.players[2]]
		assert_eq(dealer.determine_tie(player_tied, Rank.RankEnum.STRAIGHT_FLUSH), [dealer.players[2]])

	func test_straight_flush_case_four():
		var dealer_hands: Hand = Hand.new()
		var player_one_hand_cards: Array[Card] = [Card.new('H', 2), Card.new('H', 3)]
		var player_two_hand_cards: Array[Card] = [Card.new('D', 8), Card.new('C', 4)]
		var player_three_hand_cards: Array[Card] = [Card.new('C', 9), Card.new('S', 10)]
		var player_four_hand_cards: Array[Card] = [Card.new('S', 2), Card.new('C', 7)]
		var dealer_hand_cards: Array[Card] = [Card.new('H', 4), Card.new('H', 5), Card.new('H', 6), Card.new('H', 7), Card.new('H', 8)]
		dealer_hands.add_mulitple_cards(dealer_hand_cards)
		dealer.players[0].hand.add_mulitple_cards(player_one_hand_cards)
		dealer.players[1].hand.add_mulitple_cards(player_two_hand_cards)
		dealer.players[2].hand.add_mulitple_cards(player_three_hand_cards)
		dealer.players[3].hand.add_mulitple_cards(player_four_hand_cards)

		dealer.players[0].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_one_hand_cards)
		dealer.players[1].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_two_hand_cards)
		dealer.players[2].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_three_hand_cards)
		dealer.players[3].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_four_hand_cards)

		var player_tied: Array[Player] = [dealer.players[0], dealer.players[1], dealer.players[2], dealer.players[3]]
		assert_eq(dealer.determine_tie(player_tied, Rank.RankEnum.STRAIGHT_FLUSH), [dealer.players[0], dealer.players[1], dealer.players[2], dealer.players[3]])

class TestStraightTie:
	extends GutTest

	var dealer = null

	func before_each():
		dealer = Dealer.new()
		# Hands get automatically created on the dealer class
		# This is just to clear the hands so we can test the hands we want
		dealer.community_cards.clear_hand()
		dealer.players[0].hand.clear_hand()
		dealer.players[1].hand.clear_hand()
		dealer.players[2].hand.clear_hand()
		dealer.players[3].hand.clear_hand()

	func test_straight_case_one():
		var dealer_hands: Hand = Hand.new()
		var player_one_hand_cards: Array[Card] = [Card.new('C', 2), Card.new('H', 3)]
		var player_two_hand_cards: Array[Card] = [Card.new('D', 7), Card.new('C', 8)]
		var dealer_hand_cards: Array[Card] = [Card.new('D', 4), Card.new('S', 5), Card.new('C', 6), Card.new('C', 7), Card.new('D', 9)]
		dealer_hands.add_mulitple_cards(dealer_hand_cards)
		dealer.players[0].hand.add_mulitple_cards(player_one_hand_cards)
		dealer.players[1].hand.add_mulitple_cards(player_two_hand_cards)

		dealer.players[0].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_one_hand_cards)
		dealer.players[1].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_two_hand_cards)

		var player_tied: Array[Player] = [dealer.players[0], dealer.players[1]]
		assert_eq(dealer.determine_tie(player_tied, Rank.RankEnum.STRAIGHT), [dealer.players[1]])

	func test_straight_case_two():
		var dealer_hands: Hand = Hand.new()
		var player_one_hand_cards: Array[Card] = [Card.new('C', 2), Card.new('H', 3)]
		var player_two_hand_cards: Array[Card] = [Card.new('D', 2), Card.new('C', 3)]
		var dealer_hand_cards: Array[Card] = [Card.new('S', 4), Card.new('S', 5), Card.new('S', 6), Card.new('C', 7), Card.new('D', 9)]
		dealer_hands.add_mulitple_cards(dealer_hand_cards)
		dealer.players[0].hand.add_mulitple_cards(player_one_hand_cards)
		dealer.players[1].hand.add_mulitple_cards(player_two_hand_cards)

		dealer.players[0].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_one_hand_cards)
		dealer.players[1].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_two_hand_cards)

		var player_tied: Array[Player] = [dealer.players[0], dealer.players[1]]
		assert_eq(dealer.determine_tie(player_tied, Rank.RankEnum.STRAIGHT), [dealer.players[0], dealer.players[1]])

	func test_straight_case_three():
		var dealer_hands: Hand = Hand.new()
		var player_one_hand_cards: Array[Card] = [Card.new('C', 2), Card.new('S', 3)]
		var player_two_hand_cards: Array[Card] = [Card.new('H', 3), Card.new('D', 4)]
		var player_three_hand_cards: Array[Card] = [Card.new('D', 9), Card.new('D', 10)]
		var dealer_hand_cards: Array[Card] = [Card.new('C', 4), Card.new('D', 5), Card.new('S', 6), Card.new('H', 7), Card.new('H', 8)]
		dealer_hands.add_mulitple_cards(dealer_hand_cards)
		dealer.players[0].hand.add_mulitple_cards(player_one_hand_cards)
		dealer.players[1].hand.add_mulitple_cards(player_two_hand_cards)
		dealer.players[2].hand.add_mulitple_cards(player_three_hand_cards)

		dealer.players[0].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_one_hand_cards)
		dealer.players[1].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_two_hand_cards)
		dealer.players[2].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_three_hand_cards)

		var player_tied: Array[Player] = [dealer.players[0], dealer.players[1], dealer.players[2]]
		assert_eq(dealer.determine_tie(player_tied, Rank.RankEnum.STRAIGHT), [dealer.players[2]])

class TestFourOfKindTie:
	extends GutTest
	var dealer = null

	func before_each():
		dealer = Dealer.new()
		# Hands get automatically created on the dealer class
		# This is just to clear the hands so we can test the hands we want
		dealer.community_cards.clear_hand()
		dealer.players[0].hand.clear_hand()
		dealer.players[1].hand.clear_hand()

	func test_four_of_kind_case_one():
		var dealer_hands: Hand = Hand.new()
		var player_one_hand_cards: Array[Card] = [Card.new('S', 10), Card.new('C', 10)]
		var player_two_hand_cards: Array[Card] = [Card.new('C', 9), Card.new('S', 11)]
		var dealer_hand_cards: Array[Card] = [Card.new('D', 10), Card.new('H', 10), Card.new('D', 9), Card.new('H', 9), Card.new('S', 9)]
		dealer_hands.add_mulitple_cards(dealer_hand_cards)
		dealer.players[0].hand.add_mulitple_cards(player_one_hand_cards)
		dealer.players[1].hand.add_mulitple_cards(player_two_hand_cards)

		dealer.players[0].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_one_hand_cards)
		dealer.players[1].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_two_hand_cards)

		var player_tied: Array[Player] = [dealer.players[0], dealer.players[1]]
		assert_eq(dealer.determine_tie(player_tied, Rank.RankEnum.FOUR_OF_A_KIND), [dealer.players[0]])

	func test_four_of_kind_case_two():
		var dealer_hands: Hand = Hand.new()
		var player_one_hand_cards: Array[Card] = [Card.new('S', 10), Card.new('C', 2)]
		var player_two_hand_cards: Array[Card] = [Card.new('C', 10), Card.new('D', 13)]
		var dealer_hand_cards: Array[Card] = [Card.new('D', 10), Card.new('H', 10), Card.new('D', 9), Card.new('H', 9), Card.new('S', 2)]
		dealer_hands.add_mulitple_cards(dealer_hand_cards)
		dealer.players[0].hand.add_mulitple_cards(player_one_hand_cards)
		dealer.players[1].hand.add_mulitple_cards(player_two_hand_cards)

		dealer.players[0].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_one_hand_cards)
		dealer.players[1].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_two_hand_cards)

		var player_tied: Array[Player] = [dealer.players[0], dealer.players[1]]
		assert_eq(dealer.determine_tie(player_tied, Rank.RankEnum.FOUR_OF_A_KIND), [dealer.players[1]])

	func test_four_of_kind_case_three():
		var dealer_hands: Hand = Hand.new()
		var player_one_hand_cards: Array[Card] = [Card.new('S', 10), Card.new('C', 2)]
		var player_two_hand_cards: Array[Card] = [Card.new('C', 10), Card.new('D', 2)]
		var dealer_hand_cards: Array[Card] = [Card.new('D', 10), Card.new('H', 10), Card.new('D', 9), Card.new('H', 9), Card.new('S', 2)]
		dealer_hands.add_mulitple_cards(dealer_hand_cards)
		dealer.players[0].hand.add_mulitple_cards(player_one_hand_cards)
		dealer.players[1].hand.add_mulitple_cards(player_two_hand_cards)

		dealer.players[0].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_one_hand_cards)
		dealer.players[1].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_two_hand_cards)

		var player_tied: Array[Player] = [dealer.players[0], dealer.players[1]]
		assert_eq(dealer.determine_tie(player_tied, Rank.RankEnum.FOUR_OF_A_KIND), [dealer.players[0], dealer.players[1]])

class TestThreeOfKindTie:
	extends GutTest
	var dealer = null

	func before_each():
		dealer = Dealer.new()
		# Hands get automatically created on the dealer class
		# This is just to clear the hands so we can test the hands we want
		dealer.community_cards.clear_hand()
		dealer.players[0].hand.clear_hand()
		dealer.players[1].hand.clear_hand()

	func test_three_of_kind_case_one():
		var dealer_hands: Hand = Hand.new()
		var player_one_hand_cards: Array[Card] = [Card.new('S', 10), Card.new('D', 11)]
		var player_two_hand_cards: Array[Card] = [Card.new('C', 10), Card.new('H', 11)]
		var dealer_hand_cards: Array[Card] = [Card.new('D', 10), Card.new('S', 7), Card.new('D', 2), Card.new('H', 9), Card.new('S', 9)]
		dealer_hands.add_mulitple_cards(dealer_hand_cards)
		dealer.players[0].hand.add_mulitple_cards(player_one_hand_cards)
		dealer.players[1].hand.add_mulitple_cards(player_two_hand_cards)

		dealer.players[0].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_one_hand_cards)
		dealer.players[1].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_two_hand_cards)

		var player_tied: Array[Player] = [dealer.players[0], dealer.players[1]]
		assert_eq(dealer.determine_tie(player_tied, Rank.RankEnum.THREE_OF_A_KIND), [dealer.players[0], dealer.players[1]])

	func test_three_of_kind_case_two():
		var dealer_hands: Hand = Hand.new()
		var player_one_hand_cards: Array[Card] = [Card.new('S', 10), Card.new('D', 12)]
		var player_two_hand_cards: Array[Card] = [Card.new('C', 11), Card.new('H', 13)]
		var dealer_hand_cards: Array[Card] = [Card.new('D', 10), Card.new('C', 10), Card.new('D', 11), Card.new('H', 11), Card.new('S', 9)]
		dealer_hands.add_mulitple_cards(dealer_hand_cards)
		dealer.players[0].hand.add_mulitple_cards(player_one_hand_cards)
		dealer.players[1].hand.add_mulitple_cards(player_two_hand_cards)

		dealer.players[0].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_one_hand_cards)
		dealer.players[1].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_two_hand_cards)

		var player_tied: Array[Player] = [dealer.players[0], dealer.players[1]]
		assert_eq(dealer.determine_tie(player_tied, Rank.RankEnum.THREE_OF_A_KIND), [dealer.players[1]])

	func test_three_of_kind_case_three():
		var dealer_hands: Hand = Hand.new()
		var player_one_hand_cards: Array[Card] = [Card.new('S', 10), Card.new('C', 2)]
		var player_two_hand_cards: Array[Card] = [Card.new('C', 10), Card.new('D', 3)]
		var dealer_hand_cards: Array[Card] = [Card.new('D', 10), Card.new('H', 10), Card.new('D', 8), Card.new('H', 9), Card.new('S', 7)]
		dealer_hands.add_mulitple_cards(dealer_hand_cards)
		dealer.players[0].hand.add_mulitple_cards(player_one_hand_cards)
		dealer.players[1].hand.add_mulitple_cards(player_two_hand_cards)

		dealer.players[0].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_one_hand_cards)
		dealer.players[1].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_two_hand_cards)

		var player_tied: Array[Player] = [dealer.players[0], dealer.players[1]]
		assert_eq(dealer.determine_tie(player_tied, Rank.RankEnum.THREE_OF_A_KIND), [dealer.players[1]])

class TestFlushTie:
	extends GutTest
	var dealer = null

	func before_each():
		dealer = Dealer.new()
		# Hands get automatically created on the dealer class
		# This is just to clear the hands so we can test the hands we want
		dealer.community_cards.clear_hand()
		dealer.players[0].hand.clear_hand()
		dealer.players[1].hand.clear_hand()
		dealer.players[2].hand.clear_hand()
		dealer.players[3].hand.clear_hand()

	func test_flush_case_one():
		var dealer_hands: Hand = Hand.new()
		var player_one_hand_cards: Array[Card] = [Card.new('C', 10), Card.new('C', 11)]
		var player_two_hand_cards: Array[Card] = [Card.new('C', 10), Card.new('C', 12)]
		var dealer_hand_cards: Array[Card] = [Card.new('C', 10), Card.new('C', 7), Card.new('C', 2), Card.new('H', 9), Card.new('S', 9)]
		dealer_hands.add_mulitple_cards(dealer_hand_cards)
		dealer.players[0].hand.add_mulitple_cards(player_one_hand_cards)
		dealer.players[1].hand.add_mulitple_cards(player_two_hand_cards)

		dealer.players[0].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_one_hand_cards)
		dealer.players[1].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_two_hand_cards)

		var player_tied: Array[Player] = [dealer.players[0], dealer.players[1]]
		assert_eq(dealer.determine_tie(player_tied, Rank.RankEnum.FLUSH), [dealer.players[1]])
		
	func test_flush_case_two():
		var dealer_hands: Hand = Hand.new()
		var player_one_hand_cards: Array[Card] = [Card.new('C', 10), Card.new('C', 11)]
		var player_two_hand_cards: Array[Card] = [Card.new('C', 10), Card.new('C', 11)]
		var dealer_hand_cards: Array[Card] = [Card.new('C', 10), Card.new('C', 7), Card.new('C', 2), Card.new('H', 9), Card.new('S', 9)]
		dealer_hands.add_mulitple_cards(dealer_hand_cards)
		dealer.players[0].hand.add_mulitple_cards(player_one_hand_cards)
		dealer.players[1].hand.add_mulitple_cards(player_two_hand_cards)

		dealer.players[0].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_one_hand_cards)
		dealer.players[1].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_two_hand_cards)

		var player_tied: Array[Player] = [dealer.players[0], dealer.players[1]]
		assert_eq(dealer.determine_tie(player_tied, Rank.RankEnum.FLUSH), [dealer.players[0],dealer.players[1]])

	func test_flush_case_three():
		var dealer_hands: Hand = Hand.new()
		var player_one_hand_cards: Array[Card] = [Card.new('C', 10), Card.new('C', 12)]
		var player_two_hand_cards: Array[Card] = [Card.new('C', 10), Card.new('C', 11)]
		var dealer_hand_cards: Array[Card] = [Card.new('C', 10), Card.new('C', 7), Card.new('C', 2), Card.new('H', 9), Card.new('S', 9)]
		dealer_hands.add_mulitple_cards(dealer_hand_cards)
		dealer.players[0].hand.add_mulitple_cards(player_one_hand_cards)
		dealer.players[1].hand.add_mulitple_cards(player_two_hand_cards)

		dealer.players[0].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_one_hand_cards)
		dealer.players[1].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_two_hand_cards)

		var player_tied: Array[Player] = [dealer.players[0], dealer.players[1]]
		assert_eq(dealer.determine_tie(player_tied, Rank.RankEnum.FLUSH), [dealer.players[0]])

	func test_flush_case_four():
		var dealer_hands: Hand = Hand.new()
		var player_one_hand_cards: Array[Card] = [Card.new('C', 2), Card.new('C', 5)]
		var player_two_hand_cards: Array[Card] = [Card.new('C', 3), Card.new('C', 5)]
		var dealer_hand_cards: Array[Card] = [Card.new('C', 10), Card.new('C', 9), Card.new('C', 8), Card.new('H', 9), Card.new('S', 9)]
		dealer_hands.add_mulitple_cards(dealer_hand_cards)
		dealer.players[0].hand.add_mulitple_cards(player_one_hand_cards)
		dealer.players[1].hand.add_mulitple_cards(player_two_hand_cards)

		dealer.players[0].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_one_hand_cards)
		dealer.players[1].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_two_hand_cards)

		var player_tied: Array[Player] = [dealer.players[0], dealer.players[1]]
		assert_eq(dealer.determine_tie(player_tied, Rank.RankEnum.FLUSH), [dealer.players[1]])

	func test_flush_case_five():
		var dealer_hands: Hand = Hand.new()
		var player_one_hand_cards: Array[Card] = [Card.new('C', 5), Card.new('S', 8)]
		var player_two_hand_cards: Array[Card] = [Card.new('C', 11), Card.new('S', 9)]
		var player_three_hand_cards: Array[Card] = [Card.new('C', 10), Card.new('S', 13)]
		var dealer_hand_cards: Array[Card] = [Card.new('C', 3), Card.new('C', 2), Card.new('C', 4), Card.new('C', 9), Card.new('S', 9)]
		dealer_hands.add_mulitple_cards(dealer_hand_cards)
		dealer.players[0].hand.add_mulitple_cards(player_one_hand_cards)
		dealer.players[1].hand.add_mulitple_cards(player_two_hand_cards)

		dealer.players[0].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_one_hand_cards)
		dealer.players[1].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_two_hand_cards)

		var player_tied: Array[Player] = [dealer.players[0], dealer.players[1]]
		assert_eq(dealer.determine_tie(player_tied, Rank.RankEnum.FLUSH), [dealer.players[1]])

class TestFullHouseTie:
	extends GutTest
	var dealer = null

	func before_each():
		dealer = Dealer.new()
		# Hands get automatically created on the dealer class
		# This is just to clear the hands so we can test the hands we want
		dealer.community_cards.clear_hand()
		dealer.players[0].hand.clear_hand()
		dealer.players[1].hand.clear_hand()
		dealer.players[2].hand.clear_hand()
		dealer.players[3].hand.clear_hand()

	func test_full_house_case_one():
		var dealer_hands: Hand = Hand.new()
		var player_one_hand_cards: Array[Card] = [Card.new('C', 10), Card.new('C', 10)]
		var player_two_hand_cards: Array[Card] = [Card.new('C', 12), Card.new('C', 12)]
		var dealer_hand_cards: Array[Card] = [Card.new('C', 10), Card.new('C', 12), Card.new('C', 2), Card.new('H', 2), Card.new('S', 9)]
		dealer_hands.add_mulitple_cards(dealer_hand_cards)
		dealer.players[0].hand.add_mulitple_cards(player_one_hand_cards)
		dealer.players[1].hand.add_mulitple_cards(player_two_hand_cards)

		dealer.players[0].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_one_hand_cards)
		dealer.players[1].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_two_hand_cards)

		var player_tied: Array[Player] = [dealer.players[0], dealer.players[1]]
		assert_eq(dealer.determine_tie(player_tied, Rank.RankEnum.FULL_HOUSE), [dealer.players[1]])

	func test_full_house_case_two():
		var dealer_hands: Hand = Hand.new()
		var player_one_hand_cards: Array[Card] = [Card.new('C', 12), Card.new('C', 12)]
		var player_two_hand_cards: Array[Card] = [Card.new('C', 10), Card.new('C', 10)]
		var dealer_hand_cards: Array[Card] = [Card.new('C', 10), Card.new('C', 12), Card.new('C', 2), Card.new('H', 2), Card.new('S', 9)]
		dealer_hands.add_mulitple_cards(dealer_hand_cards)
		dealer.players[0].hand.add_mulitple_cards(player_one_hand_cards)
		dealer.players[1].hand.add_mulitple_cards(player_two_hand_cards)

		dealer.players[0].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_one_hand_cards)
		dealer.players[1].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_two_hand_cards)

		var player_tied: Array[Player] = [dealer.players[0], dealer.players[1]]
		assert_eq(dealer.determine_tie(player_tied, Rank.RankEnum.FULL_HOUSE), [dealer.players[0]])

	func test_full_house_case_three():
		var dealer_hands: Hand = Hand.new()
		var player_one_hand_cards: Array[Card] = [Card.new('C', 12), Card.new('C', 8)]
		var player_two_hand_cards: Array[Card] = [Card.new('C', 12), Card.new('C', 7)]
		var dealer_hand_cards: Array[Card] = [Card.new('C', 12), Card.new('C', 12), Card.new('C', 8), Card.new('H', 7), Card.new('S', 9)]
		dealer_hands.add_mulitple_cards(dealer_hand_cards)
		dealer.players[0].hand.add_mulitple_cards(player_one_hand_cards)
		dealer.players[1].hand.add_mulitple_cards(player_two_hand_cards)

		dealer.players[0].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_one_hand_cards)
		dealer.players[1].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_two_hand_cards)

		var player_tied: Array[Player] = [dealer.players[0], dealer.players[1]]
		assert_eq(dealer.determine_tie(player_tied, Rank.RankEnum.FULL_HOUSE), [dealer.players[0]])

	func test_full_house_case_four():
		var dealer_hands: Hand = Hand.new()
		var player_one_hand_cards: Array[Card] = [Card.new('C', 12), Card.new('C', 8)]
		var player_two_hand_cards: Array[Card] = [Card.new('C', 12), Card.new('C', 8)]
		var dealer_hand_cards: Array[Card] = [Card.new('C', 12), Card.new('C', 12), Card.new('C', 8), Card.new('H', 7), Card.new('S', 9)]
		dealer_hands.add_mulitple_cards(dealer_hand_cards)
		dealer.players[0].hand.add_mulitple_cards(player_one_hand_cards)
		dealer.players[1].hand.add_mulitple_cards(player_two_hand_cards)

		dealer.players[0].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_one_hand_cards)
		dealer.players[1].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_two_hand_cards)

		var player_tied: Array[Player] = [dealer.players[0], dealer.players[1]]
		assert_eq(dealer.determine_tie(player_tied, Rank.RankEnum.FULL_HOUSE), [dealer.players[0], dealer.players[1]])

	func test_full_house_case_five():
		var dealer_hands: Hand = Hand.new()
		var player_one_hand_cards: Array[Card] = [Card.new('C', 12), Card.new('C', 7)]
		var player_two_hand_cards: Array[Card] = [Card.new('C', 12), Card.new('C', 8)]
		var dealer_hand_cards: Array[Card] = [Card.new('C', 12), Card.new('C', 12), Card.new('C', 8), Card.new('H', 7), Card.new('S', 9)]
		dealer_hands.add_mulitple_cards(dealer_hand_cards)
		dealer.players[0].hand.add_mulitple_cards(player_one_hand_cards)
		dealer.players[1].hand.add_mulitple_cards(player_two_hand_cards)

		dealer.players[0].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_one_hand_cards)
		dealer.players[1].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_two_hand_cards)

		var player_tied: Array[Player] = [dealer.players[0], dealer.players[1]]
		assert_eq(dealer.determine_tie(player_tied, Rank.RankEnum.FULL_HOUSE), [dealer.players[1]])

	func test_full_house_case_six():
		var dealer_hands: Hand = Hand.new()
		var player_one_hand_cards: Array[Card] = [Card.new('S', 2), Card.new('C', 2)]
		var player_two_hand_cards: Array[Card] = [Card.new('D', 3), Card.new('H', 3)]
		var player_three_hand_cards: Array[Card] = [Card.new('C', 4), Card.new('D', 4)]
		var dealer_hand_cards: Array[Card] = [Card.new('S', 5), Card.new('C', 5), Card.new('H', 5), Card.new('H', 7), Card.new('S', 9)]
		dealer_hands.add_mulitple_cards(dealer_hand_cards)
		dealer.players[0].hand.add_mulitple_cards(player_one_hand_cards)
		dealer.players[1].hand.add_mulitple_cards(player_two_hand_cards)
		dealer.players[2].hand.add_mulitple_cards(player_three_hand_cards)

		dealer.players[0].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_one_hand_cards)
		dealer.players[1].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_two_hand_cards)
		dealer.players[2].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_three_hand_cards)

		var player_tied: Array[Player] = [dealer.players[0], dealer.players[1], dealer.players[2]]
		assert_eq(dealer.determine_tie(player_tied, Rank.RankEnum.FULL_HOUSE), [dealer.players[2]])

	func test_full_house_case_seven():
		var dealer_hands: Hand = Hand.new()
		var player_one_hand_cards: Array[Card] = [Card.new('S', 2), Card.new('C', 2)]
		var player_two_hand_cards: Array[Card] = [Card.new('H', 2), Card.new('D', 2)]
		var dealer_hand_cards: Array[Card] = [Card.new('S', 5), Card.new('C', 5), Card.new('H', 5), Card.new('H', 7), Card.new('S', 9)]
		dealer_hands.add_mulitple_cards(dealer_hand_cards)
		dealer.players[0].hand.add_mulitple_cards(player_one_hand_cards)
		dealer.players[1].hand.add_mulitple_cards(player_two_hand_cards)

		dealer.players[0].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_one_hand_cards)
		dealer.players[1].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_two_hand_cards)

		var player_tied: Array[Player] = [dealer.players[0], dealer.players[1]]
		assert_eq(dealer.determine_tie(player_tied, Rank.RankEnum.FULL_HOUSE), [dealer.players[0], dealer.players[1]])

	func test_full_house_case_eight():
		var dealer_hands: Hand = Hand.new()
		var player_one_hand_cards: Array[Card] = [Card.new('D', 8), Card.new('D', 13)]
		var player_two_hand_cards: Array[Card] = [Card.new('D', 7), Card.new('H', 6)]
		var player_three_hand_cards: Array[Card] = [Card.new('C', 2), Card.new('C', 3)]
		var player_four_hand_cards: Array[Card] = [Card.new('C', 4), Card.new('D', 14)]
		var dealer_hand_cards: Array[Card] = [Card.new('D', 10), Card.new('C', 9), Card.new('D', 9), Card.new('S', 10), Card.new('H', 9)]
		dealer_hands.add_mulitple_cards(dealer_hand_cards)
		dealer.players[0].hand.add_mulitple_cards(player_one_hand_cards)
		dealer.players[1].hand.add_mulitple_cards(player_two_hand_cards)
		dealer.players[2].hand.add_mulitple_cards(player_three_hand_cards)
		dealer.players[3].hand.add_mulitple_cards(player_four_hand_cards)

		dealer.players[0].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_one_hand_cards)
		dealer.players[1].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_two_hand_cards)
		dealer.players[2].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_three_hand_cards)
		dealer.players[3].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_four_hand_cards)

		var player_tied: Array[Player] = [dealer.players[0], dealer.players[1], dealer.players[2], dealer.players[3]]
		assert_eq(dealer.determine_tie(player_tied, Rank.RankEnum.FULL_HOUSE), [dealer.players[0], dealer.players[1], dealer.players[2], dealer.players[3]])

class TestTwoPairTie:
	extends GutTest
	var dealer = null

	func before_each():
		dealer = Dealer.new()
		# Hands get automatically created on the dealer class
		# This is just to clear the hands so we can test the hands we want
		dealer.community_cards.clear_hand()
		dealer.players[0].hand.clear_hand()
		dealer.players[1].hand.clear_hand()
		dealer.players[2].hand.clear_hand()
		dealer.players[3].hand.clear_hand()

	func test_two_pair_case_one():
		var dealer_hands: Hand = Hand.new()
		var player_one_hand_cards: Array[Card] = [Card.new('D', 9), Card.new('C', 8)]
		var player_two_hand_cards: Array[Card] = [Card.new('S', 9), Card.new('D', 7)]
		var dealer_hand_cards: Array[Card] = [Card.new('C', 9), Card.new('H', 8), Card.new('C', 7), Card.new('H', 2), Card.new('S', 3)]
		dealer_hands.add_mulitple_cards(dealer_hand_cards)
		dealer.players[0].hand.add_mulitple_cards(player_one_hand_cards)
		dealer.players[1].hand.add_mulitple_cards(player_two_hand_cards)

		dealer.players[0].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_one_hand_cards)
		dealer.players[1].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_two_hand_cards)

		var player_tied: Array[Player] = [dealer.players[0], dealer.players[1]]
		assert_eq(dealer.determine_tie(player_tied, Rank.RankEnum.TWO_PAIR), [dealer.players[0]])

	func test_two_pair_case_two():
		var dealer_hands: Hand = Hand.new()
		var player_one_hand_cards: Array[Card] = [Card.new('D', 9), Card.new('C', 11)]
		var player_two_hand_cards: Array[Card] = [Card.new('S', 9), Card.new('D', 2)]
		var dealer_hand_cards: Array[Card] = [Card.new('C', 9), Card.new('H', 8), Card.new('C', 8), Card.new('D', 6), Card.new('S', 3)]
		dealer_hands.add_mulitple_cards(dealer_hand_cards)
		dealer.players[0].hand.add_mulitple_cards(player_one_hand_cards)
		dealer.players[1].hand.add_mulitple_cards(player_two_hand_cards)

		dealer.players[0].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_one_hand_cards)
		dealer.players[1].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_two_hand_cards)

		var player_tied: Array[Player] = [dealer.players[0], dealer.players[1]]
		assert_eq(dealer.determine_tie(player_tied, Rank.RankEnum.TWO_PAIR), [dealer.players[0]])

	func test_two_pair_case_three():
		var dealer_hands: Hand = Hand.new()
		var player_one_hand_cards: Array[Card] = [Card.new('D', 9), Card.new('C', 12)]
		var player_two_hand_cards: Array[Card] = [Card.new('S', 9), Card.new('D', 12)]
		var dealer_hand_cards: Array[Card] = [Card.new('C', 9), Card.new('H', 12), Card.new('C', 7), Card.new('D', 6), Card.new('S', 3)]
		dealer_hands.add_mulitple_cards(dealer_hand_cards)
		dealer.players[0].hand.add_mulitple_cards(player_one_hand_cards)
		dealer.players[1].hand.add_mulitple_cards(player_two_hand_cards)

		dealer.players[0].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_one_hand_cards)
		dealer.players[1].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_two_hand_cards)

		var player_tied: Array[Player] = [dealer.players[0], dealer.players[1]]
		assert_eq(dealer.determine_tie(player_tied, Rank.RankEnum.TWO_PAIR), [dealer.players[0], dealer.players[1]])

	func test_two_pair_case_four():
		var dealer_hands: Hand = Hand.new()
		var player_one_hand_cards: Array[Card] = [Card.new('D', 9), Card.new('C', 7)]
		var player_two_hand_cards: Array[Card] = [Card.new('S', 9), Card.new('D', 8)]
		var dealer_hand_cards: Array[Card] = [Card.new('C', 9), Card.new('H', 8), Card.new('C',2), Card.new('H', 7), Card.new('S', 3)]
		dealer_hands.add_mulitple_cards(dealer_hand_cards)
		dealer.players[0].hand.add_mulitple_cards(player_one_hand_cards)
		dealer.players[1].hand.add_mulitple_cards(player_two_hand_cards)

		dealer.players[0].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_one_hand_cards)
		dealer.players[1].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_two_hand_cards)

		var player_tied: Array[Player] = [dealer.players[0], dealer.players[1]]
		assert_eq(dealer.determine_tie(player_tied, Rank.RankEnum.TWO_PAIR), [dealer.players[1]])

	func test_two_pair_case_five():
		var dealer_hands: Hand = Hand.new()
		var player_one_hand_cards: Array[Card] = [Card.new('D', 9), Card.new('C', 6)]
		var player_two_hand_cards: Array[Card] = [Card.new('S', 9), Card.new('D', 12)]
		var player_three_hand_cards: Array[Card] = [Card.new('S', 9), Card.new('D', 3)]
		var dealer_hand_cards: Array[Card] = [Card.new('C', 9), Card.new('H', 8), Card.new('C',8), Card.new('H', 7), Card.new('S', 2)]
		dealer_hands.add_mulitple_cards(dealer_hand_cards)
		dealer.players[0].hand.add_mulitple_cards(player_one_hand_cards)
		dealer.players[1].hand.add_mulitple_cards(player_two_hand_cards)
		dealer.players[2].hand.add_mulitple_cards(player_three_hand_cards)

		dealer.players[0].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_one_hand_cards)
		dealer.players[1].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_two_hand_cards)
		dealer.players[2].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_three_hand_cards)

		var player_tied: Array[Player] = [dealer.players[0], dealer.players[1], dealer.players[2]]
		assert_eq(dealer.determine_tie(player_tied, Rank.RankEnum.TWO_PAIR), [dealer.players[1]])

	func test_two_pair_case_six():
		var dealer_hands: Hand = Hand.new()
		var player_one_hand_cards: Array[Card] = [Card.new('D', 9), Card.new('C', 6)]
		var player_two_hand_cards: Array[Card] = [Card.new('S', 3), Card.new('D', 8)]
		var player_three_hand_cards: Array[Card] = [Card.new('S', 9), Card.new('H', 11)]
		var player_four_hand_cards: Array[Card] = [Card.new('S', 8), Card.new('D', 4)]
		var dealer_hand_cards: Array[Card] = [Card.new('C', 9), Card.new('H', 8), Card.new('C', 10), Card.new('H', 7), Card.new('S', 2)]
		dealer_hands.add_mulitple_cards(dealer_hand_cards)
		dealer.players[0].hand.add_mulitple_cards(player_one_hand_cards)
		dealer.players[1].hand.add_mulitple_cards(player_two_hand_cards)
		dealer.players[2].hand.add_mulitple_cards(player_three_hand_cards)
		dealer.players[3].hand.add_mulitple_cards(player_four_hand_cards)

		dealer.players[0].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_one_hand_cards)
		dealer.players[1].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_two_hand_cards)
		dealer.players[2].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_three_hand_cards)
		dealer.players[3].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_four_hand_cards)

		var player_tied: Array[Player] = [dealer.players[0], dealer.players[1], dealer.players[2], dealer.players[3]]
		assert_eq(dealer.determine_tie(player_tied, Rank.RankEnum.TWO_PAIR), [dealer.players[2]])

class TestOnePairTie:
	extends GutTest
	var dealer = null

	func before_each():
		dealer = Dealer.new()
		# Hands get automatically created on the dealer class
		# This is just to clear the hands so we can test the hands we want
		dealer.community_cards.clear_hand()
		dealer.players[0].hand.clear_hand()
		dealer.players[1].hand.clear_hand()
		dealer.players[2].hand.clear_hand()
		dealer.players[3].hand.clear_hand()

	func test_one_pair_case_one():
		var dealer_hands: Hand = Hand.new()
		var player_one_hand_cards: Array[Card] = [Card.new('D', 9), Card.new('C', 2)]
		var player_two_hand_cards: Array[Card] = [Card.new('S', 8), Card.new('D', 3)]
		var dealer_hand_cards: Array[Card] = [Card.new('C', 9), Card.new('H', 4), Card.new('C', 8), Card.new('H', 6), Card.new('S', 7)]
		dealer_hands.add_mulitple_cards(dealer_hand_cards)
		dealer.players[0].hand.add_mulitple_cards(player_one_hand_cards)
		dealer.players[1].hand.add_mulitple_cards(player_two_hand_cards)

		dealer.players[0].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_one_hand_cards)
		dealer.players[1].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_two_hand_cards)

		var player_tied: Array[Player] = [dealer.players[0], dealer.players[1]]
		assert_eq(dealer.determine_tie(player_tied, Rank.RankEnum.PAIR), [dealer.players[0]])

	func test_one_pair_case_two():
		var dealer_hands: Hand = Hand.new()
		var player_one_hand_cards: Array[Card] = [Card.new('D', 9), Card.new('C', 8)]
		var player_two_hand_cards: Array[Card] = [Card.new('S', 9), Card.new('D', 11)]
		var dealer_hand_cards: Array[Card] = [Card.new('C', 9), Card.new('H', 4), Card.new('C', 5), Card.new('H', 6), Card.new('S', 7)]
		dealer_hands.add_mulitple_cards(dealer_hand_cards)
		dealer.players[0].hand.add_mulitple_cards(player_one_hand_cards)
		dealer.players[1].hand.add_mulitple_cards(player_two_hand_cards)

		dealer.players[0].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_one_hand_cards)
		dealer.players[1].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_two_hand_cards)

		var player_tied: Array[Player] = [dealer.players[0], dealer.players[1]]
		assert_eq(dealer.determine_tie(player_tied, Rank.RankEnum.PAIR), [dealer.players[1]])

	func test_one_pair_case_three():
		var dealer_hands: Hand = Hand.new()
		var player_one_hand_cards: Array[Card] = [Card.new('D', 9), Card.new('C', 11)]
		var player_two_hand_cards: Array[Card] = [Card.new('S', 9), Card.new('D', 11)]
		var dealer_hand_cards: Array[Card] = [Card.new('C', 9), Card.new('H', 4), Card.new('C', 5), Card.new('H', 6), Card.new('S', 7)]
		dealer_hands.add_mulitple_cards(dealer_hand_cards)
		dealer.players[0].hand.add_mulitple_cards(player_one_hand_cards)
		dealer.players[1].hand.add_mulitple_cards(player_two_hand_cards)

		dealer.players[0].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_one_hand_cards)
		dealer.players[1].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_two_hand_cards)

		var player_tied: Array[Player] = [dealer.players[0], dealer.players[1]]
		assert_eq(dealer.determine_tie(player_tied, Rank.RankEnum.PAIR), [dealer.players[0], dealer.players[1]])

	func test_one_pair_case_four():
		var dealer_hands: Hand = Hand.new()
		var player_one_hand_cards: Array[Card] = [Card.new('D', 9), Card.new('C', 2)]
		var player_two_hand_cards: Array[Card] = [Card.new('S', 9), Card.new('D', 10)]
		var player_three_hand_cards: Array[Card] = [Card.new('S', 9), Card.new('D', 8)]
		var dealer_hand_cards: Array[Card] = [Card.new('C', 9), Card.new('H', 4), Card.new('C', 5), Card.new('H', 6), Card.new('S', 7)]
		dealer_hands.add_mulitple_cards(dealer_hand_cards)
		dealer.players[0].hand.add_mulitple_cards(player_one_hand_cards)
		dealer.players[1].hand.add_mulitple_cards(player_two_hand_cards)
		dealer.players[2].hand.add_mulitple_cards(player_three_hand_cards)

		dealer.players[0].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_one_hand_cards)
		dealer.players[1].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_two_hand_cards)
		dealer.players[2].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_three_hand_cards)

		var player_tied: Array[Player] = [dealer.players[0], dealer.players[1], dealer.players[2]]
		assert_eq(dealer.determine_tie(player_tied, Rank.RankEnum.PAIR), [dealer.players[1]])

	func test_one_pair_case_five():
		var dealer_hands: Hand = Hand.new()
		var player_one_hand_cards: Array[Card] = [Card.new('D', 3), Card.new('C', 2)]
		var player_two_hand_cards: Array[Card] = [Card.new('S', 7), Card.new('D', 10)]
		var player_three_hand_cards: Array[Card] = [Card.new('S', 14), Card.new('D', 8)]
		var player_four_hand_cards: Array[Card] = [Card.new('S', 11), Card.new('D', 5)]
		var dealer_hand_cards: Array[Card] = [Card.new('C', 9), Card.new('H', 9), Card.new('C', 4), Card.new('H', 6), Card.new('S', 12)]
		dealer_hands.add_mulitple_cards(dealer_hand_cards)
		dealer.players[0].hand.add_mulitple_cards(player_one_hand_cards)
		dealer.players[1].hand.add_mulitple_cards(player_two_hand_cards)
		dealer.players[2].hand.add_mulitple_cards(player_three_hand_cards)
		dealer.players[3].hand.add_mulitple_cards(player_four_hand_cards)

		dealer.players[0].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_one_hand_cards)
		dealer.players[1].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_two_hand_cards)
		dealer.players[2].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_three_hand_cards)
		dealer.players[3].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_four_hand_cards)

		var player_tied: Array[Player] = [dealer.players[0], dealer.players[1], dealer.players[2], dealer.players[3]]
		assert_eq(dealer.determine_tie(player_tied, Rank.RankEnum.PAIR), [dealer.players[2]])

	func test_one_pair_case_six():
		var dealer_hands: Hand = Hand.new()
		var player_one_hand_cards: Array[Card] = [Card.new('D', 9), Card.new('C', 2)]
		var player_two_hand_cards: Array[Card] = [Card.new('S', 9), Card.new('D', 4)]
		var player_three_hand_cards: Array[Card] = [Card.new('S', 9), Card.new('S', 4)]
		var dealer_hand_cards: Array[Card] = [Card.new('C', 9), Card.new('H', 7), Card.new('C', 3), Card.new('H', 10), Card.new('S', 5)]
		dealer_hands.add_mulitple_cards(dealer_hand_cards)
		dealer.players[0].hand.add_mulitple_cards(player_one_hand_cards)
		dealer.players[1].hand.add_mulitple_cards(player_two_hand_cards)
		dealer.players[2].hand.add_mulitple_cards(player_three_hand_cards)

		dealer.players[0].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_one_hand_cards)
		dealer.players[1].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_two_hand_cards)
		dealer.players[2].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_three_hand_cards)

		var player_tied: Array[Player] = [dealer.players[0], dealer.players[1], dealer.players[2]]
		assert_eq(dealer.determine_tie(player_tied, Rank.RankEnum.PAIR), [dealer.players[1], dealer.players[2]])

	func test_one_pair_case_seven():
		var dealer_hands: Hand = Hand.new()
		var player_one_hand_cards: Array[Card] = [Card.new('D', 9), Card.new('C', 12)]
		var player_two_hand_cards: Array[Card] = [Card.new('S', 9), Card.new('D', 12)]
		var player_three_hand_cards: Array[Card] = [Card.new('S', 9), Card.new('S', 12)]
		var player_four_hand_cards: Array[Card] = [Card.new('S', 9), Card.new('H', 12)]
		var dealer_hand_cards: Array[Card] = [Card.new('C', 9), Card.new('H', 7), Card.new('C', 3), Card.new('H', 10), Card.new('S', 5)]
		dealer_hands.add_mulitple_cards(dealer_hand_cards)
		dealer.players[0].hand.add_mulitple_cards(player_one_hand_cards)
		dealer.players[1].hand.add_mulitple_cards(player_two_hand_cards)
		dealer.players[2].hand.add_mulitple_cards(player_three_hand_cards)
		dealer.players[3].hand.add_mulitple_cards(player_four_hand_cards)

		dealer.players[0].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_one_hand_cards)
		dealer.players[1].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_two_hand_cards)
		dealer.players[2].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_three_hand_cards)
		dealer.players[3].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_four_hand_cards)

		var player_tied: Array[Player] = [dealer.players[0], dealer.players[1], dealer.players[2], dealer.players[3]]
		assert_eq(dealer.determine_tie(player_tied, Rank.RankEnum.PAIR), [dealer.players[0], dealer.players[1], dealer.players[2], dealer.players[3]])

class TestHighCardTie:
	extends GutTest
	var dealer = null

	func before_each():
		dealer = Dealer.new()
		# Hands get automatically created on the dealer class
		# This is just to clear the hands so we can test the hands we want
		dealer.community_cards.clear_hand()
		dealer.players[0].hand.clear_hand()
		dealer.players[1].hand.clear_hand()
		dealer.players[2].hand.clear_hand()
		dealer.players[3].hand.clear_hand()

	func test_high_card_case_one():
		var dealer_hands: Hand = Hand.new()
		var player_one_hand_cards: Array[Card] = [Card.new('C', 10), Card.new('C', 11)]
		var player_two_hand_cards: Array[Card] = [Card.new('C', 13), Card.new('C', 14)]
		var dealer_hand_cards: Array[Card] = [Card.new('C', 2), Card.new('C', 4), Card.new('C', 6), Card.new('H', 7), Card.new('S', 8)]
		dealer_hands.add_mulitple_cards(dealer_hand_cards)
		dealer.players[0].hand.add_mulitple_cards(player_one_hand_cards)
		dealer.players[1].hand.add_mulitple_cards(player_two_hand_cards)

		dealer.players[0].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_one_hand_cards)
		dealer.players[1].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_two_hand_cards)

		var player_tied: Array[Player] = [dealer.players[0], dealer.players[1]]
		assert_eq(dealer.determine_tie(player_tied, Rank.RankEnum.HIGH_CARD), [dealer.players[1]])

	func test_high_card_case_two():
		var dealer_hands: Hand = Hand.new()
		var player_one_hand_cards: Array[Card] = [Card.new('C', 5), Card.new('C', 12)]
		var player_two_hand_cards: Array[Card] = [Card.new('C', 3), Card.new('C', 10)]
		var dealer_hand_cards: Array[Card] = [Card.new('C', 2), Card.new('C', 4), Card.new('C', 7), Card.new('H', 8), Card.new('S', 13)]
		dealer_hands.add_mulitple_cards(dealer_hand_cards)
		dealer.players[0].hand.add_mulitple_cards(player_one_hand_cards)
		dealer.players[1].hand.add_mulitple_cards(player_two_hand_cards)

		dealer.players[0].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_one_hand_cards)
		dealer.players[1].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_two_hand_cards)

		var player_tied: Array[Player] = [dealer.players[0], dealer.players[1]]
		assert_eq(dealer.determine_tie(player_tied, Rank.RankEnum.HIGH_CARD), [dealer.players[0]])

	func test_high_card_case_three():
		var dealer_hands: Hand = Hand.new()
		var player_one_hand_cards: Array[Card] = [Card.new('C', 5), Card.new('C', 12)]
		var player_two_hand_cards: Array[Card] = [Card.new('C', 3), Card.new('C', 12)]
		var dealer_hand_cards: Array[Card] = [Card.new('C', 2), Card.new('C', 4), Card.new('C', 7), Card.new('H', 8), Card.new('S', 13)]
		dealer_hands.add_mulitple_cards(dealer_hand_cards)
		dealer.players[0].hand.add_mulitple_cards(player_one_hand_cards)
		dealer.players[1].hand.add_mulitple_cards(player_two_hand_cards)

		dealer.players[0].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_one_hand_cards)
		dealer.players[1].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_two_hand_cards)

		var player_tied: Array[Player] = [dealer.players[0], dealer.players[1]]
		assert_eq(dealer.determine_tie(player_tied, Rank.RankEnum.HIGH_CARD), [dealer.players[0]])

	func test_high_card_case_four():
		var dealer_hands: Hand = Hand.new()
		var player_one_hand_cards: Array[Card] = [Card.new('C', 5), Card.new('C', 12)]
		var player_two_hand_cards: Array[Card] = [Card.new('C', 5), Card.new('C', 12)]
		var dealer_hand_cards: Array[Card] = [Card.new('C', 2), Card.new('C', 4), Card.new('C', 7), Card.new('H', 8), Card.new('S', 13)]
		dealer_hands.add_mulitple_cards(dealer_hand_cards)
		dealer.players[0].hand.add_mulitple_cards(player_one_hand_cards)
		dealer.players[1].hand.add_mulitple_cards(player_two_hand_cards)

		dealer.players[0].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_one_hand_cards)
		dealer.players[1].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_two_hand_cards)

		var player_tied: Array[Player] = [dealer.players[0], dealer.players[1]]
		assert_eq(dealer.determine_tie(player_tied, Rank.RankEnum.HIGH_CARD), [dealer.players[0], dealer.players[1]])

	func test_high_card_case_five():
		var dealer_hands: Hand = Hand.new()
		var player_one_hand_cards: Array[Card] = [Card.new('C', 9), Card.new('C', 12)]
		var player_two_hand_cards: Array[Card] = [Card.new('C', 7), Card.new('C', 10)]
		var player_three_hand_cards: Array[Card] = [Card.new('C', 6), Card.new('C', 14)]
		var player_four_hand_cards: Array[Card] = [Card.new('C', 5), Card.new('C', 11)]
		var dealer_hand_cards: Array[Card] = [Card.new('C', 2), Card.new('C', 3), Card.new('C', 4), Card.new('H', 8), Card.new('S', 13)]
		dealer_hands.add_mulitple_cards(dealer_hand_cards)
		dealer.players[0].hand.add_mulitple_cards(player_one_hand_cards)
		dealer.players[1].hand.add_mulitple_cards(player_two_hand_cards)
		dealer.players[2].hand.add_mulitple_cards(player_three_hand_cards)
		dealer.players[3].hand.add_mulitple_cards(player_four_hand_cards)

		dealer.players[0].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_one_hand_cards)
		dealer.players[1].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_two_hand_cards)
		dealer.players[2].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_three_hand_cards)
		dealer.players[3].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_four_hand_cards)

		var player_tied: Array[Player] = [dealer.players[0], dealer.players[1], dealer.players[2], dealer.players[3]]
		assert_eq(dealer.determine_tie(player_tied, Rank.RankEnum.HIGH_CARD), [dealer.players[2]])

	func test_high_card_case_six():
		var dealer_hands: Hand = Hand.new()
		var player_one_hand_cards: Array[Card] = [Card.new('C', 9), Card.new('C', 14)]
		var player_two_hand_cards: Array[Card] = [Card.new('C', 7), Card.new('C', 12)]
		var player_three_hand_cards: Array[Card] = [Card.new('C', 6), Card.new('C', 14)]
		var player_four_hand_cards: Array[Card] = [Card.new('C', 5), Card.new('C', 11)]
		var dealer_hand_cards: Array[Card] = [Card.new('C', 2), Card.new('D', 3), Card.new('C', 4), Card.new('H', 8), Card.new('S', 13)]
		dealer_hands.add_mulitple_cards(dealer_hand_cards)
		dealer.players[0].hand.add_mulitple_cards(player_one_hand_cards)
		dealer.players[1].hand.add_mulitple_cards(player_two_hand_cards)
		dealer.players[2].hand.add_mulitple_cards(player_three_hand_cards)
		dealer.players[3].hand.add_mulitple_cards(player_four_hand_cards)

		dealer.players[0].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_one_hand_cards)
		dealer.players[1].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_two_hand_cards)
		dealer.players[2].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_three_hand_cards)
		dealer.players[3].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_four_hand_cards)

		var player_tied: Array[Player] = [dealer.players[0], dealer.players[1], dealer.players[2], dealer.players[3]]
		assert_eq(dealer.determine_tie(player_tied, Rank.RankEnum.HIGH_CARD), [dealer.players[0]])

	func test_high_card_case_seven():
		var dealer_hands: Hand = Hand.new()
		var player_one_hand_cards: Array[Card] = [Card.new('S', 6), Card.new('C', 14)]
		var player_two_hand_cards: Array[Card] = [Card.new('C', 7), Card.new('C', 12)]
		var player_three_hand_cards: Array[Card] = [Card.new('C', 6), Card.new('C', 14)]
		var player_four_hand_cards: Array[Card] = [Card.new('C', 5), Card.new('C', 11)]
		var dealer_hand_cards: Array[Card] = [Card.new('C', 2), Card.new('D', 3), Card.new('C', 4), Card.new('H', 8), Card.new('S', 13)]
		dealer_hands.add_mulitple_cards(dealer_hand_cards)
		dealer.players[0].hand.add_mulitple_cards(player_one_hand_cards)
		dealer.players[1].hand.add_mulitple_cards(player_two_hand_cards)
		dealer.players[2].hand.add_mulitple_cards(player_three_hand_cards)
		dealer.players[3].hand.add_mulitple_cards(player_four_hand_cards)

		dealer.players[0].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_one_hand_cards)
		dealer.players[1].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_two_hand_cards)
		dealer.players[2].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_three_hand_cards)
		dealer.players[3].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_four_hand_cards)

		var player_tied: Array[Player] = [dealer.players[0], dealer.players[1], dealer.players[2], dealer.players[3]]
		assert_eq(dealer.determine_tie(player_tied, Rank.RankEnum.HIGH_CARD), [dealer.players[0], dealer.players[2]])


