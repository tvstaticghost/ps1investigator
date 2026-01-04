extends Node3D

@onready var desktop: Control = $CanvasLayer/Desktop

@onready var awfulanimation: Node3D = $awfulanimation
@onready var awfulrunning: Node3D = $awfulrunning


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.view_desktop.connect(toggle_desktop)
	SignalManager.exit_desktop.connect(hide_desktop)
	
	#Delete this shit later
	awfulrunning.scale = awfulanimation.scale
	awfulrunning.position = awfulanimation.position
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("run"):
		awfulrunning.visible = true
		awfulanimation.visible = false
		
		#awfulrunning.rotation.y = 87.8
		
		awfulrunning.running = true
		
	if Input.is_action_just_pressed("light_off"):
		SignalManager.power_out.emit()
		
	if Input.is_action_just_pressed("light_on"):
		SignalManager.power_on.emit()
	
func toggle_desktop():
	desktop.visible = true

func hide_desktop():
	desktop.visible = false
