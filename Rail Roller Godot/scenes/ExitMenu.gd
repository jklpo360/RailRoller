extends Node2D

var buttons
signal region_selection()

# Called when the node enters the scene tree for the first time.
func _ready():
	buttons = find_children("*Button")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#func 
