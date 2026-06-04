class_name Keybind

var name
var physical_keycode
var display_type
var display_item

func _init(name, physical_keycode, display_type, display_item):
	self.name = name
	self.physical_keycode = physical_keycode
	self.display_type = display_type
	self.display_item = display_item
