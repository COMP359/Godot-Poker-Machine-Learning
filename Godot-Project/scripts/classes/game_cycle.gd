class_name GameCycle
extends Node

enum GameStage { PRE_FLOP, FLOP, TURN, RIVER }

var dealer: Dealer
var players: Array[Player]

func betting_round():
	print("Betting Round check")
	if (check_players_folded()):
		determine_winner()
		return

	if (check_players_bet_equal()):
		# next_stage()
		pass

	call_next_player()

func call_next_player() -> void:
	var next_player: Player = null

	# Find the next player that has not folded
	while true:
		if player_index >= players.size() - 1:
			player_index = 0
		else:
			player_index += 1

		if !players[player_index].has_folded:
			next_player = players[player_index]
			break
	print("Timer")
	await get_tree().create_timer(2).timeout
	GlobalSignalHandler.emit_signal("ui_player_turn_update", next_player)
	if next_player.is_human_player:
		GlobalSignalHandler.emit_signal("ui_player_controls", true)
		print("Next player: ", next_player.player_color)
	else:
		print("Next bot player: ", next_player.player_color)
		await get_tree().create_timer(2).timeout
		next_player.ai_play_hand()
	return

func check_players_folded() -> bool:
	"""Returns true if only one person has not folded"""
	var folded_players = 0
	for player in players:
			if player.has_folded:
					folded_players += 1

	if folded_players >= 3:
		return true
	return false

func check_players_bet_equal() -> bool:
	"""Returns true if all players have bet the equal amount"""
	# TODO: UNIT TEST
	# TODO: Side pots: https://www.pokerlistings.com/rules-for-poker-all-in-situations-poker-side-pot-calculator
	var bet_amount = -1
	var player_all_in_counter = 0
	for player in players:
			if player.has_folded:
					continue
			if bet_amount == -1:
					bet_amount = player.bet
			elif player.current_action == Player.Action.ALL_IN:
					player_all_in_counter += 1
					player_showdown = true
			elif player.current_action != Player.Action.ALL_IN and player.bet != bet_amount:
					return false

	if player_all_in_counter == get_number_of_active_players():
		determine_winner()

	return true

	"""Returns true if all players have bet the equal amount"""
	# TODO: UNIT TEST
	# TODO: Side pots: https://www.pokerlistings.com/rules-for-poker-all-in-situations-poker-side-pot-calculator
	var bet_amount = -1
	var player_all_in_counter = 0
	for player in players:
			if player.has_folded:
					continue
			if bet_amount == -1:
					bet_amount = player.bet
			elif player.current_action == Player.Action.ALL_IN:
					player_all_in_counter += 1
					player_showdown = true
			elif player.current_action != Player.Action.ALL_IN and player.bet != bet_amount:
					return false

	if player_all_in_counter == get_number_of_active_players():
		determine_winner()

	return true
