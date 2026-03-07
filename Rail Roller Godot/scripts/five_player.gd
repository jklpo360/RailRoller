extends Game

func _ready():
	NUM_PLAYERS = 5
	initialize_arrays()
	colors = {
		1 : "blue",
		2 : "green",
		3 : "yellow",
		4 : "red",
		5 : "black"
	}
	names = {
		1 : TranslationServer.translate("PLAYER_1"),
		2 : TranslationServer.translate("PLAYER_2"),
		3 : TranslationServer.translate("PLAYER_3"),
		4 : TranslationServer.translate("PLAYER_4"),
		5 : TranslationServer.translate("PLAYER_5")
	}
	primary_keybind_text = {
		1 : "1",
		2 : "2",
		3 : "3",
		4 : "4",
		5 : "5"
	}
	secondary_keybind_text = {
		1 : "",
		2 : "",
		3 : "",
		4 : "",
		5 : ""
	}
	readied = {
		1 : false,
		2 : false,
		3 : false, 
		4 : false,
		5 : false
	}
	
func _input(event):
	if event.is_pressed() and event.is_action("Player1") and not_waiting:
		choose_destination(0)
	if event.is_pressed() and event.is_action("Player2") and not_waiting:
		choose_destination(1)
	if event.is_pressed() and event.is_action("Player3") and not_waiting:
		choose_destination(2)
	if event.is_pressed() and event.is_action("Player4") and not_waiting:
		choose_destination(3)
	if event.is_pressed() and event.is_action("Player5") and not_waiting:
		choose_destination(4)
	if event is InputEventKey and event.pressed and event.physical_keycode == KEY_ESCAPE:
		open_exit_menu.emit()

func _on_color_selection(player: int, color: String):
	backgrounds[player-1].texture = colors.get(color)
	colors.set(player, color)

func _on_keybind_pressed(player: int, primary: bool) -> void:
	pass

func _on_ready_pressed(player: int):
	if readied.get(player):
		readied.set(player, false)
		hiding_backgrounds[player-1].hide()
		ready_buttons[player-1].text = TranslationServer.translate("READY")
	else:
		readied.set(player, true)
		var all_readied = true
		for i in readied.values():
			all_readied = all_readied and i
		if all_readied:
			for i in hiding_backgrounds:
				i.hide()
			for i in setup_interfaces:
				i.hide()
			for i in game_displays:
				i.show()
			for i in ready_buttons:
				i.text = TranslationServer.translate("READY")
			setup_game()
		else:
			hiding_backgrounds[player-1].show()
			ready_buttons[player-1].text = TranslationServer.translate("CHANGE_PLAYER_INFO")
