extends Node2D

signal response

var confirming = false

func check_for_save() -> void:
	await SaveLoad.check_for_save()
	if SaveLoad.saved:
		%SaveName.text = SaveLoad.save_name
		%LoadButton.show()

func _on_refresh_button_pressed() -> void:
	check_for_save()

func _on_close_button_pressed() -> void:
	response.emit("close")

func _on_load_button_pressed() -> void:
	GlobalSignals.load_game.emit()
