extends Control

@onready var loading_timer: Timer = $InternetBrowser/LoadingTimer
@onready var loading_panel: Panel = $InternetBrowser/LoadingPanel
@onready var loading_bar: ProgressBar = $InternetBrowser/LoadingBar

@onready var url: Label = $InternetBrowser/Url

@onready var scroll_container: ScrollContainer = $InternetBrowser/ScrollContainer

@onready var store_page: Panel = $InternetBrowser/ScrollContainer/StorePage
@onready var yourspace_page: Panel = $InternetBrowser/ScrollContainer/YourspacePage

var default_size: Vector2
var default_pos: Vector2

var page_load_amount: float = 50.0
var loading_step_amount: float

func _ready() -> void:
	url.text = "https://safehouse.com/store"
	
	default_size = loading_panel.size
	default_pos = loading_panel.position
	
	loading_step_amount = 1 / (loading_panel.size.y / page_load_amount) # About 11 percent progress each increment
	loading_bar.value = 0
	
func load_page():
	reset_loading_panel()
	loading_timer.start()
	loading_bar.value = 0
	
func reset_loading_panel():
	loading_panel.size = default_size
	loading_panel.position = default_pos

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
		
func hide_all_pages():
	for child in scroll_container.get_children():
		child.visible = false

func _on_safe_house_shortcut_pressed() -> void:
	hide_all_pages()
	store_page.visible = true
	load_page()

func _on_your_space_shortcut_pressed() -> void:
	hide_all_pages()
	yourspace_page.visible = true
	load_page()
