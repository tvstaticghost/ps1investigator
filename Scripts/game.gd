extends Node3D

@onready var desktop: Control = $CanvasLayer/Desktop

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.view_desktop.connect(toggle_desktop)
	SignalManager.exit_desktop.connect(hide_desktop)
	
func toggle_desktop():
	desktop.visible = true

func hide_desktop():
	desktop.visible = false
