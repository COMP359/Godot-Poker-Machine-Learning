class_name Player
extends Node

enum PlayerColor {
  BLUE, RED, YELLOW, GREEN
}

enum Action {
	FOLD, CHECK, CALL, RAISE
}

var player_color: PlayerColor
var is_human_player: bool
var hand: Hand
var balance: int
var bet: int
var has_folded: bool = false
var dealer_signal: Signal

func _init(player_selected: PlayerColor, is_human: bool, new_balance: int, dealer_signal: Signal) -> void:
	"""Initialize a new player with the selected color, type, and balance."""
	self.player_color = player_selected
	self.is_human_player = is_human
	self.balance = new_balance
	self.hand = Hand.new()
	self.bet = 0
	self.has_folded = false
	self.dealer_signal = dealer_signal

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

func human_play_hand() -> void:
	pass

func ai_play_hand() -> void:
	"""Have the AI play their hand. (This is a placeholder for the AI logic.)"""
	var action: Action = Action.CHECK
	var amount: int = 0
	var hand_value: int = self.hand.ranking.rank
	var random_factor: float = randf()

	if hand_value >= 8:
			if random_factor < 0.7:
					action = Action.RAISE
					amount = int(hand_value * 10 * random_factor)
			else:
					action = Action.CALL

	elif hand_value >= 5:
			if random_factor < 0.5:
					action = Action.RAISE
					amount = int(hand_value * 10 * random_factor)
			else:
					action = Action.CALL

	elif hand_value >= 2:
			if random_factor < 0.3:
					action = Action.FOLD
			else:
					action = Action.CHECK
	else:
			action = Action.FOLD

	dealer_signal.emit(self.player_color, action, amount)
