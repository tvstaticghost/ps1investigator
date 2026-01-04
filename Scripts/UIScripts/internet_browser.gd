extends Panel

@onready var loading_timer: Timer = $LoadingTimer
@onready var loading_panel: Panel = $LoadingPanel
@onready var loading_bar: ProgressBar = $LoadingBar

var page_load_amount: float = 50.0
var loading_step_amount: float

func _ready() -> void:
	loading_step_amount = 1 / (loading_panel.size.y / page_load_amount) # About 11 percent progress each increment
	loading_bar.value = 0

func _on_loading_timer_timeout() -> void:
	if loading_panel.size.y > 0:
		loading_panel.size.y -= page_load_amount
		loading_panel.position.y += page_load_amount
		loading_bar.value += loading_step_amount * 100
		loading_timer.start()
	else:
		print("Stopping loading")
		loading_bar.value = 0
		loading_timer.stop()
