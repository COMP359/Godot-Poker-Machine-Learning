extends GutTest

class TestHand:
	extends GutTest

	var card_logic_script = preload('res://scripts/card_logic.gd')
	var hand = null

	func before_all():
		hand = card_logic_script.Hand.new(CardLogic.Player.PLAYER_1)

	func test_hand_evaluation():
		var cards = [CardLogic.Card.S1, CardLogic.Card.S2, CardLogic.Card.S3, CardLogic.Card.S4, CardLogic.Card.S5]
		gut.p(cards)
		hand.add_cards(cards)
		assert_eq(hand.evaluate(hand.cards), card_logic_script.Rank.ONE_PAIR)
