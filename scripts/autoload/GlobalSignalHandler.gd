extends Node

# UI Player Signals
signal ui_player_stats_update(player: Player)
signal ui_player_turn_update(player: Player)
signal ui_player_controls(state: bool)

# Dealer Signals
signal player_done(player: Player)

# Player Signals
signal player_turn_start()
