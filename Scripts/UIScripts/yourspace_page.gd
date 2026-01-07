extends Panel

@onready var first_name_field: LineEdit = $FirstNameField
@onready var last_name_field: LineEdit = $LastNameField

func _on_search_button_pressed() -> void:
	print("Search for %s %s" % [first_name_field.text, last_name_field.text])
