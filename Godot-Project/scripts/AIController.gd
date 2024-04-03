extends AIController2D

@onready var winPerc = 0
@onready var hand_rank = 0
@onready var roundNum = 0

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
		#"example_actions_continous" : {
			#"size": 2,
			#"action_type": "continuous"
		#},
		#"example_actions_discrete" : {
			#"size": 2,
			#"action_type": "discrete"
		#},
		"player_decision" : {
			"size" : 3, # FOLD, CHECK, CALL, RAISE_LO, RAISE_MED, RAISE_HI, RAISE_ALLIN
			"action_type" : "discrete"
		}
	}

func set_action(action) -> void:
	"""Code for when the model takes a specific action"""
	print(action) # why is it only 0 or 1
	match int(action["player_decision"]):
		0: # FOLD
			print("FOLD")
		1: # CHECK
			print("CHECK")
		2: # CALL
			print("CALL")
		3: # RAISE LOW
			print("RAISE LOW")
		4: # RAISE MEDIUM
			print("RAISE MEDIUM")
		5: # RAISE HIGH
			print("RAISE HIGH")
		6: # RAISE ALL IN
			print("RAISE ALL IN")
	
