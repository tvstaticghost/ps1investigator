extends MeshInstance3D

var lamp_on: bool = true
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func toggle_lamp():
	lamp_on = !lamp_on
	if lamp_on:
		animation_player.play("lamp_off")
	else:
		animation_player.play("lamp_on")
