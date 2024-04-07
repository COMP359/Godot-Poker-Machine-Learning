class_name Player
extends Node

enum PlayerColor {
  BLUE, RED, YELLOW, GREEN
}

enum Action {
	NONE, FOLD, CHECK, CALL, RAISE, ALL_IN
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

func human_play_hand(action: Player.Action, amount: int) -> void:
	print(action, amount)
	# TODO: Check if the player has enough balance to make the bet
	# TODO: If the player does not have enough balance, set the bet to the maximum possible amount (ALL_IN)
	if (action == Action.FOLD):
		self.has_folded = true
	elif (action == Action.CALL):
		self.bet += amount
		self.balance -= amount
	elif (action == Action.RAISE):
		self.bet += amount
		self.balance -= amount
	elif (action == Action.ALL_IN):
		self.bet += amount
		self.balance -= amount
	self.current_action = action
	GlobalSignalHandler.emit_signal("player_done", self)

func ai_play_hand() -> void:
	"""Have the AI play their hand. (This is a placeholder for the AI logic.)"""
	var action: Action = Action.CHECK
	var amount: int = 0
	var hand_value: int = self.hand.ranking.rank
	var random_factor: float = randf()
	if random_factor > 0.5:
		action = Action.FOLD
		self.fold()
	else:
		action = Action.CALL
		self.balance -= amount

	self.current_action = action
	GlobalSignalHandler.emit_signal("player_done", self)
