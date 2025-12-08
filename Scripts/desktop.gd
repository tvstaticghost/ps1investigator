extends Control

@onready var start_menu: Panel = $StartMenu

func _ready() -> void:
	SignalManager.open_application.connect(open_app)
	SignalManager.toggle_start_menu.connect(toggle_menu)
	
func toggle_menu():
	start_menu.visible = !start_menu.visible
	
func open_app(scene):
	print("Called open app")
	print(scene)
	
	print(scene.visible == false)
	if scene.visible == false:
		scene.visible = true
