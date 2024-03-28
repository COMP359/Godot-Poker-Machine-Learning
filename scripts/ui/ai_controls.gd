extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	$simulateButton.modulate = Color(2, 6, 2)
	$stopButton.modulate = Color(6, 2, 2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_arrow_up_pressed():
	# Add 100 to games text
	$gamesText.text = str(int($gamesText.text) + 100)


func _on_arrow_down_pressed():
	# Subtract 100 from games text
	$gamesText.text = str(int($gamesText.text) - 100)

