class_name Player
extends Node

enum PlayerColor {
  BLUE, RED, YELLOW, GREEN
}

enum Action {
	NONE, FOLD, CHECK, CALL, RAISE, ALL_IN, WIN
}

var player_color: PlayerColor
var is_human_player: bool
var hand: Hand
var balance: int
var bet: int
var has_folded: bool = false
var current_action: Action

func _init(player_selected: PlayerColor, is_human: bool, new_balance: int) -> void:
	"""Initialize a new player with the selected color, type, and balance."""
	self.player_color = player_selected
	self.is_human_player = is_human
	self.balance = new_balance
	self.hand = Hand.new()
	self.bet = 0
	self.has_folded = false
	self.current_action = Action.NONE

func reset_player_state() -> void:
	"""Reset the player's hand, bet, and fold status."""
	self.is_human_player = false
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

func ai_play_hand() -> void:
	"""Have the AI play their hand. (This is a placeholder for the AI logic.)"""
	# --------------------------------
	# This is a placeholder for the AI logic. We will randomly decide to fold or call.
	# Machine learning work will be implemented here in the future...

	var action: Action = Action.CHECK
	var amount: int = 12500
	var random_factor: float = randf()

	if random_factor > 0.1:
			action = Action.ALL_IN
	elif random_factor > 0.7:
			action = Action.RAISE
			amount = min(self.balance, 20000)
	elif random_factor > 0.3:
			action = Action.CALL
	else:
			action = Action.FOLD
			self.fold()

	self.current_action = action
  # End of placeholder AI logic.
	# --------------------------------

	GlobalSignalHandler.emit_signal("ui_player_action_callback", action, amount)
