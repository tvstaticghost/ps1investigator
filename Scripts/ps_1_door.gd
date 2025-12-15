extends Node3D

var door_open: bool = false
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func toggle_door():
	if door_open:
		animation_player.play("close_door")
	else:
		animation_player.play("open_door")
	door_open = !door_open
