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

# Variables to store additional information about the hand for tie-breaking
# (Not all variables are used for all hand rankings)
var high_card_in_rank: int
var four_of_a_kind_highcard: int
var straight_flush_cards: Array[int]
var full_house_three_kind_highcard: int
var full_house_pair_highcard: int
var flush_cards: Array[int]
var straight_cards: Array[int]
var three_of_a_kind_highcard: int
var two_pair_high_pair: int
var two_pair_low_pair: int
var pair_high_card: int

func _init() -> void:
  self.rank = RankEnum.HIGH_CARD
  self.high_card_in_rank = 0
  self.four_of_a_kind_highcard = 0
  self.full_house_three_kind_highcard = 0
  self.full_house_pair_highcard = 0
  self.flush_cards = []
  self.straight_cards = []
  self.three_of_a_kind_highcard = 0
  self.two_pair_high_pair = 0
  self.two_pair_low_pair = 0
  self.pair_high_card = 0

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
        return {"state": false, "cards": []}

    # Filter values to include only cards of the flush suit
    var filtered_values = []
    for i in range(values.size()):
        if suits[i] == flush_suit:
            filtered_values.append(values[i])
    filtered_values.sort()
    filtered_values.reverse()

    var is_straight_flush = false
    var flush_cards: Array[int] = []  # Initialize array to store cards in the straight flush
    # Check for a straight flush using a sliding window of 5 cards
    for i in range(len(filtered_values) - 4):
        flush_cards = []  # Reset the array of cards in the straight flush
        is_straight_flush = true
        for j in range(i + 1, i + 5):
            if filtered_values[j] != filtered_values[j - 1] - 1:
                is_straight_flush = false
                break
            flush_cards.append(filtered_values[j - 1])
        if is_straight_flush:
            highcard = filtered_values[i]  # Assign highcard to the highest card in the straight flush
            var lowest_card = flush_cards[flush_cards.size() - 1]
            flush_cards.append(lowest_card - 1)  # Append one more card that is one less than the lowest card
            return {"state": true, "cards": flush_cards}  # Found a straight flush

    return {"state": false, "cards": []}  # No straight flush found

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
    var second_three_kind = 0
    var pair = 0
    for value in card_counts.keys():
        var count = card_counts[value]
        if count == 3:
            if value > three_kind:
                second_three_kind = three_kind
                three_kind = value
            elif value > second_three_kind:
                second_three_kind = value
        elif count == 2 and value > pair:
            pair = value

    var is_full_house = three_kind > 0 and (pair > 0 or second_three_kind > 0)
    
    if not is_full_house:
        three_kind = 0
        pair = 0
    elif pair == 0:
        pair = second_three_kind

    return {"state": is_full_house, "full_house_three_kind_highcard": three_kind, "full_house_pair_highcard": pair}

func check_flush(cards: Array[Card]) -> Dictionary:
    var suit_counts = {}
    var flush_cards: Array[int] = []

    # Count the number of cards for each suit
    for card in cards:
        var suit = card.suit
        var value = card.value
        if suit in suit_counts:
            suit_counts[suit] += 1
        else:
            suit_counts[suit] = 1

    # Check if any suit has five or more cards
    for suit in suit_counts.keys():
        if suit_counts[suit] >= 5:
            for card in cards:
                if card.suit == suit:
                    flush_cards.append(card.value)
            flush_cards.sort()  # Sort cards 
            
            #flush cards needed for possible tie, cut to highest 5 to make the "best" flush
            while flush_cards.size() > 5:
                flush_cards.pop_front()

            return {"state": true, "flush_cards": flush_cards}

    return {"state": false}  # No flush found

func check_straight(cards: Array[Card]) -> Dictionary:
    # Make array of values
    var values = []
    for card in cards:
        values.append(card.value)

    #ordered reverse to get the highest number straight
    values.sort()
    values.reverse()

    if values.has(14):
        values.append(1)  # Add a 1 to check for low straights as well

    # Check for a straight by iterating through sorted values
    var is_straight = false
    var straight_cards: Array[int] = []  # Initialize array to store cards in the straight
    for i in range(len(values) - 4):  # Use len(values) - 4 to ensure enough cards for a straight
        is_straight = true
        for j in range(i + 1, i + 5):  # Check consecutive values in the descending straight
            if values[j] != values[j - 1] - 1:
                is_straight = false
                break
            else:
                #store the highest straight
                straight_cards.append(values[j-1])
                straight_cards.append(values[j])
                #remove duplicates
                straight_cards = array_unique(straight_cards)

        if is_straight:
            print(straight_cards)
            return {"state": true, "straight_cards": straight_cards}

    return {"state": false}  # No straight found

func check_three_kind(cards: Array[Card]) -> Dictionary:
    var card_counts = {}
    var highcard = 0

    for card in cards:
        var value = card.value
        if card_counts.has(value):
            card_counts[value] += 1
        else:
            card_counts[value] = 1

    for value in card_counts.keys():
        if card_counts[value] == 3 and value > highcard:
            highcard = value

    if highcard > 0:
        return {"state": true, "highcard": highcard}
    else:
        return {"state": false, "highcard": 0}

func check_two_pair(cards: Array[Card]) -> Dictionary:
    var card_counts = {}
    var high_pair = 0
    var low_pair = 0

    for card in cards:
        var value = card.value
        if card_counts.has(value):
            card_counts[value] += 1
        else:
            card_counts[value] = 1

    for value in card_counts.keys():
        if card_counts[value] == 2:
            if value > high_pair:
                low_pair = high_pair
                high_pair = value
            elif value > low_pair:
                low_pair = value

    var is_two_pair = high_pair > 0 and low_pair > 0

    if not is_two_pair:
        high_pair = 0
        low_pair = 0

    return {"state": is_two_pair, "two_pair_high_pair": high_pair, "two_pair_low_pair": low_pair}

func check_pair(cards: Array[Card]) -> Dictionary:
    var card_counts = {}
    var highcard = 0

    for card in cards:
        var value = card.value
        if card_counts.has(value):
            card_counts[value] += 1
        else:
            card_counts[value] = 1

    for value in card_counts.keys():
        if card_counts[value] == 2 and value > highcard:
            highcard = value

    if highcard > 0:
        return {"state": true, "highcard": highcard}
    else:
        return {"state": false, "highcard": 0}

func determine_hand_ranking(player_and_community_cards: Array[Card]) -> RankEnum:
    var cards = player_and_community_cards

    if check_royal_flush(cards):
        rank = RankEnum.ROYAL_FLUSH
        return rank

    var straight_flush = check_straight_flush(cards)
    if straight_flush["state"]:
        rank = RankEnum.STRAIGHT_FLUSH
        straight_flush_cards = straight_flush["cards"]
        return rank

    var four_kind = check_four_kind(cards)
    if four_kind["state"]:
        rank = RankEnum.FOUR_OF_A_KIND
        four_of_a_kind_highcard = four_kind["highcard"]
        return rank

    var full_house = check_full_house(cards)
    if full_house["state"]:
        rank = RankEnum.FULL_HOUSE
        full_house_three_kind_highcard = full_house["full_house_three_kind_highcard"]
        full_house_pair_highcard = full_house["full_house_pair_highcard"]
        return rank

    var flush = check_flush(cards)
    if flush["state"]:
        rank = RankEnum.FLUSH
        flush_cards = flush["flush_cards"]
        return rank

    var straight = check_straight(cards)
    if straight["state"]:
        rank = RankEnum.STRAIGHT
        straight_cards = straight["straight_cards"]
        return rank

    var three_kind = check_three_kind(cards)
    if three_kind["state"]:
        rank = RankEnum.THREE_OF_A_KIND
        three_of_a_kind_highcard = three_kind["highcard"]
        return rank

    var two_pair = check_two_pair(cards)
    if two_pair["state"]:
        rank = RankEnum.TWO_PAIR
        two_pair_high_pair = two_pair["two_pair_high_pair"]
        two_pair_low_pair = two_pair["two_pair_low_pair"]
        return rank

    var pair = check_pair(cards)
    if pair["state"]:
        rank = RankEnum.PAIR
        pair_high_card = pair["highcard"]
        return rank

    # Find the highest card in the hand if no other hand is found
    for card in cards:
        if card.value > high_card_in_rank:
            high_card_in_rank = card.value

    return RankEnum.HIGH_CARD

#removes duplicates from array
func array_unique(array: Array[int]) -> Array[int]:
    var unique: Array[int] = []

    for item in array:
        if not unique.has(item):
            unique.append(item)

    return unique
