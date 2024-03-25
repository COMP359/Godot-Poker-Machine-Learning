extends Node

func _ready():
	var deck = Deck.new()

class Hand:
	var hand_ranks = ["ONE_PAIR", "TWO_PAIR", "THREE_OF_A_KIND", "STRAIGHT", "FLUSH", "FULL_HOUSE", "FOUR_OF_A_KIND", "STRAIGHT_FLUSH", "ROYAL_FLUSH"]
	var cards: Array[Card] = []
	var ranking: String = hand_ranks[0]
	var score: int = 0

	func add(card: Card):
		if cards.size() < 5:
			cards.append(card)
		else:
			print("Hand already has 5 cards.")
	
	func add_card(cards: Array[Card]):
		for card in cards:
			add(card)

	func evaluate(player_cards: Array[Card]) -> String:
		print("Evaluating hand for player: ", player_cards)
		# Andrew Issue Here (Just putting this for testing purposes)
		return hand_ranks[1]

	func is_valid_card(card: Card) -> bool:
		var valid_suits = ["S", "H", "D", "C"]
		var valid_values = []
		for i in range(1, 14):
			valid_values.append(str(i))
		return card.suit in valid_suits and card.value in valid_values
