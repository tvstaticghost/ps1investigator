extends Panel

@onready var confirmation_box: Panel = $ConfirmationBox
@onready var purchase_label: Label = $ConfirmationBox/PurchaseLabel

@export var flashlight_price: float = 10.00
@export var lock_price: float = 30.00
@export var motion_light_price: float = 25.00
@export var security_camera_price: float = 50.00

var window_flash_speed: float = 0.05
var current_item: GameManager.ITEMS
var current_price: float

var can_select: bool = true

func flash_confirmation():
	var tween = create_tween()
	for i in range(2):
		tween.tween_property(confirmation_box, "self_modulate:a", 0.8, window_flash_speed)
		tween.tween_property(confirmation_box, "self_modulate:a", 1.0, window_flash_speed)

#Use the game manager to purchase items and spawn truck
func render_confirmation(item: String, price: float):
	confirmation_box.visible = true
	purchase_label.text = "Purchase %s for $%d.00" % [item.capitalize(), price]
	can_select = false

func _on_buy_flash_light_button_pressed() -> void:
	if can_select:
		render_confirmation("flashlight", flashlight_price)
		current_item = GameManager.ITEMS.FLASHLIGHT
		current_price = flashlight_price
	else:
		flash_confirmation()

func _on_buy_door_lock_button_pressed() -> void:
	if can_select:
		render_confirmation("doorlock", lock_price)
		current_item = GameManager.ITEMS.DOORLOCK
		current_price = lock_price
	else:
		flash_confirmation()

func _on_buy_motion_light_button_pressed() -> void:
	if can_select:
		render_confirmation("motionlight", motion_light_price)
		current_item = GameManager.ITEMS.MOTIONLIGHT
		current_price = motion_light_price
	else:
		flash_confirmation()

func _on_buy_camera_button_pressed() -> void:
	if can_select:
		render_confirmation("camera", security_camera_price)
		current_item = GameManager.ITEMS.CAMERA
		current_price = security_camera_price
	else:
		flash_confirmation()


func _on_cancel_button_pressed() -> void:
	confirmation_box.visible = false
	can_select = true


func _on_buy_button_pressed() -> void:
	if GameManager.amount_of_money >= current_price:
		print("You are able to buy %s for %d.00" % [current_item, current_price])
		GameManager.spend_money(current_price)
		GameManager.purchase_item(current_item)
	else:
		print("Not enought money to buy %s for %d.00" % [current_item, current_price])
		
	confirmation_box.visible = false
	can_select = true
