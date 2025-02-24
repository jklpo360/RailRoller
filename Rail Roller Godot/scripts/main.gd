extends Node2D

signal response

var num_players
var scenes = [TwoPlayer, ThreePlayer, FourPlayer, FivePlayer, SixPlayer]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await response
	print("number of players is: ", num_players)
	self.add_child(scenes[num_players].constructor())
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _num_players_response(num_players):
	self.num_players = num_players
	response.emit()
	
