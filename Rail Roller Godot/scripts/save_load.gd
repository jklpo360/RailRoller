extends Node

const save_location = "user://SaveFile.json"
var saved = false
var loading = false
var save_name = ""

var save_contents: Dictionary = {}

func _ready():
	check_for_save()

func check_for_save():
	if FileAccess.file_exists(save_location):
		await load_save()
	return

func load_save():
	if FileAccess.file_exists(save_location):
		var file = FileAccess.open(save_location, FileAccess.READ)
		var data = file.get_var()
		file.close()
		
		save_contents = data.duplicate()
		saved = true
		save_name = Time.get_datetime_string_from_unix_time(FileAccess.get_modified_time(save_location)).substr(0, 10)
	return

func save_game(names, colors, primary_events,	
	secondary_events, home_cities, home_city_regions,
	old_destinations, old_destination_regions, destinations, 
	destination_regions, rewards) -> void:
		save_contents = {}
		save_contents.set("names", names)
		save_contents.set("colors", colors)
		save_contents.set("primary_events", primary_events)
		save_contents.set("secondary_events", secondary_events)
		save_contents.set("home_cities", home_cities)
		save_contents.set("home_city_regions", home_city_regions)
		save_contents.set("old_destinations", old_destinations)
		save_contents.set("old_destination_regions", old_destination_regions)
		save_contents.set("destinations", destinations)
		save_contents.set("destination_regions", destination_regions)
		save_contents.set("rewards", rewards)
		
		var file = FileAccess.open(save_location, FileAccess.WRITE)
		file.store_var(save_contents.duplicate())
		saved = true
		# TODO: decide the format for the name of save files in the load menu
		#save_name = 
		file.close()
