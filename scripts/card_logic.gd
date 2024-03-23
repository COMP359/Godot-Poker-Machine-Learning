# Define arrays for each suit
var spades = ["S1", "S2", "S3", "S4", "S5", "S6", "S7", "S8", "S9", "S10", "S11", "S12", "S13"]
var hearts = ["H1", "H2", "H3", "H4", "H5", "H6", "H7", "H8", "H9", "H10", "H11", "H12", "H13"]
var diamonds = ["D1", "D2", "D3", "D4", "D5", "D6", "D7", "D8", "D9", "D10", "D11", "D12", "D13"]
var clubs = ["C1", "C2", "C3", "C4", "C5", "C6", "C7", "C8", "C9", "C10", "C11", "C12", "C13"]

# Combine all suits into one array
var all_cards = spades + hearts + diamonds + clubs

var hand_ranks = ["ONE_PAIR", "TWO_PAIR", "THREE_OF_A_KIND", "STRAIGHT", "FLUSH", "FULL_HOUSE", "FOUR_OF_A_KIND", "STRAIGHT_FLUSH", "ROYAL_FLUSH"]

enum Player {
	PLAYER_1, PLAYER_2, PLAYER_3, PLAYER_4
}

class Deck:
	var cards: Array[String] = []

	func _init():
		cards = all_cards.duplicate()

	func shuffle():
		cards.shuffle()

	func draw() -> String:
		return cards.pop_front()


class Hand:
	var cards: Array[String] = []
	var ranking: String = hand_ranks[0]
	var score: int = 0
	var player: Player

	func _init(player: Player):
		self.player = player

	func add(card: String):
		if cards.size() < 5:
			if is_valid_card(card):
				cards.append(card)
			else:
				print("Invalid card.")
		else:
			print("Hand already has 5 cards.")
	
	func add_card(cards: Array[String]):
		for card in cards:
			add(card)

	func evaluate(player_cards: Array[String]) -> String:
		print("Evaluating hand for player: ", player_cards)
		# Andrew Issue Here (Just putting this for testing purposes)
		return hand_ranks[1]

	func is_valid_card(card: String) -> bool:
		return card in all_cards
