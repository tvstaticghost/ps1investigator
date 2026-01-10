extends RigidBody3D

@onready var collision_shape_3d: CollisionShape3D = $Area3D/CollisionShape3D

@onready var rigid_body_3d: StaticBody3D = $RigidBody3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var opened: bool = false

func open_box():
	if !opened:
		animation_player.play("open_box")
		opened = true
		rigid_body_3d.add_to_group("Item")
		collision_shape_3d.disabled = true

func despawn_box():
	if rigid_body_3d.is_in_group("Lock"):
		SignalManager.add_item_to_inventory.emit(GameManager.ITEMS.DOORLOCK)
	elif rigid_body_3d.is_in_group("MotionLight"):
		SignalManager.add_item_to_inventory.emit(GameManager.ITEMS.MOTIONLIGHT)
	elif rigid_body_3d.is_in_group("Flashlight"):
		SignalManager.add_item_to_inventory.emit(GameManager.ITEMS.FLASHLIGHT)
	elif rigid_body_3d.is_in_group("Camera"):
		SignalManager.add_item_to_inventory.emit(GameManager.ITEMS.CAMERA)
	
	queue_free()
