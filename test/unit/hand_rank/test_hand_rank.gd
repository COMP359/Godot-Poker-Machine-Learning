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
		assert_eq(rank.check_straight_flush(cards), true)

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
		assert_eq(rank.check_straight_flush(cards), true)

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
		assert_eq(rank.check_straight_flush(cards), true)

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

		assert_eq(rank.check_straight_flush(cards), true)

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

		assert_eq(rank.check_straight_flush(cards), false)

	func test_straight_flush_case_six():
		cards = [
			Card.new("S", 2),
			Card.new("C", 3),
			Card.new("D", 4),
			Card.new("H", 5),
			Card.new("S", 6)
		]
		assert_eq(rank.check_straight_flush(cards), false)

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
