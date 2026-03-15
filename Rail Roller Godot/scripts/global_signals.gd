extends Node

signal change_keybind(player, primary, text, contents)
signal erase_keybind(player, primary)
signal bump_keybind_action_index(player)

signal request_region(player)
signal return_region(region, player)

signal open_num_players_menu
signal close_num_players_menu
signal start_game(num_players)

signal open_options_menu

signal save_game
signal game_loaded
