class_name Deck
extends Node

var deck_of_cards: Array[Card] = []

func _init():
	reset_deck()

func reset_deck():
	"""Create a new deck of cards and shuffle it."""
	deck_of_cards.clear()
	for suit in ["S", "H", "D", "C"]:
		for value in range(1, 14):
			deck_of_cards.append(Card.new(suit, value))
	shuffle_deck()

func shuffle_deck():
	"""Shuffle the deck of cards."""
	deck_of_cards.shuffle()

func draw_card() -> Card:
	"""Draw a card from the deck. This will remove the card from the deck."""
	return deck_of_cards.pop_front()

func get_amount_of_suited_cards(suit: String) -> int:
	"""Return the amount of cards of a certain suit in the deck."""
	var amount = 0
	for card in deck_of_cards:
		if card.suit == suit:
			amount += 1
	return amount

func get_deck_state() -> Array[Card]:
	"""Return the current state of the deck."""
	print("Deck state: ", deck_of_cards.size())
	print("Diamonds", get_amount_of_suited_cards("D"))
	print("Hearts", get_amount_of_suited_cards("H"))
	print("Clubs", get_amount_of_suited_cards("C"))
	print("Spades", get_amount_of_suited_cards("S"))
	return deck_of_cards
