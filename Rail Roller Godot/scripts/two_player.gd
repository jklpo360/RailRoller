extends Game

func _ready():
	NUM_PLAYERS = 2
	initialize_arrays()
	colors = {
		1 : "blue",
		2 : "green"
	}
	names = {
		1 : TranslationServer.translate("PLAYER_1"),
		2 : TranslationServer.translate("PLAYER_2")
	}
	primary_keybind_content = {
		1 : [true, "1"],
		2 : [true, "2"]
	}
	secondary_keybind_content = {
		1 : [true, ""],
		2 : [true, ""]
	}
	readied = {
		1 : false,
		2 : false
	}

func _input(event):
	if event.is_pressed() and event.is_action("Player1") and not_waiting:
		choose_destination(0)
	if event.is_pressed() and event.is_action("Player2") and not_waiting:
		choose_destination(1)

func _on_color_selection(player: int, color: String):
	change_color(player, color)

func _on_ready_pressed(player: int):
	toggle_ready(player)
