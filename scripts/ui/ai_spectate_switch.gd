extends Button
@onready var ui = $".."
@onready var play_ai_button = $"../playAIbutton"
var spectating = false

func _ready():
	$".".modulate = Color(3, 3, 3)

func _on_pressed():
	ui.emit_signal("player_playing_pressed", !spectating, false)
	spectating = !spectating
	
	if(spectating):
		play_ai_button.visible = false
		$"../AI_UI".hide()
		$".".text = "STOP SPECTATING"
		$".".modulate = Color(5, 2, 2)
	else:
		play_ai_button.visible = true
		$"../AI_UI".show()
		$".".modulate = Color(3, 3, 3)
		$".".text = "SPECTATE AI"
