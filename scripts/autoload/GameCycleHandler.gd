extends Node

GlobalSignalHandler.connect("game_start", Callable(self, "on_game_start"))
GlobalSignalHandler.connect("game_end", Callable(self, "end_game"))

var current_game = null

# Creating a game instance when the game is started
func on_game_start(is_user_playing: bool):
  current_game = Game.new(is_user_playing)

func end_game():
  current_game.queue_free()
  current_game = null
