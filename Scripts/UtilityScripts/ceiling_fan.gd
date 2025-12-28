extends MeshInstance3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var max_speed := 2.0
@export var ramp_rate := 0.25

var current_speed := 0.0
var target_speed := 2.0

func _ready() -> void:
	animation_player.play("fan_on")
	animation_player.speed_scale = 0.0
	
	SignalManager.ceiling_fan_off.connect(fan_off)
	SignalManager.ceiling_fan_on.connect(fan_on)
	
func _process(delta):
	current_speed = move_toward(
		current_speed,
		target_speed,
		ramp_rate * delta
	)
	animation_player.speed_scale = current_speed

func fan_on():
	print("Fan toggled on, target speed set to max_speed")
	target_speed = max_speed
	
func fan_off():
	print("Fan toggled off, target speed set to 0")
	target_speed = 0.0
