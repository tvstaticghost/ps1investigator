extends MeshInstance3D
@onready var sit_point_left: Marker3D = $SitPointLeft
@onready var sit_point_right: Marker3D = $SitPointRight

func use_computer(player_pos: Vector3):
	#var tween = create_tween()
	#
	#var target_pos = player_pos - global_position
	#target_pos.y = 0
	#target_pos = target_pos.normalized()
	#
	#var angle_y = atan2(target_pos.x, target_pos.z)
	#
	#tween.tween_property(self, "rotation:y", angle_y, 0.4)
	#
	#await tween.finished
	SignalManager.sit_at_computer.emit(global_position, sit_point_left.global_position, sit_point_right.global_position)
