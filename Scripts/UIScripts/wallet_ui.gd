extends Panel

@onready var label: Label = $Label

func _ready() -> void:
	var money = GameManager.amount_of_money
	label.text = "$ %d" % money


func _on_minimize_button_pressed() -> void:
	visible = false

func _on_exit_button_pressed() -> void:
	visible = false
