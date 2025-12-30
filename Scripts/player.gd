extends CharacterBody3D

@onready var head: Node3D = $Head
@onready var ray_cast_3d: RayCast3D = $Head/Camera3D/RayCast3D
@onready var interact_overlay: Control = $"../CanvasLayer/InteractOverlay"
@onready var texture_rect: TextureRect = $CanvasLayer/Control/TextureRect
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D
@onready var camera_3d: Camera3D = $Head/Camera3D

@export var position_curve: Curve

const SPEED = 1.6
const JUMP_VELOCITY = 4.5
const MOUSE_SENS = 0.05
const GRAVITY = 5.0
const INITIAL_FOV = 75.0

var can_move := true
var move_progress := 0.0

var reticle_dim: bool = true

var computer_entry_point: Vector3
var using_computer: bool = false

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	SignalManager.sit_at_computer.connect(use_computer)
	
func toggle_reticle_alpha():
	if reticle_dim:
		texture_rect.self_modulate.a = 0.21
	else:
		texture_rect.self_modulate.a = 0.7

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and can_move:
		rotate_y(deg_to_rad(-event.relative.x * MOUSE_SENS))
		head.rotate_x(deg_to_rad(-event.relative.y * MOUSE_SENS))

		# Clamp head vertical rotation
		head.rotation_degrees.x = clamp(head.rotation_degrees.x, -89, 89)
		
func use_computer(desk_chair_pos: Vector3, left_point_pos: Vector3, right_point_pos: Vector3):
	collision_shape_3d.disabled = true
	can_move = false
	
	var tween = create_tween()
	#Get Beside Chair
	if global_position.x > desk_chair_pos.x:
		computer_entry_point = Vector3(left_point_pos.x, global_position.y, left_point_pos.z)
		tween.tween_property(self, "global_position", computer_entry_point, 0.7).set_trans(Tween.TRANS_CUBIC)
	else:
		computer_entry_point = Vector3(right_point_pos.x, global_position.y, right_point_pos.z)
		tween.tween_property(self, "global_position", computer_entry_point, 0.7).set_trans(Tween.TRANS_CUBIC)
	
	tween.tween_interval(0.15)
	
	tween.tween_property(self, "global_position", Vector3(desk_chair_pos.x, desk_chair_pos.y + 0.3, desk_chair_pos.z + 0.2), 0.7).set_trans(Tween.TRANS_CUBIC)
	rotation_degrees.y = 180.0
	rotation_degrees.x = 17.5 # So the fov lines up with the computer monitor better
	
	tween.tween_interval(0.15)
	
	tween.tween_property(camera_3d, "fov", 37, 0.4).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	await tween.finished
	
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	using_computer = true
	SignalManager.view_desktop.emit()
	
func stop_using_computer():
	SignalManager.exit_desktop.emit()
	var tween = create_tween()
	tween.tween_property(camera_3d, "fov", 75, 0.4).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	tween.tween_interval(0.15)
	tween.tween_property(self, "global_position", computer_entry_point, 0.7).set_trans(Tween.TRANS_CUBIC)
	await tween.finished
	
	collision_shape_3d.disabled = false
	can_move = true
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
func _process(_delta: float) -> void:
	if ray_cast_3d.is_colliding():
		reticle_dim = false
		toggle_reticle_alpha()
		interact_overlay.visible = true
		
		var hit := ray_cast_3d.get_collider()
		if hit.is_in_group("Lamp"):
			if Input.is_action_just_pressed("Interact"):
				print("LAMP")
				#hit.get_parent().toggle_lamp()
		elif hit.is_in_group("Door"):
			print("door")
			if Input.is_action_just_pressed("Interact"):
				hit.get_parent().toggle_door()
		elif hit.is_in_group("LightSwitch"):
			if Input.is_action_just_pressed("Interact"):
				print(hit.get_parent())
				SignalManager.toggle_lights.emit(hit.get_parent())
		elif hit.is_in_group("Drawer"):
			if Input.is_action_just_pressed("Interact"):
				hit.get_parent().get_parent().toggle_drawer()
		elif hit.is_in_group("Cabinet"):
			if Input.is_action_just_pressed("Interact"):
				hit.get_parent().get_parent().toggle_cabinet()
		elif hit.is_in_group("Stove"):
			if Input.is_action_just_pressed("Interact"):
				hit.get_parent().get_parent().toggle_door()
		elif hit.is_in_group("Fridge"):
			if Input.is_action_just_pressed("Interact"):
				hit.get_parent().toggle_door()
		elif hit.is_in_group("Computer"):
			if Input.is_action_just_pressed("Interact"):
				hit.get_parent().use_computer(global_position)
	else:
		reticle_dim = true
		interact_overlay.visible = false
		toggle_reticle_alpha()
		
	if using_computer:
		if Input.is_action_just_pressed("exit"):
			stop_using_computer()


func _physics_process(delta: float) -> void:
	if !can_move:
		return
	# Gravity
	if not is_on_floor():
		velocity.y -= GRAVITY * delta

	# Movement input
	var input_dir = Input.get_vector("pan_left", "pan_right", "pan_up", "pan_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	#if direction != Vector3.ZERO:
		#velocity.x = direction.x * SPEED * position_curve.sample(delta)
		#velocity.z = direction.z * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#velocity.z = move_toward(velocity.z, 0, SPEED)
	if direction != Vector3.ZERO:
		move_progress = min(move_progress + delta * 2.5, 1.0)
	else:
		move_progress = max(move_progress - delta * 3.5, 0.0)
		
	var speed_mult := position_curve.sample(move_progress)

	velocity.x = direction.x * SPEED * speed_mult
	velocity.z = direction.z * SPEED * speed_mult

	move_and_slide()
