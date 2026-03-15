extends Game

func _ready():
	NUM_PLAYERS = 3
	initialize_arrays()
	colors = {
		1 : "blue",
		2 : "green",
		3 : "red"
	}
	names = {
		1 : TranslationServer.translate("PLAYER_1"),
		2 : TranslationServer.translate("PLAYER_2"),
		3 : TranslationServer.translate("PLAYER_3")
	}
	primary_keybind_content = {
		1 : [true, "1"],
		2 : [true, "2"],
		3 : [true, "3"]
	}
	secondary_keybind_content = {
		1 : [true, ""],
		2 : [true, ""],
		3 : [true, ""]
	}
	readied = {
		1 : false,
		2 : false,
		3 : false
	}

func _input(event):
	if event.is_pressed() and event.is_action("Player1") and not_waiting:
		choose_destination(0)
	if event.is_pressed() and event.is_action("Player2") and not_waiting:
		choose_destination(1)
	if event.is_pressed() and event.is_action("Player3") and not_waiting:
		choose_destination(2)
	if event is InputEventKey and event.pressed and event.physical_keycode == KEY_ESCAPE:
		open_exit_menu.emit()

func _on_color_selection(player: int, color: String):
	change_color(player, color)

func _on_ready_pressed(player: int):
	toggle_ready(player)
