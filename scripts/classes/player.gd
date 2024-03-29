class_name Player
extends Node

enum PlayerColor {
  BLUE, RED, YELLOW, GREEN
}

var player_color: PlayerColor
var is_human_player: bool
var hand: Hand
var balance: int
var bet: int
var has_folded: bool = false

func _init(player_selected: PlayerColor, is_human: bool, new_balance: int) -> void:
	"""Initialize a new player with the selected color, type, and balance."""
	self.player_color = player_selected
	self.is_human_player = is_human
	self.balance = new_balance
	self.hand = Hand.new()
	self.bet = 0
	self.has_folded = false

func reset_player_state() -> void:
	"""Reset the player's hand, bet, and fold status."""
	self.hand = Hand.new()
	self.bet = 0
	self.has_folded = false

func fold() -> void:
	"""Set the player's fold status to true."""
	self.has_folded = true

func bet_amount(amount: int) -> void:
	"""Set the player's bet amount and deduct it from their balance, if they have enough."""
	if amount <= self.balance:
		self.bet = amount
		self.balance -= amount
	else:
		print("Insufficient balance to make the bet.")

func get_hand() -> Hand:
	"""Return the player's hand."""
	return self.hand
