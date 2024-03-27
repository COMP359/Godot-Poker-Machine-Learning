class_name Rank
extends Node

enum RankEnum {
  HIGH_CARD,
  PAIR,
  TWO_PAIR,
  THREE_OF_A_KIND, # Finished
  STRAIGHT,
  FLUSH,
  FULL_HOUSE, # Finished
  FOUR_OF_A_KIND, # Finished
  STRAIGHT_FLUSH, # Finished
  ROYAL_FLUSH # Finished
}

var rank: RankEnum
var value: int

func _init() -> void:
  self.rank = RankEnum.HIGH_CARD
  self.value = 0

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

func check_three_kind(cards: Array[Card]) -> Dictionary:
    var unique_values = {}
    var highcard = 0
    var kind = 0

    for card in cards:
        var value = card.value
        if unique_values.has(value):
            unique_values[value] += 1
        else:
            unique_values[value] = 1

    for value in unique_values.keys():
        if unique_values[value] == 3:
            kind = 3
            highcard = value
            break

    if kind == 3:
        return {"state": true, "highcard": highcard}
    return {"state": false, "highcard": 0}

func check_four_kind(cards: Array[Card]) -> Dictionary:
    var unique_values = {}
    var highcard = 0
    var kind = 0

    for card in cards:
        var value = card.value
        if unique_values.has(value):
            unique_values[value] += 1
        else:
            unique_values[value] = 1

    for value in unique_values.keys():
        if unique_values[value] == 4:
            kind = 4
            highcard = value
            break

    if kind == 4:
        return {"state": true, "highcard": highcard}
    return {"state": false, "highcard": 0}

func check_full_house(cards: Array[Card]) -> Dictionary:
    var card_counts = {}
    for card in cards:
        if card.value in card_counts:
            card_counts[card.value] += 1
        else:
            card_counts[card.value] = 1

    var three_kind = 0
    var pair = 0
    for value in card_counts.keys():
        var count = card_counts[value]
        if count == 3:
            three_kind = value
        elif count == 2:
            pair = value

    var is_full_house = three_kind > 0 and pair > 0
    
    #set to 0 for convention on unit tests of highcard being 0 when false
    if not is_full_house:
        three_kind = 0
        pair = 0
        
    return {"state": is_full_house, "three_kind_highcard": three_kind, "pair_card_type": pair}

