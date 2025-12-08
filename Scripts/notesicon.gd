extends Button

const NOTEPAD_UI = preload("uid://dqrpakwpbjrxp")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_pressed() -> void:
	print("Clicked on the notes icon")
	var notes_app = get_tree().get_first_node_in_group("NotesApp")
	
	if notes_app != null:
		SignalManager.open_application.emit(notes_app)
	else:
		print("Cannot find the notes app. Check to see if its added to scene")
