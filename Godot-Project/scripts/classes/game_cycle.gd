class_name GameCycle
extends Node

enum GameStage { PRE_FLOP, FLOP, TURN, RIVER }

var utility = Utility.new()
var dealer: Dealer
var players: Array[Player] = []

var is_user_playing_game: bool = false
var default_player_money: int = 100000
var player_showdown: bool = false
var game_stage: GameStage = GameStage.PRE_FLOP
var player_index: int = 0

# Initialize the game cycle
func _init(is_user_playing_game: bool):
	print("GameCycle init")
	self.is_user_playing_game = is_user_playing_game
	create_players()
	dealer = Dealer.new()
	dealer.deal_player_cards(players)
	GlobalSignalHandler.emit_signal("ui_add_default_community_cards")
	GlobalSignalHandler.connect("ui_player_action_callback", Callable(self, "player_action_callback"))
	GlobalSignalHandler.connect("player_move_complete", Callable(self, "betting_round"))

# Create the players for the game cycle and add them to the players array
func create_players():
	for color in Player.PlayerColor.values():
			var is_user = color == Player.PlayerColor.BLUE && is_user_playing_game
			players.append(Player.new(color, is_user, default_player_money))

# Checking the game stage and performing the appropriate action like allowing the player to bet or dealing the cards
func betting_round():
	print("Betting Round check")

	if (check_for_first_iteration()):
		call_next_player()
		return

	if (check_players_folded()):
		utility.determine_winner(players)
		return

	if (check_players_bet_equal() and no_players_have_check_action()):
		next_stage()
		return

	call_next_player()
	return

func call_next_player() -> void:
	var next_player: Player = null

	while true:
		if player_index >= players.size() - 1:
			player_index = 0
		else:
			player_index += 1

		if !players[player_index].has_folded:
			next_player = players[player_index]
			break

	print("Timer")
	# await get_tree().create_timer(2).timeout
	GlobalSignalHandler.emit_signal("ui_player_turn_update", next_player)
	if next_player.is_human_player:
		GlobalSignalHandler.emit_signal("ui_player_controls", true)
		print("Next player: ", next_player.player_color)
	else:
		print("Next bot player: ", next_player.player_color)
		# await get_tree().create_timer(2).timeout
		next_player.ai_play_hand()
	return

func check_for_first_iteration() -> bool:
	"""Returns true if it is the first iteration of the game"""
	for player in players:
			if player.current_action == Player.Action.NONE:
					return true
	return false

func no_players_have_check_action() -> bool:
	"""Returns true if no players have checked"""
	for player in players:
			if player.current_action == Player.Action.CHECK:
					return false
	return true

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
		utility.determine_winner(players)

	return true

func get_number_of_active_players():
	return 2

func next_stage():
	print("Next Stage", game_stage)
	if game_stage == GameStage.PRE_FLOP:
		game_stage = GameStage.FLOP
		dealer.deal_flop()
	elif game_stage == GameStage.FLOP:
		game_stage = GameStage.TURN
		dealer.deal_turn()
	elif game_stage == GameStage.TURN:
		game_stage = GameStage.RIVER
		dealer.deal_river()
	elif game_stage == GameStage.RIVER:
		utility.determine_winner(players)
		return
	betting_round()

func player_action_callback(action: Player.Action, amount: int):
	print("Player action callback", action, amount)
	var player = players[player_index]
	player.current_action = action
	if action == Player.Action.FOLD:
		player.has_folded = true
	elif action == Player.Action.ALL_IN:
		player_showdown = true
		player.bet = player.balance
		player.balance = 0
	elif action == Player.Action.CALL:
		player.bet += amount
		player.balance -= amount
	elif action == Player.Action.RAISE:
		player.bet += amount
	if player.is_human_player:
		GlobalSignalHandler.emit_signal("ui_player_controls", false)
	dealer.update_pot(amount)
	GlobalSignalHandler.emit_signal("ui_player_stats_update", player)
	GlobalSignalHandler.emit_signal("player_move_complete")
	return
