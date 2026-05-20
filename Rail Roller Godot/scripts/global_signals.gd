extends Node

signal change_keybind(player, primary, text, contents)
signal erase_keybind(player, primary)
signal bump_keybind_action_index(player)

signal request_region(player)
signal return_region(region, player)

signal open_num_players_menu
signal close_num_players_menu

signal open_options_menu
signal change_language(locale_code)

signal start_pre_game
signal start_game
signal load_game
signal save_game
signal exit_game
