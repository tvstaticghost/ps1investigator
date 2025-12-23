extends Panel

@onready var back_container: Panel = $AppBody/ScrollContainer/ResultsContainer/BackContainer
@onready var first_name_field: LineEdit = $AppBody/SearchContainer/FirstNameField
@onready var last_name_field: LineEdit = $AppBody/SearchContainer/LastNameField
@onready var results_container: VBoxContainer = $AppBody/ScrollContainer/ResultsContainer
@onready var search_container: VBoxContainer = $AppBody/SearchContainer
const PLAIN_PANEL = preload("uid://deffa1arcr72g")
const GRAY_PANEL = preload("uid://bdliv6sd1rqmn")

const CRIMINAL_RECORDS_APP = preload("uid://d4de1kekhdg4m")
const BACKOPTIONS = preload("uid://c8eulcvg7i8il")

var gray: bool = true

func _ready() -> void:
	search_container.visible = true
	results_container.visible = false
	back_container.visible = false

func toggle_menus():
	results_container.visible = !results_container.visible
	search_container.visible = !search_container.visible
	back_container.visible = !back_container.visible
	
func clear_search_results():
	for child in results_container.get_children():
		if child.is_in_group("BackOption"):
			continue
		else:
			child.queue_free()

func _on_submit_button_pressed() -> void:
	toggle_menus()
	clear_search_results()
	
	var results = Databases.find_person(first_name_field.text, last_name_field.text)
	for result in results:
		var box = HBoxContainer.new()
		var pan = Panel.new()
		pan.custom_minimum_size.y = 60.0
		results_container.add_child(pan)
		pan.add_child(box)
		pan.theme = PLAIN_PANEL
		if gray:
			pan.theme = GRAY_PANEL
		else:
			pan.theme = PLAIN_PANEL
		gray = !gray
		
		var first_label = Label.new()
		first_label.size = pan.size
		first_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		first_label.text = result["first"].capitalize() + " " + result["last"].capitalize() + "\n"
		first_label.text += "Charges: " + result["crime"].capitalize()
		first_label.theme = CRIMINAL_RECORDS_APP
		
		var mugshot_btn = Button.new()
		mugshot_btn.theme = BACKOPTIONS
		mugshot_btn.text = "Record"
		mugshot_btn.size_flags_horizontal = Control.SIZE_EXPAND
		
		#pan.add_child(first_label)
		#pan.add_child(mugshot_btn)
		box.add_child(first_label)
		box.add_child(mugshot_btn)
		

func _on_close_button_pressed() -> void:
	print("Closing application")
	if visible:
		visible = false
		gray = true

func _on_minimize_button_pressed() -> void:
	print("Minimize application")

func _on_button_pressed() -> void:
	toggle_menus()
