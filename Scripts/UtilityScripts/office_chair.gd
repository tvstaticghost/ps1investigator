extends MeshInstance3D

func use_computer(player_pos: Vector3):
	var tween = create_tween()
	
	var target_pos = player_pos - global_position
	target_pos.y = 0
	target_pos = target_pos.normalized()
	
	var angle_y = atan2(target_pos.x, target_pos.z)
	
	tween.tween_property(self, "rotation:y", angle_y, 0.4)
	
	await tween.finished
	SignalManager.sit_at_computer.emit(global_position)
