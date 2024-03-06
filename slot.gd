extends Sprite2D

@onready var animation = $Animation
@onready var timer = $Timer
@onready var light = $Light/Texture
@export_range(0.5,2.5) var timer_duration: float = 1.0

var orange_slot = Color8(166, 52, 22, 255)
var blue_slot = Color8(0, 95, 182, 255)
var purple = Color8(147, 5, 179, 255)
var white = Color8(255, 254, 254, 62)
var red = Color8(178, 14, 39, 255)

var frame_counter = 0
var slot_finished = false

func _ready():
	reset_slots()
	light.color = white
	timer.wait_time = timer_duration
	timer.start()

func _process(delta):
	if (!slot_finished):
		frame_counter = (frame_counter + 1) % 31
		update_slot_animations()

func _on_timer_timeout():
	slot_finished = !slot_finished
	update_slot_visibility()
	randomize_slot_frames()
	if (!slot_finished):
		light.color = white
	else:
		update_light_colors()

func reset_slots():
	self.frame = 0

func update_slot_animations():
	animation.frame = frame_counter

func update_slot_visibility():
	animation.visible = !slot_finished

func randomize_slot_frames():
	if (slot_finished):
		self.frame = randi() % 6

func update_light_colors():
	light.color = get_color_for_frame(self.frame)

func get_color_for_frame(frame):
	if frame == 0 or frame == 1:
		return orange_slot
	elif frame == 2:
		return blue_slot
	elif frame == 3:
		return purple
	elif frame == 4:
		return red
	else:
		return white
