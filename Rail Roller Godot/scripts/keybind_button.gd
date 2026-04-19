extends Button
class_name KeybindButton

@export var action : String
@export var action_event_index : int = 0
@export var player: int
var primary : bool

const CONTROLLER_LABELS: Dictionary = {
	JoyButton.JOY_BUTTON_A: "A",
	JoyButton.JOY_BUTTON_B: "B",
	JoyButton.JOY_BUTTON_X: "X",
	JoyButton.JOY_BUTTON_Y: "Y",
	JoyButton.JOY_BUTTON_LEFT_SHOULDER: "LB",
	JoyButton.JOY_BUTTON_RIGHT_SHOULDER: "RB",
	JoyButton.JOY_BUTTON_LEFT_STICK: "L3",
	JoyButton.JOY_BUTTON_RIGHT_STICK: "R3",
	JoyButton.JOY_BUTTON_DPAD_UP: "↑",
	JoyButton.JOY_BUTTON_DPAD_DOWN: "↓",
	JoyButton.JOY_BUTTON_DPAD_LEFT: "←",
	JoyButton.JOY_BUTTON_DPAD_RIGHT: "→",
	JoyButton.JOY_BUTTON_START: "Start",
	JoyButton.JOY_BUTTON_GUIDE: "Select"
}

var ICONS: Dictionary = {
	"Waiting" : load("res://texture/icons/menu_icons/waiting_icon.png"),
	"Escape": load("res://texture/icons/key_icons/escape_icon.png"),
	"F1": load("res://texture/icons/key_icons/f1_icon.png"),
	"F2": load("res://texture/icons/key_icons/f2_icon.png"),
	"F3": load("res://texture/icons/key_icons/f3_icon.png"),
	"F4": load("res://texture/icons/key_icons/f4_icon.png"),
	"F5": load("res://texture/icons/key_icons/f5_icon.png"),
	"F6": load("res://texture/icons/key_icons/f6_icon.png"),
	"F7": load("res://texture/icons/key_icons/f7_icon.png"),
	"F8": load("res://texture/icons/key_icons/f8_icon.png"),
	"F9": load("res://texture/icons/key_icons/f9_icon.png"),
	"F10": load("res://texture/icons/key_icons/f10_icon.png"),
	"F11": load("res://texture/icons/key_icons/f11_icon.png"),
	"F12": load("res://texture/icons/key_icons/f12_icon.png"),
	"QuoteLeft": load("res://texture/icons/key_icons/tilda_icon.png"),
	"Delete": load("res://texture/icons/key_icons/delete_icon.png"),
	"Backspace" : load("res://texture/icons/key_icons/backspace_icon.png"),
	"BracketLeft" : load("res://texture/icons/key_icons/left_bracket_icon.png"),
	"BracketRight" : load("res://texture/icons/key_icons/right_bracket_icon.png"),
	"BackSlash" : load("res://texture/icons/key_icons/backslash_icon.png"),
	"CapsLock" : load("res://texture/icons/key_icons/caps_lock_icon.png"),
	"Semicolon" : load("res://texture/icons/key_icons/semicolon_icon.png"),
	"Apostrophe" : load("res://texture/icons/key_icons/apostraphe_icon.png"),
	"Enter" : load("res://texture/icons/key_icons/enter_icon.png"),
	"LeftShift" : load("res://texture/icons/key_icons/left_shift_icon.png"),#TODO: make work
	"Comma" : load("res://texture/icons/key_icons/comma_icon.png"),
	"Period" : load("res://texture/icons/key_icons/period_icon.png"),
	"Slash" : load("res://texture/icons/key_icons/slash_icon.png"),
	"RightShift" : load("res://texture/icons/key_icons/right_shift_icon.png"),#TODO: make work
	"Ctrl" : load("res://texture/icons/key_icons/control_icon.png"),#TODO: split into l and r
	"Yen": load("res://texture/icons/key_icons/yen_icon.png")
}

func _draw():
	if self.size.x > 78:
		print("Oversized key input: " + str(text))

func _ready():
	primary = action_event_index == 0
	toggle_mode = true
	_toggled(false)
	GlobalSignals.erase_keybind.connect(_erase_button, ConnectFlags.CONNECT_PERSIST)
	GlobalSignals.bump_keybind_action_index.connect(_bump_action_index, ConnectFlags.CONNECT_PERSIST)
	
func _toggled(toggled_on: bool):
	if !action or !InputMap.has_action(action):
		return
	
	if toggled_on:
		text = ""
		icon = ICONS.get("Waiting")
		return
	
	if action_event_index >= InputMap.action_get_events(action).size():
		text = ""
		icon = null
		return
	
	var input = InputMap.action_get_events(action)[action_event_index]
	if input is InputEventJoypadButton:
		if CONTROLLER_LABELS.has(input.button_index):
			text = CONTROLLER_LABELS.get(input.button_index)
			if ICONS.has(text):
				icon = ICONS.get(text)
				text = ""
				GlobalSignals.change_keybind.emit(
					player, 
					primary,
					false,
					icon
				)
			else:
				icon = null
				GlobalSignals.change_keybind.emit(
					player, 
					primary,
					true,
					text
				)
		else:
			text = "Button " + str(input.button_index)
			if ICONS.has(text):
				icon = ICONS.get(text)
				text = ""
				GlobalSignals.change_keybind.emit(
					player, 
					primary,
					false,
					icon
				)
			else:
				icon = null
				GlobalSignals.change_keybind.emit(
					player, 
					primary,
					true,
					text
				)
	elif InputEventKey:
		if input.physical_keycode != 0:
			text = OS.get_keycode_string(input.physical_keycode)
			if ICONS.has(text):
				icon = ICONS.get(text)
				text = ""
				GlobalSignals.change_keybind.emit(
					player, 
					primary,
					false,
					icon
				)
			else:
				icon = null
				print("(physical) " + str(input))
				GlobalSignals.change_keybind.emit(
					player, 
					primary,
					true,
					text
				)
		else:
			text = OS.get_keycode_string(input.keycode)
			if ICONS.has(text):
				icon = ICONS.get(text)
				text = ""
				GlobalSignals.change_keybind.emit(
					player, 
					primary,
					false,
					icon
				)
			else:
				icon = null
				print(input)
				GlobalSignals.change_keybind.emit(
					player, 
					primary,
					true,
					text
				)

func _unhandled_input(event: InputEvent) -> void:
	if !InputMap.has_action(action) or !is_pressed():
		return
	
	if event.is_pressed() and (event is InputEventKey or event is InputEventJoypadButton):
		var action_events_list = InputMap.action_get_events(action)
		if action_event_index < action_events_list.size():
			InputMap.action_erase_event(action, action_events_list[action_event_index])
		
		InputMap.action_add_event(action, event)
		action_event_index = InputMap.action_get_events(action).size() - 1
		button_pressed = false
		release_focus()

func _input(event: InputEvent):
	if event.is_pressed() and event is InputEventMouseButton:
		button_pressed = false
		release_focus()

func _erase_button(player, primary, erase_bind):
	if self.player == player and self.primary == primary:
		text = ""
		icon = null
		if erase_bind:
			print("different_player")
			var action_events_list = InputMap.action_get_events(action)
			if action_event_index < action_events_list.size():
				InputMap.action_erase_event(action, action_events_list[action_event_index])

func _bump_action_index(player):
	if self.player == player and not primary:
		action_event_index = 0
