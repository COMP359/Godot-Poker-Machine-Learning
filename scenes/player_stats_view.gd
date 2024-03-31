extends Control

@export_range(0, 3) var player_selected = 0
@onready var background_rectangle = $background_rectangle
@onready var robot_mugshot = $robot_mugshot
@onready var player_turn_status = $player_turn_status

func _ready():
	if (player_selected == 0):
		background_rectangle.color = Color(0.294, 0.435, 0.608)
		robot_mugshot.texture = load("res://assets/ui/blue_headshot.png")
	elif (player_selected == 1):
		background_rectangle.color = Color(0.596078, 0.278431, 0.278431, 1)
		robot_mugshot.texture = load("res://assets/ui/red_headshot.png")
	elif (player_selected == 2):
		background_rectangle.color = Color(0.560784, 0.494118, 0.207843, 1)
		robot_mugshot.texture = load("res://assets/ui/yellow_headshot.png")
	else:
		background_rectangle.color = Color(0.345098, 0.509804, 0.262745, 1)
		robot_mugshot.texture = load("res://assets/ui/green_headshot.png")

func toggle_player_turn():
	player_turn_status.visible = !player_turn_status.visible
