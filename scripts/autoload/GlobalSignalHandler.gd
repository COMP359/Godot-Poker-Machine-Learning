extends Node

# UI Player Signals
signal ui_player_stats_update(player: Player)
signal ui_player_turn_update(player_color: Player.PlayerColor)
signal ui_player_controls(state: bool)
signal ui_player_add_card(player: Player, card: Card, hidden_card: bool)
signal ui_player_add_community_card(card: Card)
signal ui_player_add_hidden_community_card
signal ui_update_pot_amount(amount: int)

# Dealer Signals
signal player_done(player: Player)

# Player Signals
signal player_turn_start()
