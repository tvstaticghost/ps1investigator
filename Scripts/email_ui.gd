extends Panel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_close_button_pressed() -> void:
	if visible:
		visible = false


func _on_minimize_button_pressed() -> void:
	print("Minimize email app")
