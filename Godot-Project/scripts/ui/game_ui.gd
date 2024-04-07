
extends CanvasLayer

@onready var blue_player = $Blue_Player
@onready var red_player = $Red_Player
@onready var yellow_player = $Yellow_Player
@onready var green_player = $Green_Player
@onready var dealer = $"../Dealer"

signal add_card_signal(player: Player, card: Card, hidden_card: bool)
signal add_community_card_signal(card: Card)
signal add_hidden_community_card_signal
signal update_pot_balance
signal player_playing_pressed(playing_state: bool, player_playing: bool)
signal update_player_stats_signal(player: Player)
signal enable_player_controls_signal(state: bool)

var pot_amount = 0
var player_views: Array = []
var raise_amount = 0

func _init():
	connect_signals()

func _ready():
	# Lighter color for play against AI button
	$playAIbutton.modulate = Color(3, 3, 3)
	$Pot/potAmount.text = "[center]$0[/center]"
	#load_title_screen()
	self.player_views = [blue_player, red_player, yellow_player, green_player]	

func connect_signals():
	GlobalSignalHandler.connect("ui_player_stats_update", Callable(self, "update_player_stats"))
	GlobalSignalHandler.connect("ui_player_turn_update", Callable(self, "update_player_turn_label"))
	GlobalSignalHandler.connect("ui_player_controls", Callable(self, "toggle_player_controls"))
	GlobalSignalHandler.connect("ui_player_add_card", Callable(self, "add_card"))
	GlobalSignalHandler.connect("ui_player_add_community_card", Callable(self, "add_community_card"))
	GlobalSignalHandler.connect("ui_update_pot_amount", Callable(self, "update_pot_amount"))
	GlobalSignalHandler.connect("ui_add_default_community_cards", Callable(self, "add_default_community_cards"))
	enable_player_controls_signal.connect(Callable(self, "toggle_player_controls"))
	player_playing_pressed.connect(Callable(self, "start_game_dealer"))

func _on_start_button_pressed():
	$"../TitleScreen".hide()
	$"../Casino Board/Light".show()
	$".".show()
	$AI_UI.show()
	$"../SlotMachine".show()
	#update_pot_amount()

func start_game_dealer(playing_state: bool, player_playing: bool):
	if (playing_state):
		dealer.emit_signal("start_new_game", player_playing)
	else:
		dealer.emit_signal("clear_previous_game")
		clear_game_ui()

func clear_game_ui():
	for player in self.player_views:
		player.clear_ui()

	for card in $Pot/table.get_children():
		card.queue_free()
	
func load_title_screen():
	$"../Casino Board/Light".hide()
	$".".hide()
	$AI_UI.hide()
	$"../SlotMachine".hide()
	$"../TitleScreen/startButton".modulate = Color(3, 3, 3)

func add_card(player, card, hidden_card):
	var flipped_card_texture = ""
	if hidden_card:
		flipped_card_texture = load("res://assets/ui/cards_alt/card_back_pix.png")
	else:
		flipped_card_texture = load("res://assets/ui/cards_pixel/" + str(card.suit) + str(card.value) + ".png")
	var flipped_texture_rect = TextureRect.new()
	flipped_texture_rect.texture = flipped_card_texture
	if player.player_color == Player.PlayerColor.BLUE:
		blue_player.add_card(flipped_texture_rect)
	elif player.player_color == Player.PlayerColor.RED:
		red_player.add_card(flipped_texture_rect)
	elif player.player_color == Player.PlayerColor.YELLOW:
		yellow_player.add_card(flipped_texture_rect)
	elif player.player_color == Player.PlayerColor.GREEN:
		green_player.add_card(flipped_texture_rect)

func add_community_card(card):
	var flipped_card_texture = load("res://assets/ui/cards_pixel/" + str(card.suit) + str(card.value) + ".png")
	var flipped_texture_rect = TextureRect.new()
	flipped_texture_rect.texture = flipped_card_texture
	$Pot/table.add_child(flipped_texture_rect)

func add_default_community_cards() -> void:
	for i in range(5):
		var flipped_texture_rect = TextureRect.new()
		flipped_texture_rect.texture = load("res://assets/ui/cards_alt/card_back_pix.png")
		$Pot/table.add_child(flipped_texture_rect)

func update_pot_amount(pot_amount: int):
	$Pot/potAmount.text = "[center]"+format_money_text(pot_amount)+"[/center]"

func toggle_player_controls(state: bool):
	if (state):
		$"Player_UI".show()
	else:
		$"Player_UI".hide()

func update_player_stats(player: Player):
	if (player.player_color == Player.PlayerColor.BLUE):
		blue_player.update_player_stats(player)
	elif (player.player_color == Player.PlayerColor.RED):
		red_player.update_player_stats(player)
	elif (player.player_color == Player.PlayerColor.YELLOW):
		yellow_player.update_player_stats(player)
	elif (player.player_color == Player.PlayerColor.GREEN):
		green_player.update_player_stats(player)

func update_player_turn_label(player_color: Player.PlayerColor):
	print("Updating player turn label ", player_color)
	if (player_color == Player.PlayerColor.BLUE):
		blue_player.update_player_label_for_turn()
	elif (player_color == Player.PlayerColor.RED):
		red_player.update_player_label_for_turn()
	elif (player_color == Player.PlayerColor.YELLOW):
		yellow_player.update_player_label_for_turn()
	elif (player_color == Player.PlayerColor.GREEN):
		green_player.update_player_label_for_turn()

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


func _on_player_ui_player_called():
	GlobalSignalHandler.emit_signal("ui_player_action_callback", Player.Action.CALL, 0)

func _on_player_ui_player_folded():
	GlobalSignalHandler.emit_signal("ui_player_action_callback", Player.Action.FOLD, 0)

func _on_player_ui_player_raise():
	raise_amount = $Player_UI/playerButtons/raiseButton/raistAmt.text.to_int()
	GlobalSignalHandler.emit_signal("ui_player_action_callback", Player.Action.RAISE, raise_amount)

func _on_player_ui_player_check():
	GlobalSignalHandler.emit_signal("ui_player_action_callback", Player.Action.CHECK, 0)
