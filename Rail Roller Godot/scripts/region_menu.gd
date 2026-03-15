extends Node2D

var current_player

# Button names
# 0 NorthWest
# 1 Plains
# 2 NorthCentral
# 3 NorthEast
# 4 SouthWest
# 5 SouthCentral
# 6 SouthEast
# 7 Minimize

func _ready():
	GlobalSignals.request_region.connect(_on_choose_region, CONNECT_PERSIST)

func _on_choose_region(player):
	%RegionCanvas.show()
	current_player = player

func _on_north_west_pressed() -> void:
	if not minimized:
		%RegionCanvas.hide()
		GlobalSignals.return_region.emit("NW", current_player)


func _on_plains_pressed() -> void:
	if not minimized:
		%RegionCanvas.hide()
		GlobalSignals.return_region.emit("P", current_player)


func _on_north_central_pressed() -> void:
	if not minimized:
		%RegionCanvas.hide()
		GlobalSignals.return_region.emit("NC", current_player)


func _on_north_east_pressed() -> void:
	if not minimized:
		%RegionCanvas.hide()
		GlobalSignals.return_region.emit("NE", current_player)


func _on_south_west_pressed() -> void:
	if not minimized:
		%RegionCanvas.hide()
		GlobalSignals.return_region.emit("SW", current_player)


func _on_south_central_pressed() -> void:
	if not minimized:
		%RegionCanvas.hide()
		GlobalSignals.return_region.emit("SC", current_player)


func _on_south_east_pressed() -> void:
	if not minimized:
		%RegionCanvas.hide()
		GlobalSignals.return_region.emit("SE", current_player)

var minimized = false

func _on_minimize_pressed() -> void:
	minimized = true

func _input(event):
	if event.is_pressed() and minimized:
		minimized = false

var alpha = 0
var starting_scale = Vector2(1, 1)
var ending_scale = Vector2(0.25, 0.25)
var starting_offset = Vector2(0, 0)
var ending_offset = Vector2(800, -400)
var animation_speed = 4

func _process(delta: float) -> void:
	if minimized:
		if alpha < 1:
			alpha += delta * animation_speed
			if alpha > 1:
				alpha = 1
			%RegionCanvas.scale = lerp(starting_scale, ending_scale, alpha)
			%RegionCanvas.offset = lerp(starting_offset, ending_offset, alpha)
	else:
		if alpha > 0:
			alpha -= delta * animation_speed
			if alpha < 0:
				alpha = 0
			%RegionCanvas.scale = lerp(starting_scale, ending_scale, alpha)
			%RegionCanvas.offset = lerp(starting_offset, ending_offset, alpha)
		
