extends Node

signal open_application(application)
signal toggle_start_menu
signal select_application(application)
signal toggle_lights(scene)
signal ceiling_fan_on
signal ceiling_fan_off
signal sit_at_computer(chair_pos, left_point_pos, right_point_pos)
signal view_desktop
signal exit_desktop
signal power_out
signal power_on

#Store and Item signals
signal start_delivery
signal stop_truck
signal start_truck
signal despawn_truck
signal spawn_package
signal add_item_to_inventory
