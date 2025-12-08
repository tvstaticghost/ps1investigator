extends Node3D

@onready var camera_3d: Camera3D = $Camera3D
@export var rotation_speed: float = 0.2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(camera_3d.rotation)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("pan_left"):
		camera_3d.rotation.y += rotation_speed * delta
	if Input.is_action_pressed("pan_right"):
		camera_3d.rotation.y -= rotation_speed * delta
	if Input.is_action_pressed("pan_down"):
		camera_3d.rotation.x -= rotation_speed * delta
	if Input.is_action_pressed("pan_up"):
		camera_3d.rotation.x += rotation_speed * delta
