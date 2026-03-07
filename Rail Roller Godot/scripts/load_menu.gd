extends Node2D

signal response

var confirming = false


func _on_refresh_button_pressed() -> void:
	if not confirming:
		pass

func _on_close_button_pressed() -> void:
	if not confirming:
		response.emit("close")

func _on_load_button_pressed() -> void:
	if not confirming:
		pass

func _on_delete_button_pressed() -> void:
	if not confirming:
		confirming = true
		%LoadUnfocusMask.show()
		%LoadButtonMasker.show()
		%DeleteConfirmation.show()

func _on_confirmation_close_button_pressed() -> void:
	confirming = false
	%LoadUnfocusMask.hide()
	%LoadButtonMasker.hide()
	%DeleteConfirmation.hide()


func _on_confirmation_yes_button_pressed() -> void:
	GlobalSignals.delete_save.emit()
	confirming = false
	%LoadUnfocusMask.hide()
	%LoadButtonMasker.hide()
	%DeleteConfirmation.hide()


func _on_confirmation_no_button_pressed() -> void:
	confirming = false
	%LoadUnfocusMask.hide()
	%LoadButtonMasker.hide()
	%DeleteConfirmation.hide()
