extends Panel

enum FOLDERS {INBOX, DELETED, SENT}

@onready var inbox_folder: Button = $PanelBackground/FolderPanel/Panel/InboxFolder
@onready var deleted_folder: Button = $PanelBackground/FolderPanel/Panel/DeletedFolder
@onready var email_info_container: VBoxContainer = $PanelBackground/EmailListPanel/ScrollContainer/EmailInfoContainer
@onready var sent_folder: Button = $PanelBackground/FolderPanel/Panel/SentFolder

@onready var subject_value: Label = $PanelBackground/TextEdit/WhiteBackground/VBoxContainer2/SubjectValue
@onready var date_value: Label = $PanelBackground/TextEdit/WhiteBackground/VBoxContainer2/DateValue
@onready var from_value: Label = $PanelBackground/TextEdit/WhiteBackground/VBoxContainer2/FromValue
@onready var to_value: Label = $PanelBackground/TextEdit/WhiteBackground/VBoxContainer2/ToValue
@onready var message_value: Label = $PanelBackground/TextEdit/WhiteBackground/ScrollContainer/MessageValue


const EMAIL_ITEM_SELECTED = preload("uid://8pdtbs20fgdk")
const EMAIL_UI = preload("uid://cjdgl7gqgqsxc")

var inbox_email_list = []

var current_folder: FOLDERS
var selected_email_button: Button = null

var hovering: bool = false

func _ready() -> void:
	current_folder = FOLDERS.INBOX
	
	inbox_folder.theme = EMAIL_ITEM_SELECTED
	
	#Example of receiving a new email
	GameManager.receive_email("zuko dipaolo", "ball", "12-15-2025", "zuko diapolo <zuko@gmail.com>", "player@gmail.com", "Let's go play ball right now!")
	
	generate_emails()
	
func _process(_delta: float) -> void:
	if hovering and Input.is_action_just_pressed("Select"):
		SignalManager.select_application.emit(self)
		
func clear_email_list():
	selected_email_button = null

	for child in email_info_container.get_children():
		email_info_container.remove_child(child)
		child.free()  # immediate destruction
		
	print(email_info_container.get_children())

	inbox_email_list = []
	
func generate_emails():
	clear_email_list()
	
	var inbox_emails
	if current_folder == FOLDERS.INBOX:
		inbox_emails = Databases.get_inbox_emails()
	elif current_folder == FOLDERS.SENT:
		inbox_emails = Databases.get_sent_emails()
	else:
		inbox_emails = Databases.get_deleted_emails()
		
	inbox_email_list = inbox_emails
	
	for email in inbox_emails:
		var new_email_info = Button.new()
		email_info_container.add_child(new_email_info)
		
		new_email_info.custom_minimum_size.y = 25.0
		new_email_info.theme = EMAIL_UI
		
		new_email_info.pressed.connect(
			_on_email_item_pressed.bind(new_email_info, email)
		)
		
		var sender_label = Label.new()
		new_email_info.add_child(sender_label)
		sender_label.text = email["sender"].capitalize()
		sender_label.position.x = 7.0
		
		var subject_label = Label.new()
		new_email_info.add_child(subject_label)
		subject_label.text = email["subject"].capitalize()
		subject_label.position.x = 179.0
	
	print(email_info_container.get_child_count())
	if email_info_container.get_child_count() > 0:
		var first_button := email_info_container.get_child(0) as Button
		var first_email = inbox_email_list[0]
		_on_email_item_pressed(first_button, first_email)
	
		
func _on_email_item_pressed(button: Button, email_data: Dictionary) -> void:
	# Unselect previous
	if selected_email_button and selected_email_button != button:
		selected_email_button.theme = EMAIL_UI

	# Select new
	selected_email_button = button
	selected_email_button.theme = EMAIL_ITEM_SELECTED

	# Optional: do something with the email
	print("Opened email from:", email_data["sender"])
	subject_value.text = email_data["subject"].capitalize()
	date_value.text = email_data["date"]
	from_value.text = email_data["from"].capitalize()
	to_value.text = email_data["to"]
	message_value.text = email_data["message"]

func _on_close_button_pressed() -> void:
	if visible:
		visible = false


func _on_minimize_button_pressed() -> void:
	print("Minimize email app")


func _on_inbox_label_pressed() -> void:
	deleted_folder.theme = EMAIL_UI
	sent_folder.theme = EMAIL_UI
	inbox_folder.theme = EMAIL_ITEM_SELECTED
	current_folder = FOLDERS.INBOX
	
	generate_emails()


func _on_deleted_folder_pressed() -> void:
	deleted_folder.theme = EMAIL_ITEM_SELECTED
	inbox_folder.theme = EMAIL_UI
	sent_folder.theme = EMAIL_UI
	current_folder = FOLDERS.DELETED
	
	generate_emails()
	
	
func _on_sent_folder_pressed() -> void:
	deleted_folder.theme = EMAIL_UI
	inbox_folder.theme = EMAIL_UI
	sent_folder.theme = EMAIL_ITEM_SELECTED
	current_folder = FOLDERS.SENT
	generate_emails()


func _on_mouse_entered() -> void:
	hovering = true

func _on_mouse_exited() -> void:
	hovering = false
