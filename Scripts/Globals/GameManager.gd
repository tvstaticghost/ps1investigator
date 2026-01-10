extends Node

enum ITEMS {FLASHLIGHT, MOTIONLIGHT, DOORLOCK, CAMERA}

var amount_of_money: float = 300.0

var purchased_items = []
var delivery_in_progress: bool = false

var delivery_timer: Timer
var delivery_timer_wait_time = 1.5

func _ready() -> void:
	delivery_timer = Timer.new()
	add_child(delivery_timer)
	delivery_timer.wait_time = delivery_timer_wait_time
	delivery_timer.timeout.connect(_on_delivery_timer_timeout)
	
	SignalManager.stop_truck.connect(start_delivery_timer)
	SignalManager.despawn_truck.connect(despawn_truck)

func add_money(amount: float):
	amount_of_money += amount
	
func spend_money(amount: float):
	if amount > amount_of_money:
		print("not enough money for purchase")
		return
	else:
		amount_of_money -= amount
		
func purchase_item(item: ITEMS):
	print("You have purchased %s" % item)
	purchased_items.append(item)
	if !delivery_in_progress:
		delivery_in_progress = true
		SignalManager.start_delivery.emit()
		
func delivery_packages():
	var offset_amount := 0.0

	for i in purchased_items.size():
		SignalManager.spawn_package.emit(purchased_items[i], offset_amount)

		if i % 2 == 1:
			offset_amount += 0.8
		
	purchased_items.clear()
		
func despawn_truck():
	delivery_in_progress = false
	
func start_delivery_timer():
	delivery_timer.start()
	
func _on_delivery_timer_timeout():
	delivery_packages()
	delivery_timer.stop()

func receive_email(sender: String, subject: String, date: String, from: String, to: String, message: String):
	Databases.emails["inbox"].append({"sender": sender, "subject": subject, "date": date, "from": from, "to": to, "message": message})
