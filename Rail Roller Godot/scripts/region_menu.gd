extends Node2D

signal response
signal chosen_region(region)
signal button_signal

var num_players
var canvas_layer
var buttons
var region

# Button names
# 0 NAB
# 1 NW
# 2 P
# 3 NC
# 4 NE
# 5 SW
# 6 SC
# 7 SE
# 8 Random

# Called when the node enters the scene tree for the first time.
func _ready():
	canvas_layer = self.find_child("CanvasLayer")
	#canvas_layer.hide()
	await response
	chosen_region.connect(find_parent("Main").find_children("*Player")[1]._region_response, ConnectFlags.CONNECT_PERSIST)
	buttons = find_children("*Button")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_choose_region(player):
	canvas_layer.show()
	await button_signal
	chosen_region.emit("P", player)

func _num_players_response(num_players):
	self.num_players = num_players
	response.emit()



func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed()
	print("******")
	print(viewport)
	print(event)
	print(shape_idx)
