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
  """Determines the rank of the hand based on the cards provided. Can be 5-7 cards."""
  
  #print cards passed from card_logic.gd out this is a randomly generated deck for testing 
  #for i in range(len(cards)):
        #print(cards[i].suit, cards[i].value)
        
  var test_cards: Array[Card] = [
    Card.new("S", 2),  
    Card.new("S", 3),  
    Card.new("S", 4),  
    Card.new("S", 5), 
    Card.new("S", 6),  
    Card.new("S", 7),  
    Card.new("C", 8)  
  ]

 #check for royal flush
  #print(check_royal_flush(test_cards))

#check for straight flush
  print(check_straight_flush(test_cards))
  # Andrews Logic Here
  self.rank = RankEnum.PAIR
  #print(str(rank))

func check_straight_flush(cards: Array[Card]) -> Dictionary:
    var suits = []
    var values = []
    var unique_suits = {}
    var highcard = 0
    var flush_suit = null  # Variable to store the suit of the flush

    # Extract suits and values from the cards
    for card in cards:
        var suit = card.suit
        var value = card.value
        # If an ace (14) exists, add a 1 to look for low straights as well
        if value == 14:
            values.append(1)
        else:
            values.append(value)
        suits.append(suit)
        if unique_suits.has(suit):
            unique_suits[suit] += 1
            if unique_suits[suit] >= 5:
                flush_suit = suit  # Update the flush suit if it has at least 5 cards
        else:
            unique_suits[suit] = 1
    
    if not flush_suit:
        return {"state": false, "highcard": highcard}

    # Filter values to include only cards of the flush suit
    var filtered_values = []
    for i in range(values.size()):
        if suits[i] == flush_suit:
            filtered_values.append(values[i])
    filtered_values.sort()
    filtered_values.reverse()
    
    var is_straight_flush = false
    # Check for a straight flush using a sliding window of 5 cards
    for i in range(len(filtered_values) - 4):
        is_straight_flush = true
        for j in range(i + 1, i + 5):
            if filtered_values[j] != filtered_values[j - 1] - 1:
                is_straight_flush = false
                break
        if is_straight_flush:
            highcard = filtered_values[i]  # Assign highcard to the highest card in the straight flush
            return {"state": true, "highcard": highcard}  # Found a straight flush

    return {"state": false, "highcard": highcard}  # No straight flush found



   
func check_royal_flush(cards: Array[Card]) -> bool:
    var suits = []
    var values = []
    
    # Extract suits and values from the cards
    for card in cards:
        var suit = card.suit
        var value = card.value
        
        suits.append(suit)
        values.append(value)
    
    # Check if all required cards are present in the hand
    var required_values = [10, 11, 12, 13, 14] # Values for 10, J, Q, K, A
    var royal_flush_suit = ""
    var found_cards = 0
    
    for required_value in required_values:
        var found = false
        for i in range(cards.size()):
            if values[i] == required_value and (royal_flush_suit == "" or suits[i] == royal_flush_suit):
                royal_flush_suit = suits[i]
                found = true
                found_cards += 1
                break
        
        if not found:
            return false

    # Check if all required cards are of the same suit
    return found_cards == required_values.size() and royal_flush_suit != ""
