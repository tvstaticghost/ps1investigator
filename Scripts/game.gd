extends Node3D

@onready var desktop: Control = $CanvasLayer/Desktop
const TRUCK = preload("uid://dmve4ykasbvav")
@onready var truck_spawn_point: Marker3D = $TruckSpawnPoint


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.view_desktop.connect(toggle_desktop)
	SignalManager.exit_desktop.connect(hide_desktop)
	
	SignalManager.start_delivery.connect(spawn_truck)
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("light_off"):
		SignalManager.power_out.emit()
		
	if Input.is_action_just_pressed("light_on"):
		SignalManager.power_on.emit()
	
func toggle_desktop():
	desktop.visible = true

func hide_desktop():
	desktop.visible = false

func spawn_truck():
	print("Time to spawn the truck")
	var truck = TRUCK.instantiate()
	add_child(truck)
	truck.global_position.x = truck_spawn_point.global_position.x
	truck.global_position.z = truck_spawn_point.global_position.z
