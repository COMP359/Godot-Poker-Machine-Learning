enum Card {
  S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13,
  H1, H2, H3, H4, H5, H6, H7, H8, H9, H10, H11, H12, H13,
  D1, D2, D3, D4, D5, D6, D7, D8, D9, D10, D11, D12, D13,
  C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13
}

enum Rank {
  HIGH_CARD, PAIR, TWO_PAIR, THREE_OF_A_KIND, STRAIGHT, FLUSH, FULL_HOUSE, FOUR_OF_A_KIND, STRAIGHT_FLUSH, ROYAL_FLUSH
}

enum Player {
  PLAYER_1, PLAYER_2, PLAYER_3, PLAYER_4
}

class Deck:
  var cards: Array[Card] = []

  func _init():
    for card in Card:
      cards.append(card)

  func shuffle():
    pass

  func draw() -> Card:
    return cards.pop_front()

class Hand:
  var cards: Array[Card] = []
  var ranking: Rank = Rank.HIGH_CARD
  var score: int = 0
  var player: Player

  func add(card: Card):
    if cards.size() < 5:
      cards.append(card)
    else:
      print("Hand already has 5 cards.")

  func evaluate(player_cards: Array[Card]):
    print("Evaluating hand for player: ", player_cards)
    # Andrew Issue Here (Just putting this for testing purposes)
    return Rank.TWO_PAIR