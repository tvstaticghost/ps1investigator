extends Node3D

@onready var front_door_switch: MeshInstance3D = $FrontDoorLightSwitch/FrontDoorSwitch
@onready var front_door_light: MeshInstance3D = $FrontDoorLight
var front_door_energy_value: float = 0.605

@onready var livingroom_switch: MeshInstance3D = $LivingroomLightSwitch/LivingroomSwitch
@onready var ceilingfan_3: MeshInstance3D = $Ceilingfan3

@onready var bathroom_outside_switch: MeshInstance3D = $BathroomOutsideLightSwitch/BathroomOutsideSwitch
@onready var bathroom_outside_light: MeshInstance3D = $BathroomOutsideLight
var outside_bathroom_energy_value: float = 0.605

@onready var bathroom_switch: MeshInstance3D = $BathroomLightSwitch/BathroomSwitch
@onready var bathroom_light: MeshInstance3D = $BathroomLight
var bathroom_energy_value: float = 0.605

@onready var kitchen_switch: MeshInstance3D = $KitchenLightSwitch/KitchenSwitch
@onready var kitchen_ceiling_fan: MeshInstance3D = $KitchenCeilingFan
@onready var stove_light: MeshInstance3D = $StoveLight
@onready var kitchen_light: MeshInstance3D = $KitchenLight
var kitchen_light_energy: float = 0.605
var stove_light_energy: float = 1.0

@onready var bedroom_switch: MeshInstance3D = $BedroomLightSwitch/BedroomSwitch
@onready var bedroom_light: MeshInstance3D = $BedroomLight
@onready var bedroom_ceiling_fan: MeshInstance3D = $BedroomCeilingFan
var bedroom_energy_value: float = 0.605

@onready var ceilingfan_4: MeshInstance3D = $Ceilingfan4
@onready var reading_switch: MeshInstance3D = $ReadingLightSwitch/ReadingSwitch

var ceiling_fan_light_energy = 1.0
const GLOWLYSWITCH = preload("uid://dx6ja0yaqp0c4")

func _ready() -> void:
	SignalManager.toggle_lights.connect(toggle_light_switch)
	
func rotate_switch(switch):
	if switch.rotation.x == 0:
		switch.rotation.x = 90
		switch.set_surface_override_material(0, GLOWLYSWITCH)
	else:
		switch.rotation.x = 0
		switch.set_surface_override_material(0, null)
		
func toggle_light(light, energy_value: float):
	var om_light = light.get_child(0)
	if om_light.light_energy > 0.0:
		light.get_active_material(1).emission_enabled = false
		om_light.light_energy = 0.0
	else:
		om_light.light_energy = energy_value
		light.get_active_material(1).emission_enabled = true
		
func toggle_ceiling_fan(fan, energy_value: float):
	var om_light = fan.get_child(1)
	if om_light.light_energy > 0.0:
		om_light.light_energy = 0.0
		fan.get_active_material(1).emission_enabled = false
		fan.fan_off()
	else:
		om_light.light_energy = energy_value
		fan.get_active_material(1).emission_enabled = true
		fan.fan_on()

func toggle_light_switch(scene):
	if scene.is_in_group("FrontSwitch"):
		rotate_switch(front_door_switch)
		toggle_light(front_door_light, front_door_energy_value)
	elif scene.is_in_group("LivingroomSwitch"):
		rotate_switch(livingroom_switch)
		toggle_ceiling_fan(ceilingfan_3, ceiling_fan_light_energy)
	elif scene.is_in_group("BathroomOutsideSwitch"):
		rotate_switch(bathroom_outside_switch)
		toggle_light(bathroom_outside_light, outside_bathroom_energy_value)
	elif scene.is_in_group("BathroomSwitch"):
		rotate_switch(bathroom_switch)
		toggle_light(bathroom_light, bathroom_energy_value)
	elif scene.is_in_group("KitchenSwitch"):
		rotate_switch(kitchen_switch)
		toggle_light(stove_light, stove_light_energy)
		toggle_ceiling_fan(kitchen_ceiling_fan, ceiling_fan_light_energy)
		toggle_light(kitchen_light, kitchen_light_energy)
	elif scene.is_in_group("BedroomSwitch"):
		rotate_switch(bedroom_switch)
		toggle_light(bedroom_light, bedroom_energy_value)
		toggle_ceiling_fan(bedroom_ceiling_fan, ceiling_fan_light_energy)
	elif scene.is_in_group("ReadingSwitch"):
		rotate_switch(reading_switch)
		toggle_ceiling_fan(ceilingfan_4, ceiling_fan_light_energy)
