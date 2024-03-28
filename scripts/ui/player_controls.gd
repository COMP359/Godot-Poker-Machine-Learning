extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	# Change colors of control buttons
	var val = 3
	$playerButtons/callButton.modulate = Color(val, val, val)
	$playerButtons/raiseButton.modulate = Color(val, val, val)
	$playerButtons/foldButton.modulate = Color(val, val, val)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_call_button_pressed():
	pass # Replace with function body.


func _on_raise_button_pressed():
	pass # Replace with function body.


func _on_fold_button_pressed():
	pass # Replace with function body.
