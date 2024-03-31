extends CanvasLayer

@onready var blue_player = $Blue_Player
@onready var red_player = $Red_Player
@onready var yellow_player = $Yellow_Player
@onready var green_player = $Green_Player

signal add_card_signal
signal add_community_card_signal
signal add_hidden_community_card_signal

var pot_amount = 0
var player_views: Array = []

func _ready():
	# Lighter color for play against AI button
	$playAIbutton.modulate = Color(3, 3, 3)
	$Pot/potAmount.text = "[center]$0[/center]"
	load_title_screen()
	self.player_views = [blue_player, red_player, yellow_player, green_player]	

func _on_start_button_pressed():
	$"../TitleScreen".hide()
	$"../Casino Board/Light".show()
	$".".show()
	$AI_UI.show()
	$"../SlotMachine".show()
	update_pot_amount()

func load_title_screen():
	$"../Casino Board/Light".hide()
	$".".hide()
	$AI_UI.hide()
	$"../SlotMachine".hide()
	$"../TitleScreen/startButton".modulate = Color(3, 3, 3)

func add_card(player, card):
	var flipped_card_texture = load("res://assets/ui/cards_pixel/" + str(card.suit) + str(card.value) + ".png")
	var flipped_texture_rect = TextureRect.new()
	flipped_texture_rect.texture = flipped_card_texture
	if player.player_color == Player.PlayerColor.BLUE:
		$Cards/blueHand.add_child(flipped_texture_rect)
	elif player.player_color == Player.PlayerColor.RED:
		$Cards/redHand.add_child(flipped_texture_rect)
	elif player.player_color == Player.PlayerColor.YELLOW:
		$Cards/yellowHand.add_child(flipped_texture_rect)
	elif player.player_color == Player.PlayerColor.GREEN:
		$Cards/greenHand.add_child(flipped_texture_rect)

func add_community_card(card):
	var flipped_texture_rect = TextureRect.new()
	var flipped_card_texture = load("res://assets/ui/cards_pixel/" + str(card.suit) + str(card.value) + ".png")
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
