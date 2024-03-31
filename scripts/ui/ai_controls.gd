extends CanvasLayer
var simulateGames = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$simulateButton.modulate = Color(2, 6, 2)
	$stopButton.modulate = Color(6, 2, 2)

func _on_arrow_up_pressed():
	# Add 100 to games text
	simulateGames = int($gamesText.text) + 100
	$gamesText.text = str(simulateGames)

func _on_arrow_down_pressed():
	# Subtract 100 from games text
	simulateGames = int($gamesText.text) - 100
	if simulateGames >= 0: # Can't simulate less than 0 games
		$gamesText.text = str(simulateGames)
