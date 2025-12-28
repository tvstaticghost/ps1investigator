extends MeshInstance3D

@onready var stove_door: MeshInstance3D = $StoveDoor

var stove_closed_rot = 0.0
var stove_opened_rot = -80.0

var stove_open: bool = false

func _ready() -> void:
	pass
	
func toggle_door():
	stove_open = !stove_open
	var tween = create_tween()
	if stove_open:
		tween.tween_property(stove_door, "rotation_degrees:z", stove_opened_rot, 0.35)
		#stove_door.rotation_degrees.z = stove_opened_rot
	else:
		tween.tween_property(stove_door, "rotation_degrees:z", stove_closed_rot, 0.35)
		#stove_door.rotation_degrees.z = stove_closed_rot
