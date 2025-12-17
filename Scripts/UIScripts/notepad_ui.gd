extends Control

var hovering: bool = false
	
func _process(_delta: float) -> void:
	if hovering and Input.is_action_just_pressed("Select"):
		SignalManager.select_application.emit(self)

func _on_minimize_button_pressed() -> void:
	print("minimized")

func _on_close_button_pressed() -> void:
	visible = false

func _on_title_bar_mouse_entered() -> void:
	print("print")
	hovering = true

func _on_title_bar_mouse_exited() -> void:
	hovering = false
