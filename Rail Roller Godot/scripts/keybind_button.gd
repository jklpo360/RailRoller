extends Button
class_name KeybindButton

@export var action : String
@export var action_event_index : int = 0
@export var player: int
var primary : bool
var evicter: bool = false

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

func _ready():
	primary = action_event_index == 0
	toggle_mode = true
	_toggled(false)
	GlobalSignals.change_keybind.connect(_on_change_keybind, ConnectFlags.CONNECT_PERSIST)
	GlobalSignals.evict_duplicate_keybind_action_index.connect(_on_evict_duplicate_keybind_action_index, ConnectFlags.CONNECT_PERSIST)
	GlobalSignals.bump_keybind_action_index.connect(_on_bump_action_index, ConnectFlags.CONNECT_PERSIST)

func _toggled(toggled_on: bool):
	if !action or !InputMap.has_action(action):
		return
	
	if toggled_on:
		text = ""
		icon = ControllerIcons.key_icons.get("Waiting")
		return
	
	if action_event_index >= InputMap.action_get_events(action).size():
		text = ""
		icon = null
		return
	
	var input = InputMap.action_get_events(action)[action_event_index]
	if input is InputEventJoypadButton:
		if CONTROLLER_LABELS.has(input.button_index):
			text = CONTROLLER_LABELS.get(input.button_index)
			if ControllerIcons.key_icons.has(text):
				icon = ControllerIcons.key_icons.get(text)
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
			if ControllerIcons.key_icons.has(text):
				icon = ControllerIcons.key_icons.get(text)
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
			if ControllerIcons.key_icons.has(text):
				icon = ControllerIcons.key_icons.get(text)
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
			text = OS.get_keycode_string(input.keycode)
			if ControllerIcons.key_icons.has(text):
				icon = ControllerIcons.key_icons.get(text)
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

func _unhandled_input(event: InputEvent) -> void:
	if !InputMap.has_action(action) or !is_pressed():
		return
	
	if event.is_pressed() and (event is InputEventKey or event is InputEventJoypadButton):
		var action_events_list = InputMap.action_get_events(action)
		if action_event_index < action_events_list.size():
			InputMap.action_erase_event(action, action_events_list[action_event_index])
		
		InputMap.action_add_event(action, event)
		action_event_index = InputMap.action_get_events(action).size() - 1
		evicter = true
		GlobalSignals.evict_duplicate_keybind_action_index.emit(player, action_event_index)
		button_pressed = false
		release_focus()

func _input(event: InputEvent):
	if event.is_pressed() and event is InputEventMouseButton:
		button_pressed = false
		release_focus()

func _on_change_keybind(player: int, primary: bool, is_text: bool, contents) -> void:
	if not (player == self.player and primary == self.primary):
		if is_text:
			if text == contents:
				text = ""
				if not player == self.player:
					var action_events_list = InputMap.action_get_events(action)
					if action_event_index < action_events_list.size():
						InputMap.action_erase_event(action, action_events_list[action_event_index])
					if action_event_index == 0 and InputMap.action_get_events(action).size() > 0:
						action_event_index = 2
						GlobalSignals.bump_keybind_action_index.emit(self.player)
		else:
			if icon == contents:
				icon = null
				if not player == self.player:
					var action_events_list = InputMap.action_get_events(action)
					if action_event_index < action_events_list.size():
						InputMap.action_erase_event(action, action_events_list[action_event_index])
					if action_event_index == 0 and InputMap.action_get_events(action).size() > 0:
						action_event_index = 2
						GlobalSignals.bump_keybind_action_index.emit(self.player)

func _on_evict_duplicate_keybind_action_index(player: int, action_index: int):
	if player == self.player and action_index == action_event_index:
		if evicter:
			evicter = false
		else:
			if action_event_index == 0:
				action_event_index = 1
			elif action_event_index == 1:
				action_event_index = 0
			else:
				print("invalid action event index was found while trying to evict!")

func _on_bump_action_index(player):
	if self.player == player:
		action_event_index -= 1
