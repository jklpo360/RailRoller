extends Game

func _ready():
	NUM_PLAYERS = 5
	initialize_arrays()
	if SaveLoad.loading:
		readied = {
			1 : false,
			2 : false,
			3 : false, 
			4 : false,
			5 : false
		}
		load_game()
		SaveLoad.loading = false
	else:
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
		readied = {
			1 : false,
			2 : false,
			3 : false, 
			4 : false,
			5 : false
		}
	
func _input(event):
	if in_game:
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
	if event.is_action_pressed("Options"):
		if paused:
			_on_close_options_menu()
		else:
			paused = true
			%GameUnfocusMask.show()
			%GameButtonMasker.show()

func _on_color_selection(player: int, color: String):
	change_color(player, color)

func _on_ready_pressed(player: int):
	toggle_ready(player)

func _on_home_swap_button_pressed(player: int) -> void:
	swap_home_city(player)
