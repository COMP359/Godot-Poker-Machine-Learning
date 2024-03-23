extends GutTest

class TestHand:
	extends GutTest

	var card_logic_script = preload('res://scripts/card_logic.gd')
	var hand = null

	func before_all():
		hand = card_logic_script.Hand.new()

	func test_hand_evaluation():
		var cards = [Card.new("S", "1"), Card.new("S", "2"), Card.new("S", "3"), Card.new("S", "4"), Card.new("S", "5")]
		for card in cards:
			hand.add(card)
		assert_eq(hand.evaluate(hand.cards), "TWO_PAIR")
