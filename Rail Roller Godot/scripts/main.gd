extends Node2D

var in_menu = false

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
			add_child(load("res://scenes/two_player.tscn").instantiate())
			in_menu = false
			%MainUnfocusMask.hide()
			%NumPlayersCanvas.hide()
			%MainButtonMasker.hide()
		elif response == 3:
			add_child(load("res://scenes/three_player.tscn").instantiate())
			in_menu = false
			%MainUnfocusMask.hide()
			%NumPlayersCanvas.hide()
			%MainButtonMasker.hide()
		elif response == 4:
			add_child(load("res://scenes/four_player.tscn").instantiate())
			in_menu = false
			%MainUnfocusMask.hide()
			%NumPlayersCanvas.hide()
			%MainButtonMasker.hide()
		elif response == 5:
			add_child(load("res://scenes/five_player.tscn").instantiate())
			in_menu = false
			%MainUnfocusMask.hide()
			%NumPlayersCanvas.hide()
			%MainButtonMasker.hide()
		elif response == 6:
			add_child(load("res://scenes/six_player.tscn").instantiate())
			in_menu = false
			%MainUnfocusMask.hide()
			%NumPlayersCanvas.hide()
			%MainButtonMasker.hide()

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
	%MainUnfocusMask.hide()
	%MainButtonMasker.hide()

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_load_game() -> void:
	var num_players = SaveLoad.save_contents.names.length
	match num_players:
		2:
			await add_child(load("res://scenes/two_player.tscn").instantiate())
			find_child("TwoPlayer").load_game()
			in_menu = false
			%MainUnfocusMask.hide()
			%LoadMenu.hide()
			%MainButtonMasker.hide()
		3:
			await add_child(load("res://scenes/three_player.tscn").instantiate())
			find_child("ThreePlayer").load_game()
			in_menu = false
			%MainUnfocusMask.hide()
			%LoadMenu.hide()
			%MainButtonMasker.hide()
		4:
			await add_child(load("res://scenes/four_player.tscn").instantiate())
			find_child("FourPlayer").load_game()
			in_menu = false
			%MainUnfocusMask.hide()
			%LoadMenu.hide()
			%MainButtonMasker.hide()
		5:
			await add_child(load("res://scenes/five_player.tscn").instantiate())
			find_child("FivePlayer").load_game()
			in_menu = false
			%MainUnfocusMask.hide()
			%LoadMenu.hide()
			%MainButtonMasker.hide()
		6:
			await add_child(load("res://scenes/six_player.tscn").instantiate())
			find_child("SixPlayer").load_game()
			in_menu = false
			%MainUnfocusMask.hide()
			%LoadMenu.hide()
			%MainButtonMasker.hide()
		_:
			print("load formatting error: cannot read number of players")
			print("make sure there are 2-6 names in the first field of the JSON")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Options"):
		if in_menu:
			%OptionMenu.hide()
			%LoadMenu.hide()
			in_menu = false
			%MainUnfocusMask.hide()
			%MainButtonMasker.hide()
		else:
			%OptionMenu.show()
			in_menu = true
			%MainUnfocusMask.show()
			%MainButtonMasker.show()
			
