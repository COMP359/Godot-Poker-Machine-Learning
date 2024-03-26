class_name Rank
extends Node

enum RankEnum {
  HIGH_CARD,
  PAIR,
  TWO_PAIR,
  THREE_OF_A_KIND,
  STRAIGHT,
  FLUSH,
  FULL_HOUSE,
  FOUR_OF_A_KIND,
  STRAIGHT_FLUSH,
  ROYAL_FLUSH
}

var rank: RankEnum
var value: int

func _init() -> void:
  self.rank = RankEnum.HIGH_CARD
  self.value = 0

func determine_rank(cards: Array[Card]) -> void:
  """Determines the rank of the hand based on the cards provided. Must be 5 cards."""
  assert(cards.size() != 5, "Invalid number of cards")

  # Andrews Logic Here
  self.rank = RankEnum.HIGH_CARD