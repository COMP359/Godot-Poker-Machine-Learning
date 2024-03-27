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
    Card.new("S", 13),  
    Card.new("C", 13),  
    Card.new("C", 12)  
  ]

 #check for royal flush
  #print(check_royal_flush(test_cards))

#check for straight flush
  print(check_straight_flush(test_cards))
  # Andrews Logic Here
  self.rank = RankEnum.PAIR
  #print(str(rank))

func check_straight_flush(cards: Array[Card]) -> bool:
    var suits = []
    var values = []
    var unique_suits = {}
    
    # Extract suits and values from the cards
    for card in cards:
        var suit = card.suit
        var value = card.value
        #if an ace (14) exists add a 1 to look for low straights as well
        if(value == 14):
            values.append(1)
        suits.append(suit)
        values.append(value)
        if unique_suits.has(suit):
            unique_suits[suit] += 1
        else:
            unique_suits[suit] = 1
    print(unique_suits)
    
    # Check if all cards are of the same suit
    var is_flush = false
    for count in unique_suits.values():
        if(count >= 5):
            is_flush = true
            print("is flush: ",is_flush)
    
    if not is_flush:
        return false  # Not a flush

    # Sort the values in ascending order
    values.sort()

    # Check for a straight flush using a sliding window of 5 cards
    for i in range(values.size() - 4):
        var is_straight_flush = true
        for j in range(i + 1, i + 5):
            if values[j] != values[j - 1] + 1:
                is_straight_flush = false
                break
        if is_straight_flush:
            return true  # Found a straight flush

    return false  # No straight flush found 
   
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
