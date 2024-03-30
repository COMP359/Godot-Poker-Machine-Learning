extends GutTest

class TestRoyalFlushHandRanking:
	extends GutTest

	var rank = null
	var cards: Array[Card] = []

	func before_all():
		rank = Rank.new()

	func test_royal_flush_case_one():
		cards = [
			Card.new("S", 10),
			Card.new("S", 11),
			Card.new("S", 12),
			Card.new("S", 13),
			Card.new("S", 14),
			Card.new("C", 2),
			Card.new("C", 3),
		]
		assert_eq(rank.check_royal_flush(cards), true)

	func test_royal_flush_case_two():
		cards = [
			Card.new("S", 9),
			Card.new("S", 10),
			Card.new("S", 11),
			Card.new("S", 12),
			Card.new("S", 13),
			Card.new("S", 8),
			Card.new("C", 3),
		]
		assert_eq(rank.check_royal_flush(cards), false)

	func test_royal_flush_case_three():
		cards = [
			Card.new("C", 10),
			Card.new("S", 11),
			Card.new("H", 12),
			Card.new("D", 13),
			Card.new("S", 14)
		]
		assert_eq(rank.check_royal_flush(cards), false)

class TestStraightFlushHandRanking:
	extends GutTest

	var rank = null
	var cards: Array[Card] = []

	func before_all():
		rank = Rank.new()

	func test_straight_flush_case_one():
		cards = [
			Card.new("S", 2),
			Card.new("S", 3),
			Card.new("S", 4),
			Card.new("S", 5),
			Card.new("S", 6),
			Card.new("C", 7),
			Card.new("C", 8),
		]
		assert_eq(rank.check_straight_flush(cards), {"state": true, "cards": [6, 5, 4, 3, 2]})

	func test_straight_flush_case_two():
		cards = [
			Card.new("S", 2),
			Card.new("S", 3),
			Card.new("S", 4),
			Card.new("S", 5),
			Card.new("S", 6),
			Card.new("S", 7),
			Card.new("C", 8),
		]
		assert_eq(rank.check_straight_flush(cards), {"state": true, "cards": [7, 6, 5, 4, 3]})

	func test_straight_flush_case_three():
		cards = [
			Card.new("S", 2),
			Card.new("S", 3),
			Card.new("S", 4),
			Card.new("S", 5),
			Card.new("S", 6),
			Card.new("S", 7),
			Card.new("S", 8),
		]
		assert_eq(rank.check_straight_flush(cards), {"state": true, "cards": [8, 7, 6, 5, 4]})

	func test_straight_flush_case_four():
		cards = [
			Card.new("S", 2),
			Card.new("S", 3),
			Card.new("S", 4),
			Card.new("S", 5),
			Card.new("S", 14), # Ace (Turns into low and high)
			Card.new("C", 7),
			Card.new("C", 8),
		]

		assert_eq(rank.check_straight_flush(cards), {"state": true, "cards": [5, 4, 3, 2, 1]})

	func test_straight_flush_case_five():
		cards = [
			Card.new("S", 2),
			Card.new("S", 3),
			Card.new("S", 4),
			Card.new("S", 5),
			Card.new("C", 14), # Ace (Turns into low and high)
			Card.new("C", 7),
			Card.new("C", 8),
		]

		assert_eq(rank.check_straight_flush(cards), {"state": false, "cards": []})

	func test_straight_flush_case_six():
		cards = [
			Card.new("S", 2),
			Card.new("C", 3),
			Card.new("D", 4),
			Card.new("H", 5),
			Card.new("S", 6)
		]
		assert_eq(rank.check_straight_flush(cards), {"state": false, "cards": []})
	
	func test_straight_flush_case_seven():
		cards = [
			Card.new('D', 7),
			Card.new('D', 8),
			Card.new('D', 4),
			Card.new('D', 5),
			Card.new('D', 6),
			Card.new('D', 7),
			Card.new('D', 9)
		]

		assert_eq(rank.check_straight_flush(cards), {"state": true, "cards": [9,8,7,6,5]})

class TestFourKindHandRanking:
	extends GutTest

	var rank = null
	var cards: Array[Card] = []

	func before_all():
		rank = Rank.new()

	func test_four_kind_case_one():
		cards = [
			Card.new("S", 2),
			Card.new("S", 2),
			Card.new("C", 2),
			Card.new("S", 2),
			Card.new("S", 4),
			Card.new("C", 7),
			Card.new("C", 8),
		]
		assert_eq(rank.check_four_kind(cards), {"state": true, "highcard":2})
		
	func test_four_kind_case_two():
		cards = [
			Card.new("S", 12),
			Card.new("S", 2),
			Card.new("C", 2),
			Card.new("S", 2),
			Card.new("S", 4),
			Card.new("C", 7),
			Card.new("C", 8),
		]
		assert_eq(rank.check_four_kind(cards), {"state": false, "highcard":0})
		
	func test_four_kind_case_three():
		cards = [
			Card.new("S", 14),
			Card.new("C", 14),
			Card.new("S", 4),
			Card.new("S", 14),
			Card.new("C", 7),
			Card.new("C", 8),
			Card.new("H", 14),
		]
		assert_eq(rank.check_four_kind(cards), {"state": true, "highcard":14})

class TestFullHouseHandRanking:
	extends GutTest

	var rank = null
	var cards: Array[Card] = []

	func before_all():
		rank = Rank.new()

	func test_full_house_case_one():
		cards = [
			Card.new("S", 2),
			Card.new("H", 2),
			Card.new("C", 2),
			Card.new("S", 3),
			Card.new("S", 3),
			Card.new("C", 7),
			Card.new("C", 8),
		]

		assert_eq(rank.check_full_house(cards), {"state": true, "full_house_three_kind_highcard": 2, "full_house_pair_highcard": 3})

	func test_full_house_case_two():
		cards = [
			Card.new("S", 2),
			Card.new("H", 2),
			Card.new("C", 2),
			Card.new("S", 3),
			Card.new("S", 12),
			Card.new("C", 7),
			Card.new("C", 8),
		]

		assert_eq(rank.check_full_house(cards), {"state": false, "full_house_three_kind_highcard": 0, "full_house_pair_highcard": 0})
		
	func test_full_house_case_three():
		cards = [
			Card.new("S", 2),
			Card.new("H", 2),
			Card.new("C", 12),
			Card.new("S", 3),
			Card.new("S", 3),
			Card.new("C", 7),
			Card.new("C", 8),
		]

		assert_eq(rank.check_full_house(cards), {"state": false, "full_house_three_kind_highcard": 0, "full_house_pair_highcard": 0})
	
	func test_full_house_case_four():
		cards = [
			Card.new("S", 2),
			Card.new("H", 2),
			Card.new("C", 2),
			Card.new("S", 3),
			Card.new("S", 3),
			Card.new("C", 3),
			Card.new("C", 8),
		]

		assert_eq(rank.check_full_house(cards), {"state": true, "full_house_three_kind_highcard": 3, "full_house_pair_highcard": 2})
	
	func test_full_house_case_five():
		cards = [
			Card.new("S", 2),
			Card.new("H", 2),
			Card.new("C", 2),
			Card.new("S", 8),
			Card.new("S", 9),
			Card.new("C", 8),
			Card.new("C", 9),
		]

		assert_eq(rank.check_full_house(cards), {"state": true, "full_house_three_kind_highcard": 2, "full_house_pair_highcard": 9})

class TestFlushHandRanking:
	extends GutTest

	var rank = null
	var cards: Array[Card] = []

	func before_all():
		rank = Rank.new()

	func test_flush_case_one():
		cards = [
			Card.new("S", 3),
			Card.new("S", 4),
			Card.new("S", 10),
			Card.new("S", 12),
			Card.new("H", 3),
			Card.new("S", 7),
			Card.new("C", 8),
		]

		assert_eq(rank.check_flush(cards), {"state": true, "flush_cards": [3, 4, 7, 10, 12]})
		
	func test_flush_case_two():
		cards = [
			Card.new("C", 3),
			Card.new("S", 4),
			Card.new("S", 10),
			Card.new("S", 12),
			Card.new("H", 3),
			Card.new("S", 7),
			Card.new("C", 8),
		]

		assert_eq(rank.check_flush(cards), {"state": false})
		
	func test_flush_case_three():
		cards = [
			Card.new("S", 3),
			Card.new("S", 4),
			Card.new("S", 10),
			Card.new("S", 12),
			Card.new("H", 3),
			Card.new("S", 7),
			Card.new("S", 14),
		]

		assert_eq(rank.check_flush(cards), {"state": true, "flush_cards": [4, 7, 10, 12, 14]})
		
	func test_flush_case_four():
		cards = [
			Card.new("S", 3),
			Card.new("S", 4),
			Card.new("S", 10),
			Card.new("S", 12),
			Card.new("S", 11),
			Card.new("S", 7),
			Card.new("S", 14),
		]

		assert_eq(rank.check_flush(cards), {"state": true, "flush_cards": [7, 10, 11, 12, 14]})

class TestStraightHandRanking:
	extends GutTest

	var rank = null
	var cards: Array[Card] = []

	func before_all():
		rank = Rank.new()

	func test_straight_case_one():
		cards = [
			Card.new("C", 2),
			Card.new("H", 3),
			Card.new("C", 14),
			Card.new("S", 4),
			Card.new("H", 5),
			Card.new("S", 6),
			Card.new("C", 14),
		]

		assert_eq(rank.check_straight(cards), {"state": true,"straight_cards": [6, 5, 4, 3, 2]})
		
	func test_straight_case_two():
		cards = [
			Card.new("C", 2),
			Card.new("H", 3),
			Card.new("C", 14),
			Card.new("S", 14),
			Card.new("H", 5),
			Card.new("S", 6),
			Card.new("C", 14),
		]

		assert_eq(rank.check_straight(cards), {"state": false})
		
	func test_straight_case_three():
		cards = [
			Card.new("C", 8),
			Card.new("H", 13),
			Card.new("C", 14),
			Card.new("S", 9),
			Card.new("H", 12),
			Card.new("S", 11),
			Card.new("C", 10),
		]

		assert_eq(rank.check_straight(cards), {"state": true,"straight_cards": [14, 13, 12, 11, 10]})
	
	func test_straight_case_four():
		cards = [
			Card.new("C", 2),
			Card.new("H", 3),
			Card.new("C", 14),
			Card.new("S", 4),
			Card.new("H", 5),
			Card.new("S", 7),
			Card.new("C", 11),
		]

		assert_eq(rank.check_straight(cards), {"state": true,"straight_cards": [5, 4, 3, 2, 1]})
	
	func test_straight_case_five():
		cards = [
			Card.new('D', 7),
			Card.new('C', 8),
			Card.new('D', 4),
			Card.new('S', 5),
			Card.new('C', 6),
			Card.new('C', 7),
			Card.new('D', 9)
		]

		assert_eq(rank.check_straight(cards), {"state": true, "straight_cards": [9,8,7,6,5]})

class TestThreeKindHandRanking:
	extends GutTest

	var rank = null
	var cards: Array[Card] = []

	func before_all():
		rank = Rank.new()

	func test_three_kind_case_one():
		cards = [
			Card.new("S", 2),
			Card.new("S", 2),
			Card.new("D", 2),
			Card.new("S", 3),
			Card.new("S", 4),
			Card.new("C", 7),
			Card.new("C", 8),
		]
		assert_eq(rank.check_three_kind(cards), {"state": true, "highcard":2})
		
	func test_three_kind_case_two():
		cards = [
			Card.new("S", 2),
			Card.new("S", 2),
			Card.new("D", 7),
			Card.new("S", 3),
			Card.new("S", 4),
			Card.new("C", 7),
			Card.new("C", 8),
		]
		assert_eq(rank.check_three_kind(cards), {"state": false, "highcard":0})
		
	func test_three_kind_case_three():
		cards = [
			Card.new("S", 12),
			Card.new("C", 14),
			Card.new("S", 14),
			Card.new("S", 12),
			Card.new("D", 14),
			Card.new("C", 12),
		]
		assert_eq(rank.check_three_kind(cards), {"state": true, "highcard":14})

class TestTwoPairHandRanking:
	extends GutTest

	var rank = null
	var cards: Array[Card] = []

	func before_all():
		rank = Rank.new()

	func test_two_pair_case_one():
		cards = [
			Card.new("S", 2),
			Card.new("S", 9),
			Card.new("D", 3),
			Card.new("S", 2),
			Card.new("S", 4),
			Card.new("C", 7),
			Card.new("C", 3),
		]
		assert_eq(rank.check_two_pair(cards), {"state": true, "two_pair_high_pair": 3, "two_pair_low_pair": 2})

	func test_two_pair_case_two():
		cards = [
			Card.new("S", 2),
			Card.new("S", 3),
			Card.new("D", 4),
			Card.new("S", 2),
			Card.new("S", 3),
			Card.new("C", 4),
			Card.new("C", 8),
		]
		assert_eq(rank.check_two_pair(cards), {"state": true, "two_pair_high_pair": 4, "two_pair_low_pair": 3})

	func test_two_pair_case_three():
		cards = [
			Card.new("S", 2),
			Card.new("S", 7),
			Card.new("D", 2),
			Card.new("S", 3),
			Card.new("S", 4),
			Card.new("C", 5),
			Card.new("C", 9),
		]
		assert_eq(rank.check_two_pair(cards), {"state": false, "two_pair_high_pair": 0, "two_pair_low_pair": 0})

class TestPairHandRanking:
	extends GutTest

	var rank = null
	var cards: Array[Card] = []

	func before_all():
		rank = Rank.new()
	
	func test_pair_case_one():
		cards = [
			Card.new("S", 2),
			Card.new("S", 9),
			Card.new("D", 3),
			Card.new("S", 2),
			Card.new("S", 4),
			Card.new("C", 7),
			Card.new("C", 8),
		]
		assert_eq(rank.check_pair(cards), {"state": true, "highcard": 2})
	
	func test_pair_case_two():
		cards = [
			Card.new("S", 2),
			Card.new("S", 9),
			Card.new("D", 3),
			Card.new("S", 2),
			Card.new("S", 4),
			Card.new("C", 7),
			Card.new("C", 9),
		]
		assert_eq(rank.check_pair(cards), {"state": true, "highcard": 9})
	
	func test_pair_case_three():
		cards = [
			Card.new("S", 2),
			Card.new("S", 9),
			Card.new("D", 3),
			Card.new("S", 5),
			Card.new("S", 4),
			Card.new("C", 7),
			Card.new("C", 8),
		]
		assert_eq(rank.check_pair(cards), {"state": false, "highcard": 0})

class TestDetermineHandRanking:
	extends GutTest

	var rank = null
	var cards: Array[Card] = []

	func before_each():
		rank = Rank.new()

	func test_determine_hand_ranking_case_one():
		cards = [
			Card.new("S", 10),
			Card.new("S", 3),
			Card.new("S", 11),
			Card.new("S", 12),
			Card.new("S", 13),
			Card.new("C", 7),
			Card.new("S", 14),
		]
		assert_eq(rank.determine_hand_ranking(cards), rank.RankEnum.ROYAL_FLUSH)

	func test_determine_hand_ranking_case_two():
		cards = [
			Card.new("S", 2),
			Card.new("S", 3),
			Card.new("S", 4),
			Card.new("S", 5),
			Card.new("S", 6),
			Card.new("C", 7),
			Card.new("S", 8),
		]
		assert_eq(rank.determine_hand_ranking(cards), rank.RankEnum.STRAIGHT_FLUSH)
		assert_eq(rank.straight_flush_cards, [6, 5, 4, 3, 2])

	func test_determine_hand_ranking_case_three():
		cards = [
			Card.new("S", 2),
			Card.new("S", 2),
			Card.new("C", 2),
			Card.new("S", 7),
			Card.new("S", 2),
			Card.new("C", 7),
			Card.new("C", 8),
		]
		assert_eq(rank.determine_hand_ranking(cards), rank.RankEnum.FOUR_OF_A_KIND)
		assert_eq(rank.four_of_a_kind_highcard, 2)

	func test_determine_hand_ranking_case_four():
		cards = [
			Card.new("S", 2),
			Card.new("S", 2),
			Card.new("C", 2),
			Card.new("S", 7),
			Card.new("S", 7),
			Card.new("C", 7),
			Card.new("C", 8),
		]
		assert_eq(rank.determine_hand_ranking(cards), rank.RankEnum.FULL_HOUSE)
		assert_eq(rank.full_house_three_kind_highcard, 7)
		assert_eq(rank.full_house_pair_highcard, 2)
	
	func test_determine_hand_ranking_case_five():
		cards = [
			Card.new("S", 2),
			Card.new("S", 3),
			Card.new("S", 4),
			Card.new("S", 5),
			Card.new("S", 7),
			Card.new("C", 7),
			Card.new("S", 8),
		]
		assert_eq(rank.determine_hand_ranking(cards), rank.RankEnum.FLUSH)
		assert_eq(rank.flush_cards, [3, 4, 5, 7, 8])
	
	func test_determine_hand_ranking_case_six():
		cards = [
			Card.new("S", 2),
			Card.new("S", 3),
			Card.new("C", 4),
			Card.new("S", 5),
			Card.new("D", 6),
			Card.new("C", 7),
			Card.new("S", 8),
		]
		assert_eq(rank.determine_hand_ranking(cards), rank.RankEnum.STRAIGHT)
		assert_eq(rank.straight_cards, [8, 7, 6, 5, 4])
	
	func test_determine_hand_ranking_case_seven():
		cards = [
			Card.new("S", 2),
			Card.new("S", 2),
			Card.new("C", 2),
			Card.new("S", 3),
			Card.new("S", 4),
			Card.new("C", 7),
			Card.new("C", 8),
		]
		assert_eq(rank.determine_hand_ranking(cards), rank.RankEnum.THREE_OF_A_KIND)
		assert_eq(rank.three_of_a_kind_highcard, 2)

	func test_determine_hand_ranking_case_eight():
		cards = [
			Card.new("S", 2),
			Card.new("S", 2),
			Card.new("C", 3),
			Card.new("S", 3),
			Card.new("S", 4),
			Card.new("C", 7),
			Card.new("C", 8),
		]
		assert_eq(rank.determine_hand_ranking(cards), rank.RankEnum.TWO_PAIR)
		assert_eq(rank.two_pair_high_pair, 3)
		assert_eq(rank.two_pair_low_pair, 2)
	
	func test_determine_hand_ranking_case_nine():
		cards = [
			Card.new("S", 2),
			Card.new("S", 2),
			Card.new("C", 3),
			Card.new("S", 4),
			Card.new("S", 5),
			Card.new("C", 7),
			Card.new("C", 8),
		]
		assert_eq(rank.determine_hand_ranking(cards), rank.RankEnum.PAIR)
		assert_eq(rank.pair_high_card, 2)

	func test_determine_hand_ranking_case_ten():
		cards = [
			Card.new("S", 2),
			Card.new("S", 10),
			Card.new("C", 4),
			Card.new("S", 11),
			Card.new("S", 6),
			Card.new("C", 12),
			Card.new("C", 8),
		]
		assert_eq(rank.determine_hand_ranking(cards), rank.RankEnum.HIGH_CARD)
		assert_eq(rank.high_card_in_rank, 12)
