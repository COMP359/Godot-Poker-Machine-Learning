extends Node
var current_game = null

func _ready():
	GlobalSignalHandler.connect("game_start", Callable(self, "on_game_start"))
	GlobalSignalHandler.connect("game_end", Callable(self, "end_game"))

# Creating a game instance when the game is started
func on_game_start(is_user_playing: bool):
	var test = Hand.new()
	current_game = GameCycle.new(is_user_playing)

# Removing the game instance when the game is ended
func end_game():
	# TODO: Add a clearing signal for the UI so it can clear the existing game
	current_game.queue_free()
	current_game = null
