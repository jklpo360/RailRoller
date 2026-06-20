extends Node2D

var in_menu = false
var in_game = false

func _ready():
	GlobalSignals.change_language.connect(_on_change_language, CONNECT_PERSIST)
	GlobalSignals.exit_game.connect(_on_exit_game, CONNECT_PERSIST)
	GlobalSignals.load_game.connect(_on_load_game, CONNECT_PERSIST)

func _on_player_number_menu_response(response) -> void:
	if response == 0:
		in_menu = false
		%MainUnfocusMask.hide()
		%NumPlayersCanvas.hide()
		%MainButtonMasker.hide()
	else:
		GlobalSignals.start_pre_game.emit()
		if response == 2:
			add_child(load("res://scenes/pc/two_player.tscn").instantiate())
			in_menu = false
			in_game = true
			%MainUnfocusMask.hide()
			%NumPlayersCanvas.hide()
			%MainButtonMasker.show()
			move_child(%OptionMenu, 8)
		elif response == 3:
			add_child(load("res://scenes/pc/three_player.tscn").instantiate())
			in_menu = false
			in_game = true
			%MainUnfocusMask.hide()
			%NumPlayersCanvas.hide()
			%MainButtonMasker.show()
			move_child(%OptionMenu, 8)
		elif response == 4:
			add_child(load("res://scenes/pc/four_player.tscn").instantiate())
			in_menu = false
			in_game = true
			%MainUnfocusMask.hide()
			%NumPlayersCanvas.hide()
			%MainButtonMasker.show()
			move_child(%OptionMenu, 8)
		elif response == 5:
			add_child(load("res://scenes/pc/five_player.tscn").instantiate())
			in_menu = false
			in_game = true
			%MainUnfocusMask.hide()
			%NumPlayersCanvas.hide()
			%MainButtonMasker.show()
			move_child(%OptionMenu, 8)
		elif response == 6:
			add_child(load("res://scenes/pc/six_player.tscn").instantiate())
			in_menu = false
			in_game = true
			%MainUnfocusMask.hide()
			%NumPlayersCanvas.hide()
			%MainButtonMasker.show()
			move_child(%OptionMenu, 8)

func _on_start_button_pressed() -> void:
	if not in_menu:
		%NumPlayersCanvas.show()
		in_menu = true
		%MainUnfocusMask.show()
		%MainButtonMasker.show()

func _on_load_button_pressed() -> void:
	if not in_menu:
		%LoadMenu.check_for_save()
		%LoadMenu.show()
		in_menu = true
		%MainUnfocusMask.show()
		%MainButtonMasker.show()

func _on_options_button_pressed() -> void:
	if not in_menu:
		%OptionMenu.show()
		in_menu = true
		%MainUnfocusMask.show()
		%MainButtonMasker.show()

func _on_load_menu_response(response) -> void:
	if response == "close":
		%LoadMenu.hide()
		in_menu = false
		%MainUnfocusMask.hide()
		%MainButtonMasker.hide()

func _on_option_menu_response(response) -> void:
	if response == "close":
		%OptionMenu.hide()
		in_menu = false
		%MainUnfocusMask.hide()
		%MainButtonMasker.hide()

func _on_change_language(language_code) -> void:
	TranslationServer.set_locale(language_code)

func _on_exit_game() -> void:
	in_menu = false
	in_game = false
	%MainUnfocusMask.hide()
	%MainButtonMasker.hide()

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_load_game() -> void:
	var num_players = SaveLoad.save_contents.get("names").keys().size()
	for i in range(num_players):
		var primary_events = SaveLoad.save_contents.get("primary_events")
		var secondary_events = SaveLoad.save_contents.get("secondary_events")
		var player = i+1
		var action = "Player%s" % player
		InputMap.action_erase_events(action)
		InputMap.action_add_event(action, InputSerializer.string_to_input_event(primary_events[i]))
		if secondary_events[i] != null:
			InputMap.action_add_event(action, InputSerializer.string_to_input_event(secondary_events[i]))
	match num_players:
		2:
			SaveLoad.loading = true
			add_child(load("res://scenes/pc/two_player.tscn").instantiate())
			in_menu = false
			in_game = true
			%MainUnfocusMask.hide()
			%LoadMenu.hide()
			%MainButtonMasker.show()
			%OptionMenu._on_start_pre_game()
			%OptionMenu._on_start_game()
			move_child(%OptionMenu, 8)
		3:
			SaveLoad.loading = true
			add_child(load("res://scenes/pc/three_player.tscn").instantiate())
			in_menu = false
			in_game = true
			%MainUnfocusMask.hide()
			%LoadMenu.hide()
			%MainButtonMasker.show()
			%OptionMenu._on_start_pre_game()
			%OptionMenu._on_start_game()
			move_child(%OptionMenu, 8)
		4:
			SaveLoad.loading = true
			add_child(load("res://scenes/pc/four_player.tscn").instantiate())
			in_menu = false
			in_game = true
			%MainUnfocusMask.hide()
			%LoadMenu.hide()
			%MainButtonMasker.show()
			%OptionMenu._on_start_pre_game()
			%OptionMenu._on_start_game()
			move_child(%OptionMenu, 8)
		5:
			SaveLoad.loading = true
			add_child(load("res://scenes/pc/five_player.tscn").instantiate())
			in_menu = false
			in_game = true
			%MainUnfocusMask.hide()
			%LoadMenu.hide()
			%MainButtonMasker.show()
			%OptionMenu._on_start_pre_game()
			%OptionMenu._on_start_game()
			move_child(%OptionMenu, 8)
		6:
			SaveLoad.loading = true
			add_child(load("res://scenes/pc/six_player.tscn").instantiate())
			in_menu = false
			in_game = true
			%MainUnfocusMask.hide()
			%LoadMenu.hide()
			%MainButtonMasker.show()
			%OptionMenu._on_start_pre_game()
			%OptionMenu._on_start_game()
			move_child(%OptionMenu, 8)
		_:
			print("load formatting error: cannot read number of players")
			print("make sure there are 2-6 names in the first field of the JSON")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Options"):
		if in_menu:
			%OptionMenu.hide()
			%LoadMenu.hide()
			in_menu = false
			if not in_game:
				%MainUnfocusMask.hide()
				%MainButtonMasker.hide()
		else:
			%OptionMenu.show()
			in_menu = true
			if not in_game:
				%MainUnfocusMask.show()
				%MainButtonMasker.show()
			
