extends Node3D

@export var truck_movement_speed: float = 3.0
@onready var desktop: Control = $CanvasLayer/Desktop

const TRUCK = preload("uid://dmve4ykasbvav")
const FLASHLIGHT = preload("uid://c4bs8pu3e6afn")
const FOG_LIGHT = preload("uid://bwwqha0k8al3q")
const FOG_LIGHT_BOX = preload("uid://bemyvreuk8goh")
const LOCK = preload("uid://bj41eh05vsqgf")
const LOCK_BOX = preload("uid://cxf6rsh58673h")
const SECURITY_CAMERA = preload("uid://c5s2rwvow0ecg")
const CAMERA_BOX = preload("uid://cop5dm4ih7xgi")
const FLASH_LIGHT_BOX = preload("uid://bbxsey0rcoix6")
@onready var package_spawn_1: Marker3D = $PackageObjects/PackageSpawn1
@onready var package_spawn_2: Marker3D = $PackageObjects/PackageSpawn2
var spawn_switcher: bool = false

@onready var truck_spawn_point: Marker3D = $Path3D/TruckSpawnPoint
@onready var path_follow_3d: PathFollow3D = $Path3D/PathFollow3D
@onready var delivery_timer: Timer = $DeliveryTimer
@onready var package_objects: Node3D = $PackageObjects
@onready var inventory: Control = $CanvasLayer/Inventory
@onready var player: CharacterBody3D = $Player

var truck_spawned: bool = false
var stop_truck: bool = false
var stop_pending: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.view_desktop.connect(toggle_desktop)
	SignalManager.exit_desktop.connect(hide_desktop)
	
	SignalManager.start_delivery.connect(spawn_truck)
	SignalManager.despawn_truck.connect(despawn_truck)
	SignalManager.spawn_package.connect(spawn_package)
	
func _process(_delta: float) -> void:
	#Toggle inventory
	if Input.is_action_just_pressed("inventory") and !player.using_computer:
		inventory.visible = !inventory.visible
		
		if inventory.visible:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			player.can_move = false
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			player.can_move = true
		
func _physics_process(delta: float) -> void:
	if truck_spawned:
		if !stop_truck:
			move_truck(delta)
	
func toggle_desktop():
	desktop.visible = true

func hide_desktop():
	desktop.visible = false
	
func stop_truck_for_delivery():
	print("deliver package")
	
func move_truck(delta):
	if stop_pending:
		if path_follow_3d.progress < 55.0:
			path_follow_3d.progress += truck_movement_speed * delta
		else:
			stop_truck = true
			SignalManager.stop_truck.emit()
			delivery_timer.start()
	else:
		if path_follow_3d.progress_ratio < 1.0:
			path_follow_3d.progress += truck_movement_speed * delta
		else:
			SignalManager.despawn_truck.emit()

func spawn_truck():
	print("Time to spawn the truck")
	var truck = TRUCK.instantiate()
	path_follow_3d.add_child(truck)
	truck.global_position.x = truck_spawn_point.global_position.x
	truck.global_position.z = truck_spawn_point.global_position.z
	truck.rotation_degrees.y -= 90
	truck_spawned = true
	stop_pending = true

func despawn_truck():
	print("despawning truck")
	var truck_inst = path_follow_3d.get_child(0)
	if truck_inst.is_in_group("Truck"):
		truck_inst.queue_free()
		truck_spawned = false
		path_follow_3d.progress = 0.0
		
func item_spawn(box, offset):
	var box_inst = box.instantiate()
	
	package_objects.add_child(box_inst)
	
	if spawn_switcher:
		box_inst.global_position = package_spawn_1.global_position
	else:
		box_inst.global_position = package_spawn_2.global_position
		
	box_inst.global_position.x += offset
	
	spawn_switcher = !spawn_switcher
		
func spawn_package(item: GameManager.ITEMS, offset: float):
	match item:
		0:
			print("Deliver a flashlight")
			item_spawn(FLASH_LIGHT_BOX,  offset)
		1:
			print("Deliver a motionlight")
			item_spawn(FOG_LIGHT_BOX, offset)
		2:
			print("Deliver a doorlock")
			item_spawn(LOCK_BOX, offset)
		3:
			print("Deliver a camera")
			item_spawn(CAMERA_BOX, offset)

func _on_delivery_timer_timeout() -> void:
	print("spawn packages here")
	SignalManager.start_truck.emit()
	delivery_timer.stop()
	stop_truck = false
	stop_pending = false
