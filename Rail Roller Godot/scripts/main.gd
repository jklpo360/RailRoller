extends Node2D

var in_menu = false

func _ready():
	TranslationServer.set_locale("en")

func _on_player_number_menu_response(response) -> void:
	if response == 0:
		in_menu = false
		%MainUnfocusMask.hide()
		%NumPlayersCanvas.hide()
		%MainButtonMasker.hide()
	elif response == 2:
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
		%LoadMenu.show()
		in_menu = true
		%MainUnfocusMask.show()
		%MainButtonMasker.show()

func _on_options_button_pressed() -> void:
	if not in_menu:
		pass


func _on_load_menu_response(response) -> void:
	if response == "close":
		%LoadMenu.hide()
		in_menu = false
		%MainUnfocusMask.hide()
		%MainButtonMasker.hide()
