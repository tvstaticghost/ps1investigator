extends Node

var inventory = {
	0: {
		"Obtained": false
	},
	1: {
		"Obtained": false,
		"Amount": 0
	},
	2: {
		"Obtained": false,
		"Amount": 0
	},
	3: {
		"Obtained": false,
		"Amount": 0
	},
}

func _ready() -> void:
	SignalManager.add_item_to_inventory.connect(add_item)

func add_item(item: GameManager.ITEMS):
	print("Added %s to my inventory!" % item)
	if inventory[item]["Obtained"] == false:
		inventory[item]["Obtained"] = true
		print("You have an %s for the first time" % item)
	else:
		print("You have an additional %s" % item)
	
	if item != 0:
		inventory[item]["Amount"] += 1
