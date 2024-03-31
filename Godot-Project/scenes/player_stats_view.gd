extends Control

@export_range(0, 3) var player_selected = 0
@onready var background_rectangle = $background_rectangle
@onready var robot_mugshot = $robot_mugshot
@onready var player_turn_status = $player_turn_status
@onready var player_turn_status_turn_text = $player_turn_status/TurnText
@onready var bet_amount = $bet_amount
@onready var bet_total_progress_bar = $bet_total_progress_bar
@onready var player_balance = $player_balance
@onready var player_hand = $player_hand
@onready var player_hidden_rectangle = $player_hidden_rectangle

func _ready():
	if (player_selected == 0):
		background_rectangle.color = Color(0.294, 0.435, 0.608)
		robot_mugshot.texture = load("res://assets/ui/blue_headshot.png")
	elif (player_selected == 1):
		background_rectangle.color = Color(0.596078, 0.278431, 0.278431, 1)
		robot_mugshot.texture = load("res://assets/ui/red_headshot.png")
	elif (player_selected == 2):
		background_rectangle.color = Color(0.560784, 0.494118, 0.207843, 1)
		robot_mugshot.texture = load("res://assets/ui/yellow_headshot.png")
	else:
		background_rectangle.color = Color(0.345098, 0.509804, 0.262745, 1)
		robot_mugshot.texture = load("res://assets/ui/green_headshot.png")
	
	set_balance_amount(100000)
	set_bet_amount(34000)

func set_bet_amount(bet_amount: int):
	self.bet_amount.text = "[right][b]%s[/b][/right]" % format_money_text(bet_amount)
	bet_total_progress_bar.value = (bet_amount / float(get_player_balance_amount())) * 100

func add_card(card_texture):
	player_hand.add_child(card_texture)

func clear_hand():
	for card in player_hand.get_children():
		card.queue_free()

func set_balance_amount(player_balance: int):
	self.player_balance.text = "%s" % format_money_text(player_balance)

func get_bet_amount() -> int:
	return bet_amount.text.to_int()

func get_player_balance_amount() -> int:
	return player_balance.text.to_int()

func update_player_stats(player: Player):
	update_player_label(player.current_action)
	set_bet_amount(player.bet)
	set_balance_amount(player.balance)

func update_player_label(action: Player.Action):
	player_turn_status.visible = true
	if (action == Player.Action.TURN):
		player_turn_status_turn_text.text = "TURN"
		player_turn_status.modulate = Color(0, 1, 0)
		player_hidden_rectangle.visible = false
	else:
		player_hidden_rectangle.visible = true

	if (action == Player.Action.FOLD):
		player_turn_status_turn_text.text = "FOLD"
		player_turn_status.modulate = Color(1, 0, 0)
	elif (action == Player.Action.CHECK):
		player_turn_status_turn_text.text = "CHECK"
		player_turn_status.modulate = Color(0, 1, 0)
	elif (action == Player.Action.CALL):
		player_turn_status_turn_text.text = "CALL"
		player_turn_status.modulate = Color(0, 1, 0)
	elif (action == Player.Action.RAISE):
		player_turn_status_turn_text.text = "RAISE"
		player_turn_status.modulate = Color(0, 1, 0)
	elif (action == Player.Action.ALL_IN):
		player_turn_status_turn_text.text = "ALL IN"
		player_turn_status.modulate = Color(0, 1, 0)
	elif (action == Player.Action.WIN):
		player_turn_status_turn_text.text = "WIN"
		player_turn_status.modulate = Color(0, 1, 0)
		player_hidden_rectangle.visible = false
	elif (action == Player.Action.LOSE):
		player_turn_status_turn_text.text = "LOSE"
		player_turn_status.modulate = Color(1, 0, 0)
	elif (action == Player.Action.TIE):
		player_turn_status_turn_text.text = "TIE"
		player_turn_status.modulate = Color(1, 1, 0)

func format_money_text(amount: int) -> String:
	var str_amount = str(amount)
	var formatted_amount = ""
	var counter = 0

	for i in range(str_amount.length() - 1, -1, -1):
		if counter > 0 and counter % 3 == 0:
			formatted_amount = "," + formatted_amount
		formatted_amount = str_amount[i] + formatted_amount
		counter += 1

	return "$" + formatted_amount
