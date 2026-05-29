extends Node2D

signal response

var selecting_language = false
var language_buttons
var check_icon = load("res://texture/icons/menu_icons/check_icon.png")
var currently_checked
var language_order_dictionary = {
	"en": 0,
	"jp": 1,
	"pt-BR": 2,
	"es": 3
}

func _ready():
	GlobalSignals.start_pre_game.connect(_on_start_pre_game, ConnectFlags.CONNECT_PERSIST)
	GlobalSignals.start_game.connect(_on_start_game, ConnectFlags.CONNECT_PERSIST)
	GlobalSignals.exit_game.connect(_on_exit_game, ConnectFlags.CONNECT_PERSIST)
	
	language_buttons = find_children("LanguageCheckButton")
	if language_order_dictionary.has(TranslationServer.get_locale()):
		currently_checked = language_order_dictionary.get(TranslationServer.get_locale())
	else:
		currently_checked = 0
	language_buttons[currently_checked].icon = check_icon

func _on_close_button_pressed() -> void:
	if not selecting_language:
		response.emit("close")
		GlobalSignals.close_options_menu.emit()

func _on_language_button_pressed() -> void:
	if not selecting_language:
		selecting_language = true
		%OptionUnfocusMask.show()
		%OptionButtonMasker.show()
		%LanguageMenu.show()

func _on_language_close_button_pressed() -> void:
	selecting_language = false
	%OptionUnfocusMask.hide()
	%OptionButtonMasker.hide()
	%LanguageMenu.hide()
	
func _on_swap_rule_button_pressed() -> void:
	if Settings.swap_rule:
		Settings.swap_rule = false
		GlobalSignals.swap_rule_toggled.emit()
		%SwapRule.frame = 0
	else:
		Settings.swap_rule = true
		GlobalSignals.swap_rule_toggled.emit()
		%SwapRule.frame = 1

func _on_language_check_button_pressed(language_string) -> void:
	GlobalSignals.change_language.emit(language_string)
	var pressed_button = language_order_dictionary.get(language_string)
	if not pressed_button == currently_checked:
		language_buttons[currently_checked].icon = null
		language_buttons[pressed_button].icon = check_icon
		currently_checked = pressed_button

func _on_start_pre_game() -> void:
	%BottomRow.show()

func _on_save_button_pressed() -> void:
	GlobalSignals.save_game.emit()

func _on_start_game() -> void:
	%SaveButton.show()

func _on_exit_button_pressed() -> void:
	GlobalSignals.exit_game.emit()

func _on_exit_game() -> void:
	%SaveButton.hide()
	%BottomRow.hide()
	self.hide()
