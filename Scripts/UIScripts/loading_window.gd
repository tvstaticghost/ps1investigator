extends Panel

@onready var cancel_button: Button = $CancelButton
@onready var done_button: Button = $DoneButton

@onready var loading_bar_hide_panel: Panel = $LoadingBarHidePanel

@onready var fade_out_done_panel: Panel = $FadeOutDonePanel
@onready var fade_out_cancel_panel: Panel = $FadeOutCancelPanel

@onready var loading_timer: Timer = $LoadingTimer

var load_amount: float = 10.0
var bar_size: Vector2
var bar_position: Vector2

func _ready() -> void:
	bar_size = loading_bar_hide_panel.size
	bar_position = loading_bar_hide_panel.position
	
	start_loading()
	done_button.disabled = true

func start_loading():
	loading_timer.wait_time = randf_range(0.5, 2.0)
	loading_timer.start()
	
func fully_loaded():
	print("Fully Loaded")
	fade_out_done_panel.visible = false
	done_button.disabled = false
	
	fade_out_cancel_panel.visible = true
	cancel_button.disabled = true
	
func reset_progress():
	loading_bar_hide_panel.size = bar_size
	loading_bar_hide_panel.position = bar_position
	start_loading()

func _on_loading_timer_timeout() -> void:
	if loading_bar_hide_panel.size.x > 0:
		loading_bar_hide_panel.size.x -= load_amount
		loading_bar_hide_panel.position.x += load_amount
		if loading_bar_hide_panel.size.x <= 0:
			loading_timer.stop()
			fully_loaded()
	else:
		loading_timer.stop()
		fully_loaded()

func _on_cancel_button_pressed() -> void:
	loading_timer.stop()
	visible = false

func _on_done_button_pressed() -> void:
	visible = false
