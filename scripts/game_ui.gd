extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	### Ui elements ###
	# Lighter color for play against AI button
	$playAIbutton.modulate = Color(3, 3, 3)

	# Init text for balance to $100,000
	$BlueBar/blueBal.text = "100K"
	$RedBar/redBal.text = "100K"
	$YellowBar/yellowBal.text = "100K"
	$GreenBar/greenBal.text = "100K"

	$BlueBar/blueBet.text = "[right][b]$94,000[/b][/right]"
	$RedBar/redBet.text = "[right][b]$12,867[/b][/right]"
	$YellowBar/yellowBet.text = "[right][b]$26,300[/b][/right]"
	$GreenBar/greenBet.text = "[right][b]$76,520[/b][/right]"

	# Init text for win percentage to 0
	var winPercText = "0%"
	$BlueBar/blueWinPerc.text = winPercText
	$RedBar/redWinPerc.text = winPercText
	$YellowBar/yellowWinPerc.text = winPercText
	$GreenBar/greenWinPerc.text = winPercText

	# Pot is $0
	$Pot/potAmount.text = "[center]$0[/center]"

	# Generate 2 cards for each color
	for i in range(2):
		var flipped_card_texture = load("res://assets/ui/cards_alt/card_back_pix.png")
		# var flipped_card_texture = load("res://assets/ui/cards_pixel/2_spades.png")
		var flipped_texture_rect = TextureRect.new()
		flipped_texture_rect.texture = flipped_card_texture

		# Add to hboxcontainer (visual representation of cards)
		$Cards/blueHand.add_child(flipped_texture_rect)
		flipped_texture_rect = TextureRect.new()
		flipped_texture_rect.texture = flipped_card_texture
		$Cards/redHand.add_child(flipped_texture_rect)
		flipped_texture_rect = TextureRect.new()
		flipped_texture_rect.texture = flipped_card_texture
		$Cards/yellowHand.add_child(flipped_texture_rect)
		flipped_texture_rect = TextureRect.new()
		flipped_texture_rect.texture = flipped_card_texture
		$Cards/greenHand.add_child(flipped_texture_rect)

	# Add 5 cards to the table
	for i in range(5):
		# var flipped_card_texture = load("res://assets/ui/cards_alt/card_back_pix.png")
		var flipped_card_texture = load("res://assets/ui/cards_pixel/2_spades.png")
		var flipped_texture_rect = TextureRect.new()
		flipped_texture_rect.texture = flipped_card_texture

		# Add to hboxcontainer (visual representation of cards)
		$Cards/table.add_child(flipped_texture_rect)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Update progress bars with bet $ / total $ for each color
	# Progress bar is out of 80
	$BlueBar/blueProgress.value = round(float(float($BlueBar/blueBet.text.to_int()) /
	($BlueBar/blueBal.text.to_float()*10))) * 0.8

	$RedBar/redProgress.value = round(float(float($RedBar/redBet.text.to_int()) /
	($RedBar/redBal.text.to_float()*10))) * 0.8

	$YellowBar/yellowProgress.value = round(float(float($YellowBar/yellowBet.text.to_int()) /
	($YellowBar/yellowBal.text.to_float()*10))) * 0.8

	$GreenBar/greenProgress.value = round(float(float($GreenBar/greenBet.text.to_int()) /
	($GreenBar/greenBal.text.to_float()*10))) * 0.8

	# Update pot amount by adding all bets
	$Pot/potAmount.text = "[center]$"+str($BlueBar/blueBet.text.to_int() +
		$RedBar/redBet.text.to_int() + $YellowBar/yellowBet.text.to_int() +
		$GreenBar/greenBet.text.to_int())+"[/center]"
