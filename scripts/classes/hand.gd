class_name Hand
extends Node

var cards: Array[Card] = []
var ranking: Rank

func _init():
  cards = []
  ranking = Rank.new()

func add_card(card: Card):
  """Adds a card to the hand."""
  cards.append(card)

func clear_hand():
  """Clears the hand of all cards."""
  cards.clear()

func rank_hand():
  """Determines the rank of the hand by passing the cards to the Rank class."""
  ranking.determine_hand_ranking(cards)

func get_first_card():
  """Returns the first card in the hand."""
  return cards[0]
