extends Panel

@onready var bottom_background: Panel = $Button/BottomBackground
@onready var button_background_black: Panel = $Button/ButtonBackgroundBlack
@onready var button: Button = $Button

func _ready() -> void:
	bottom_background.self_modulate = Color(0,0,0,1)

func _on_button_pressed() -> void:
	print("Pressed menu button")
	SignalManager.toggle_start_menu.emit()
	if bottom_background.self_modulate == Color(1,1,1,1):
		bottom_background.self_modulate = Color(0,0,0,1)
	else:
		bottom_background.self_modulate = Color(1,1,1,1)
	button_background_black.visible = !button_background_black.visible
