extends MeshInstance3D

var fridge_closed_rot = 0.0
var fridge_opened_rot = -80.0

var fridge_open: bool = false

func toggle_door():
	fridge_open = !fridge_open
	
	var tween = create_tween()
	if fridge_open:
		tween.tween_property(self, "rotation_degrees:y", fridge_opened_rot, 0.35)
	else:
		tween.tween_property(self, "rotation_degrees:y", fridge_closed_rot, 0.35)
