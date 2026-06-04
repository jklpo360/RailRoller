extends Node

@warning_ignore("unused_signal")
signal change_keybind(player, primary, text, contents)
@warning_ignore("unused_signal")
signal evict_duplicate_keybind_action_index(player, action_index)
@warning_ignore("unused_signal")
signal bump_keybind_action_index(player)

@warning_ignore("unused_signal")
signal request_region(player)
@warning_ignore("unused_signal")
signal return_region(region, player)

@warning_ignore("unused_signal")
signal open_num_players_menu
@warning_ignore("unused_signal")
signal close_num_players_menu
@warning_ignore("unused_signal")
signal close_options_menu

@warning_ignore("unused_signal")
signal open_options_menu
@warning_ignore("unused_signal")
signal change_language(locale_code)
@warning_ignore("unused_signal")
signal swap_rule_toggled
@warning_ignore("unused_signal")
signal show_regions_toggled

@warning_ignore("unused_signal")
signal start_pre_game
@warning_ignore("unused_signal")
signal start_game
@warning_ignore("unused_signal")
signal load_game
@warning_ignore("unused_signal")
signal save_game
@warning_ignore("unused_signal")
signal exit_game
