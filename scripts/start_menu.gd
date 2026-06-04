extends Node2D

signal response

func _on_x_pressed() -> void:
	response.emit(0)

func _on_2_pressed() -> void:
	response.emit(2)

func _on_3_pressed() -> void:
	response.emit(3)

func _on_4_pressed() -> void:
	response.emit(4)

func _on_5_pressed() -> void:
	response.emit(5)

func _on_6_pressed() -> void:
	response.emit(6)
