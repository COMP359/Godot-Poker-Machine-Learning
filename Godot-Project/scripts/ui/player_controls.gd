extends CanvasLayer

var betAmount
signal player_called
signal player_folded
signal player_raise
signal player_checked

func _ready():
	# Change colors of control buttons
	var val = 3
	$playerButtons/callButton.modulate = Color(val, val, val)
	$playerButtons/raiseButton.modulate = Color(val, val, val)
	$playerButtons/foldButton.modulate = Color(val, val, val)
	# Change fold text color
	$playerButtons/foldButton.set("theme_override_colors/font_color", "#b82727")
	connect_signals()

func connect_signals():
	$playerButtons/callButton.connect("pressed", Callable(self, "_on_call_button_pressed"))
	$playerButtons/raiseButton.connect("pressed", Callable(self, "_on_raise_button_pressed"))
	$playerButtons/foldButton.connect("pressed", Callable(self, "_on_fold_button_pressed"))
	$playerButtons/checkButton.connect("pressed", Callable(self, "_on_check_button_pressed"))
	$arrowUp.connect("pressed", Callable(self, "_on_arrow_up_pressed"))
	$arrowDown.connect("pressed", Callable(self, "_on_arrow_down_pressed"))
	GlobalSignalHandler.connect("ui_validate_player_control", Callable(self, "validate_controls"))

func validate_controls():
	print("Validating player controls")
	if (GameCycleHandler.current_game.player_showdown):
		print("Player showdown")
		$playerButtons/callButton.disabled = true
		$playerButtons/raiseButton.disabled = false
		$playerButtons/foldButton.disabled = false
		$playerButtons/checkButton.disabled = true

func _on_call_button_pressed():
	emit_signal("player_called")

func _on_raise_button_pressed():
	emit_signal("player_raise")

func _on_fold_button_pressed():
	emit_signal("player_folded")

func _on_check_button_pressed():
	emit_signal("player_checked")

func _on_arrow_up_pressed():
	betAmount = int($playerButtons/raiseButton/raistAmt.text) + 1000
	$playerButtons/raiseButton/raistAmt.text = "+ $" + str(betAmount)

func _on_arrow_down_pressed():
	betAmount = int($playerButtons/raiseButton/raistAmt.text) - 1000
	if betAmount > 0: # Can't bet below $0
		$playerButtons/raiseButton/raistAmt.text = "+ $" + str(betAmount)
