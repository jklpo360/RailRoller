extends Node2D

var buttons

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	buttons = find_children("\\d")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	print(event)
