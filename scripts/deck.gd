class_name Deck
extends Node

var cards: Array[Card] = []

func _init():
	reset_deck()

func reset_deck():
	cards.clear()
	for suit in ["S", "H", "D", "C"]:
		for value in range(1, 14):
			cards.append(Card.new(suit, value))
	shuffle_deck()

func shuffle_deck():
	cards.shuffle()