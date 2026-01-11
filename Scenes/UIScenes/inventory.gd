extends Control

@onready var flashlight_container: Panel = $InventoryContainer/FlashlightContainer
@onready var door_lock_container: Panel = $InventoryContainer/DoorLockContainer
@onready var motion_light_container: Panel = $InventoryContainer/MotionLightContainer
@onready var security_camera_container: Panel = $InventoryContainer/SecurityCameraContainer

@onready var lock_quan_label: Label = $InventoryContainer/DoorLockContainer/LockQuanLabel
@onready var cam_quan_label: Label = $InventoryContainer/SecurityCameraContainer/CamQuanLabel
@onready var light_quan_label: Label = $InventoryContainer/MotionLightContainer/LightQuanLabel

func _ready() -> void:
	SignalManager.update_inventory.connect(update_inv)
	update_inventory_amounts()

func update_inventory_amounts():
	lock_quan_label.text = "x%d" % Inventory.inventory[2]["Amount"]
	cam_quan_label.text = "x%d" % Inventory.inventory[3]["Amount"]
	light_quan_label.text = "x%d" % Inventory.inventory[1]["Amount"]
	
	door_lock_container.visible = Inventory.inventory[2]["Amount"] > 0
	motion_light_container.visible = Inventory.inventory[1]["Amount"] > 0
	security_camera_container.visible = Inventory.inventory[3]["Amount"] > 0
	flashlight_container.visible = Inventory.has_flashlight
	
func update_inv():
	update_inventory_amounts()

func _on_close_button_pressed() -> void:
	print("Closing inventory")
	visible = false
	SignalManager.enable_movement.emit()

func _on_door_lock_equip_button_pressed() -> void:
	print("equip the door lock")


func _on_motion_light_equip_button_pressed() -> void:
	print("equip the motion light")


func _on_camera_equip_button_pressed() -> void:
	print("equip the security camera")
