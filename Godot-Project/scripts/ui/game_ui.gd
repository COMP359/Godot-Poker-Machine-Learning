extends CanvasLayer

@onready var blue_player = $Blue_Player
@onready var red_player = $Red_Player
@onready var yellow_player = $Yellow_Player
@onready var green_player = $Green_Player
@onready var dealer = $"../Dealer"

signal add_card_signal
signal add_community_card_signal
signal add_hidden_community_card_signal
signal update_pot_balance
signal player_playing_pressed
signal update_player_stats_signal
signal enable_player_controls_signal

var pot_amount = 0
var player_views: Array = []
var raise_amount = 0

func _ready():
	# Lighter color for play against AI button
	$playAIbutton.modulate = Color(3, 3, 3)
	$Pot/potAmount.text = "[center]$0[/center]"
	#load_title_screen()
	self.player_views = [blue_player, red_player, yellow_player, green_player]	

func _on_start_button_pressed():
	$"../TitleScreen".hide()
	$"../Casino Board/Light".show()
	$".".show()
	$AI_UI.show()
	$"../SlotMachine".show()
	update_pot_amount()

func start_game_dealer(playing_state: bool, player_playing: bool):
	if (playing_state):
		dealer.emit_signal("start_new_game", player_playing)
	else:
		dealer.emit_signal("clear_previous_game")
		clear_game_ui()

func clear_game_ui():
	for player in self.player_views:
		player.clear_hand()
	
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

func add_hidden_community_card():
	var flipped_texture_rect = TextureRect.new()
	flipped_texture_rect.texture = load("res://assets/ui/cards_alt/card_back_pix.png")
	$Pot/table.add_child(flipped_texture_rect)

func update_pot_amount():
	pot_amount = 0
	for player in self.player_views:
		pot_amount += (player.get_bet_amount())
	$Pot/potAmount.text = "[center]"+format_money_text(pot_amount)+"[/center]"

func enable_player_controls():
	$"Player_UI".show()

func update_player_stats(player: Player):
	if (player.player_color == Player.PlayerColor.BLUE):
		blue_player.update_player_stats(player)
	elif (player.player_color == Player.PlayerColor.RED):
		red_player.update_player_stats(player)
	elif (player.player_color == Player.PlayerColor.YELLOW):
		yellow_player.update_player_stats(player)
	elif (player.player_color == Player.PlayerColor.GREEN):
		green_player.update_player_stats(player)

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
	dealer.player_ui_moved(Player.Action.CALL, 0)

func _on_player_ui_player_folded():
	dealer.player_ui_moved(Player.Action.FOLD, 0)

func _on_player_ui_player_raise():
	raise_amount = $Player_UI/playerButtons/raiseButton/raistAmt.text.to_int()
	dealer.player_ui_moved(Player.Action.RAISE, $Player_UI/playerButtons/raiseButton/raistAmt.text.to_int())
