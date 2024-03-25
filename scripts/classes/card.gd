class_name Card
extends Node

var suit: String
var value: int

func _init(newSuit: String, newValue: int):
    assert(valid_suit(newSuit), "Invalid suit")
    assert(newValue >= 1 and newValue <= 13, "Invalid value")
    self.suit = newSuit
    self.value = newValue

func valid_suit(input_suit: String) -> bool:
    """Check if the input suit is valid"""
    return input_suit in ["H", "D", "C", "S"]