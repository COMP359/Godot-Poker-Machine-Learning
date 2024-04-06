extends AIController2D

@onready var winPerc = round((randf()*10)*pow(10,1))/pow(10,1)  # For testing
@onready var hand_rank = 0
@onready var roundNum = 0

var selectedAction
var raise_amt

func get_obs() -> Dictionary:
	"""Variables that are visible to the model"""
	var varsVisible := [
		winPerc,
		hand_rank,
		roundNum
	]
	return {"obs": varsVisible}

func get_reward() -> float:
	"""Rewards the model; do not touch"""
	return reward

func get_action_space() -> Dictionary:
	"""All possible actions the model can make"""
	return {
		"player_decision" : {
			"size" : 4, # FOLD, CHECK, CALL, RAISE
			"action_type" : "discrete"
		},
		"amount_raise" : {
			"size" : 10, # Raise value
			"action_type" : "discrete" # A percentage of total balance
		},
	}

func set_action(action) -> void:
	"""Code for when the model takes a specific action"""
	selectedAction = action["player_decision"]
	raise_amt = action["amount_raise"] + 1
	match int(selectedAction):
		0: # FOLD
			print("FOLD")
			reward -= 1
		1: # CHECK
			print("CHECK")
			reward -= 1
		2: # CALL
			print("CALL")
			reward -= 1
		3: # RAISE
			# Test code to find accuracy of AI
			# Found to be almost 100% accurate after 5000 iterations
			print("RAISE BY ", raise_amt*10, "%, WIN PERC ", round(winPerc*10), "%")
			if (raise_amt <= (winPerc + 1)
			and raise_amt >= (winPerc - 1)):
				reward += 20
				winPerc = round((randf()*10)*pow(10,1))/pow(10,1)
			else:
				reward -= 0.5
