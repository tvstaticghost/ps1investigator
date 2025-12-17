extends Panel

@onready var button_background: Panel = $Button/ButtonBackground
@onready var bottom_background: Panel = $Button/BottomBackground
@onready var button: Button = $Button

var pressed := false

func _ready() -> void:
	update_visuals()

func update_visuals():
	if pressed:
		bottom_background.self_modulate = Color.WHITE
		button_background.self_modulate = Color.BLACK
	else:
		bottom_background.self_modulate = Color.BLACK
		button_background.self_modulate = Color.WHITE

func set_pressed(value: bool):
	pressed = value
	update_visuals()

func toggle():
	set_pressed(!pressed)

func _on_button_pressed() -> void:
	print("Pressed menu button")
	SignalManager.toggle_start_menu.emit()
	toggle()
