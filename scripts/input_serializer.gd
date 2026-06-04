extends Node

func string_to_input_event(text: String) -> InputEvent:
	var split_1 = text.split(":")
	var type = split_1[0]
	var rest = split_1[1]
	var output
	match type:
		"InputEventKey":
			output = InputEventKey.new()
			var split_2 = rest.split(" ")
			#keycode
			var keycode = split_2[1].erase(0, 8).split(" ")[0]
			if keycode.begins_with("U+"):
				#unicode key label
				output.set_key_label(OS.find_keycode_from_string(OS.get_keycode_string(keycode)))
			else:
				match split_2[4]:
					#physical keycode
					"physical=true,":
						output.set_physical_keycode(keycode.to_int())
					#keycode
					"physical=false,":
						output.set_keycode(keycode.to_int())
					_:
						print("InputSerializer: unhandled physical value")
			#mods
			var mods = split_2[3].erase(0, 5).split(",")[0]
			if mods != "none":
				var split_3 = mods.split("+")
				for x in split_3:
					match x:
						"Shift":
							output.set_shift_pressed(true)
						"Ctrl":
							output.set_ctrl_pressed(true)
						"Alt":
							output.set_alt_pressed(true)
						_:
							output.set_meta_pressed(true)
			#location
			match split_2[5]:
				"location=left,":
					output.set_location(KEY_LOCATION_LEFT)
				"location=right,":
					output.set_location(KEY_LOCATION_RIGHT)
				"location=unspecified,":
					output.set_location(KEY_LOCATION_UNSPECIFIED)
				_:
					print("InputSerializer: unhandled location value")
			#pressed
			match split_2[6]:
				"pressed=false,":
					output.set_pressed(false)
				"pressed=true,":
					output.set_pressed(true)
				_:
					print("InputSerializer: unhandled pressed value")
			#echo
			match split_2[7]:
				"echo=false":
					output.set_echo(false)
				"echo=true":
					output.set_echo(true)
				_:
					print("InputSerializer: unhandled echo value")
		#"InputEventAction":
		#	output = InputEventAction.new()
		#"InputEventJoypadButton":
		#	output = InputEventJoypadButton.new()
		#"InputEventJoypadMotion":
		#	output = InputEventJoypadMotion.new()
		_:
			print("InputSerializer: unhandled InputEvent type")
	return output
