extends CanvasLayer

var potAmount = 0
signal add_card_signal
signal add_community_card_signal
signal add_hidden_community_card_signal

# Called when the node enters the scene tree for the first time.
func _ready():
	### Ui elements ###
	# Lighter color for play against AI button
	$playAIbutton.modulate = Color(3, 3, 3)

	# Pot is $0
	$Pot/potAmount.text = "[center]$0[/center]"

	# Load title screen
	$"../Casino Board/Light".hide()
	$".".hide()
	$AI_UI.hide()
	$"../SlotMachine".hide()
	$"../TitleScreen/startButton".modulate = Color(3, 3, 3)

## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	## Update progress bars with bet $ / total $ for each color
	## Progress bar is out of 80
	#$BlueBar/blueProgress.value = round(float(float($BlueBar/blueBet.text.to_int()) /
	#($BlueBar/blueBal.text.to_float()*10))) * 0.8
#
	#$RedBar/redProgress.value = round(float(float($RedBar/redBet.text.to_int()) /
	#($RedBar/redBal.text.to_float()*10))) * 0.8
#
	#$YellowBar/yellowProgress.value = round(float(float($YellowBar/yellowBet.text.to_int()) /
	#($YellowBar/yellowBal.text.to_float()*10))) * 0.8
#
	#$GreenBar/greenProgress.value = round(float(float($GreenBar/greenBet.text.to_int()) /
	#($GreenBar/greenBal.text.to_float()*10))) * 0.8
#
	## Update pot amount by adding all bets
	#potAmount = ($BlueBar/blueBet.text.to_int()
		#+ $RedBar/redBet.text.to_int()
		#+ $YellowBar/yellowBet.text.to_int()
		#+ $GreenBar/greenBet.text.to_int())
#
	## Add comma to pot amount
	#if potAmount > 999:
		#potAmount = str(potAmount)
		#potAmount = potAmount.insert(len(potAmount)-3, ",")
#
	#$Pot/potAmount.text = "[center]$"+potAmount+"[/center]"

func _on_start_button_pressed():
	$"../TitleScreen".hide()
	$"../Casino Board/Light".show()
	$".".show()
	$AI_UI.show()
	$"../SlotMachine".show()

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
