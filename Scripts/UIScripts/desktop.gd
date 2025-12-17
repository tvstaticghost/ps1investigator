extends Control

@onready var start_menu: Panel = $StartMenu
@onready var note_pad_ui: Panel = $NotePadUI
@onready var email_ui: Panel = $Email_UI
@onready var toolbar: Panel = $Toolbar

var hovered_app

var app_list = []

func _ready() -> void:
	app_list.append(note_pad_ui)
	app_list.append(email_ui)
	
	SignalManager.open_application.connect(open_app)
	SignalManager.toggle_start_menu.connect(toggle_menu)
	SignalManager.select_application.connect(select_app)
	
func toggle_menu():
	start_menu.visible = !start_menu.visible
	toolbar.set_pressed(start_menu.visible)
	
func open_app(scene):
	if scene.visible == false:
		scene.visible = true

func select_app(scene):
	if start_menu.visible:
		toggle_menu()
		
	scene.z_index = 3
	
	for app in app_list:
		if app != scene:
			app.z_index = 0
