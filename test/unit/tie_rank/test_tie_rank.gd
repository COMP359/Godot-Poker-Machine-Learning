extends GutTest

class TestStraightFlushTie:
    extends GutTest

    var dealer = null

    func before_all():
        dealer = Dealer.new()
        # Hands get automatically created on the dealer class
        # This is just to clear the hands so we can test the hands we want
        dealer.community_cards.clear_hand()
        dealer.players[0].hand.clear_hand()
        dealer.players[1].hand.clear_hand()
        dealer.players[2].hand.clear_hand()
        dealer.players[3].hand.clear_hand()

    func test_straight_flush_case_one():
        var dealer_hands: Hand = Hand.new()
        var player_one_hand_cards: Array[Card] = [Card.new('H', 2), Card.new('H', 3)]
        var player_two_hand_cards: Array[Card] = [Card.new('H', 7), Card.new('H', 8)]
        var dealer_hand_cards: Array[Card] = [Card.new('H', 4), Card.new('H', 5), Card.new('H', 6), Card.new('C', 7), Card.new('D', 9)]
        dealer_hands.add_mulitple_cards(dealer_hand_cards)
        dealer.players[0].hand.add_mulitple_cards(player_one_hand_cards)
        dealer.players[1].hand.add_mulitple_cards(player_two_hand_cards) # Winner

        dealer.players[0].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_one_hand_cards)
        dealer.players[1].hand.ranking.determine_hand_ranking(dealer_hand_cards + player_two_hand_cards)

        var player_tied: Array[Player] = [dealer.players[0], dealer.players[1]]
        assert_eq(dealer.determine_tie(player_tied, Rank.RankEnum.STRAIGHT_FLUSH), [dealer.players[1]])


  # func test_straight_flush_case_two():
  #   dealer.community_cards = [Card.new('H', 4), Card.new('H', 5), Card.new('H', 6), Card.new('H', 7), Card.new('H', 9)]
  #   dealer.players[0].hand = [Card.new('H', 2), Card.new('H', 3)]
