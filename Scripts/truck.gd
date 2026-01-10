extends MeshInstance3D

@onready var truck: MeshInstance3D = $"."
@onready var back_left_tire: MeshInstance3D = $BackLeftTire
@onready var back_right_tire: MeshInstance3D = $BackRightTire
@onready var front_right_tire: MeshInstance3D = $FrontRightTire
@onready var front_right_tire_001: MeshInstance3D = $FrontRightTire_001

@export var rotation_amount: float = 700.0

var tire_list = []

var truck_moving: bool = true

func _ready() -> void:
	tire_list.append(back_left_tire)
	tire_list.append(back_right_tire)
	tire_list.append(front_right_tire)
	tire_list.append(front_right_tire_001)
	
	SignalManager.stop_truck.connect(stop_truck)
	SignalManager.start_truck.connect(start_truck)
	
func rotate_tires(delta):
	for tire in tire_list:
		tire.rotation_degrees.z += rotation_amount * delta
		
func stop_truck():
	print("Stopping truck in the truck script")
	truck_moving = false
	
func start_truck():
	truck_moving = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if truck_moving:
		rotate_tires(delta)
