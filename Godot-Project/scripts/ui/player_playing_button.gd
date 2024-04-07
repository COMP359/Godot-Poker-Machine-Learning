extends Button
@onready var ui = $".."
@onready var spectate_ai_button = $"../spectateAIButton"
var playerIsPlaying = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$"../Player_UI".hide()
	$"../AI_UI".show()

func _on_ai_button_pressed():
	GlobalSignalHandler.emit_signal("game_start", true)
	playerIsPlaying = !playerIsPlaying
	# Change the button's text and color when it's pressed
	if playerIsPlaying:
		$".".text = "STOP PLAYING"
		$".".modulate = Color(5, 2, 2)

		# Make player controls visible, hide AI controls
		$"../AI_UI".hide()
		spectate_ai_button.visible = false
		$"../Player_UI".show()
	else:
		GlobalSignalHandler.emit_signal("game_end")
		$".".text = "PLAY AGAINST AI"
		$".".modulate = Color(3, 3, 3)

		# Make AI controls visible, hide player controls
		$"../Player_UI".hide()
		$"../AI_UI".show()
		spectate_ai_button.visible = true
