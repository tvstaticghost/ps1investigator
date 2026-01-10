extends Panel

@onready var start_menu: Panel = $StartMenu
@onready var time_label: Label = $TimeBox/TimeLabel

@onready var not_pressed_panel: Panel = $NotPressedPanel
@onready var pressed_panel: Panel = $PressedPanel
var pressed: bool = false

func _ready() -> void:
	time_label.text = "11:59 AM"

func toggle_button():
	not_pressed_panel.visible = !not_pressed_panel.visible
	pressed_panel.visible = !pressed_panel.visible
	
func toggle_menu():
	print("visible")
	start_menu.visible = pressed

func _on_button_pressed() -> void:
	pressed = !pressed
	toggle_button()
	toggle_menu()
