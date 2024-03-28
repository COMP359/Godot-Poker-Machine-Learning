extends GutTest

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
		assert_eq(rank.check_straight_flush(cards), {"state": true, "highcard":6})

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
		assert_eq(rank.check_straight_flush(cards), {"state": true, "highcard":7})

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
		assert_eq(rank.check_straight_flush(cards), {"state": true, "highcard":8})

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

		assert_eq(rank.check_straight_flush(cards), {"state": true, "highcard":5})

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

		assert_eq(rank.check_straight_flush(cards), {"state": false, "highcard":0})

	func test_straight_flush_case_six():
		cards = [
			Card.new("S", 2),
			Card.new("C", 3),
			Card.new("D", 4),
			Card.new("H", 5),
			Card.new("S", 6)
		]
		assert_eq(rank.check_straight_flush(cards), {"state": false, "highcard":0})

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

		assert_eq(rank.check_full_house(cards), {"state": true, "three_kind_highcard": 2, "pair_highcard": 3})

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

		assert_eq(rank.check_full_house(cards), {"state": false, "three_kind_highcard": 0, "pair_highcard": 0})
		
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

		assert_eq(rank.check_full_house(cards), {"state": false, "three_kind_highcard": 0, "pair_highcard": 0})
	
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

		assert_eq(rank.check_full_house(cards), {"state": true, "three_kind_highcard": 3, "pair_highcard": 2})
	
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

		assert_eq(rank.check_full_house(cards), {"state": true, "three_kind_highcard": 2, "pair_highcard": 9})

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
