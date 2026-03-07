extends Node

const save_location = "user://SaveFile.json"
var saved = false
var save_name = ""

var save_contents: Dictionary = {
	"save_name": "",
	"colors": [],
	"home_cities": [],
	"previous_destinations": [],
	"destinations": [],
	"rewards": []
}

func _ready():
	GlobalSignals.save_game.connect(_on_save_game, CONNECT_PERSIST)
	
	check_for_save()

func check_for_save():
	saved = FileAccess.file_exists(save_location)
	if saved:
		await load_save()
		save_name = save_contents.save_name
		
	

func save():
	var file = FileAccess.open(save_location, FileAccess.WRITE)
	file.store_var(save_contents.duplicate())
	file.close()

func load_save():
	if FileAccess.file_exists(save_location):
		var file = FileAccess.open(save_location, FileAccess.READ)
		var data = file.get_var()
		file.close()
		
		save_contents = data.duplicate()
		save_name = save_contents.save_name
		GlobalSignals.game_load.emit(
			save_contents.save_name,
			save_contents.colors,
			save_contents.home_cities, 
			save_contents.previous_destinations, 
			save_contents.destinations, 
			save_contents.rewards
		)
	return

func _on_save_game(save_name, colors, home_cities, previous_destinations, current_destinations, rewards):
	save_contents.save_name = save_name
	save_contents.colors = colors.duplicate()
	save_contents.home_cities = home_cities.duplicate()
	save_contents.previous_destinations = previous_destinations.duplicate()
	save_contents.destinations = current_destinations.duplicate()
	save_contents.rewards = rewards.duplicate()
