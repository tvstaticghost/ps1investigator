extends Node

enum ITEMS {FLASHLIGHT, MOTIONLIGHT, DOORLOCK, CAMERA}

var amount_of_money: float = 50.0

var purchased_items = []
var delivery_in_progress: bool = false

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

func receive_email(sender: String, subject: String, date: String, from: String, to: String, message: String):
	Databases.emails["inbox"].append({"sender": sender, "subject": subject, "date": date, "from": from, "to": to, "message": message})
