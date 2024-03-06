extends Sprite2D

@export_range(4,10) var SlotFinishedTimeout: float = 4.0
@export var soundEffectOn: bool = true
@onready var handle = $Handle/AnimationPlayer
@onready var slot_finished = $SlotFinished
@onready var sound_effect = $SoundEffect

func _ready():
	slot_finished.wait_time = SlotFinishedTimeout
	slot_finished.start()
	_on_slot_finished_timeout()

func _on_slot_finished_timeout():
	handle.play("handle_swung")
	if (soundEffectOn):
		sound_effect.play()
	
