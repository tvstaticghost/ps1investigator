extends MeshInstance3D

var drawer_closed_pos = -0.974
var drawer_open_pos = -0.6
var drawer_open: bool = false

var cabinet_closed_rot = 0.0
var cabinet_open_rot = 80.0
var cabinet_open: bool = false
var drawer_speed: float = 0.4

var backwards: bool = false

func _ready() -> void:
	drawer_closed_pos = get_child(0).position.x
	
	if drawer_closed_pos > 0.0:
		backwards = true
		
	if backwards:
		drawer_open_pos = drawer_closed_pos - 0.374
	else:
		drawer_open_pos = drawer_closed_pos + 0.374

func toggle_drawer():
	drawer_open = !drawer_open
	if drawer_open:
		var tween = create_tween()
		tween.tween_property(get_child(0), "position", Vector3(drawer_open_pos, get_child(0).position.y, get_child(0).position.z), drawer_speed)
		#get_child(0).position.x = drawer_open_pos
	else:
		var tween = create_tween()
		tween.tween_property(get_child(0), "position", Vector3(drawer_closed_pos, get_child(0).position.y, get_child(0).position.z), drawer_speed)
		#get_child(0).position.x = drawer_closed_pos

func toggle_cabinet():
	cabinet_open = !cabinet_open
	if cabinet_open:
		var tween = create_tween()
		tween.tween_property(get_child(1), "rotation_degrees:y", cabinet_open_rot, drawer_speed)
		#get_child(1).rotation_degrees.y = 80.0
	else:
		var tween = create_tween()
		tween.tween_property(get_child(1), "rotation_degrees:y", cabinet_closed_rot, drawer_speed)
		#get_child(1).rotation_degrees.y = 0.0
