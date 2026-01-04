extends Node3D

var running_speed: float = 4.0
var running: bool = false
@onready var run_point: Marker3D = $"../RunPoint"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if running:
		var target_pos = run_point.global_position
		target_pos.y = global_position.y   # keep same height

		look_at(target_pos)
		rotation.y += PI

		var dir = (target_pos - global_position).normalized()
		global_position += dir * running_speed * delta
