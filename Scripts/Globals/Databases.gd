extends Node

var people = [
	{"first": "bob", "last": "livingston", "crime": "shoplifting", "id": 1},
	{"first": "karen", "last": "lawrence", "crime": "shoplifting", "id": 2},
	{"first": "bob", "last": "saffron", "crime": "arsen", "id": 3},
]

var emails = {
	"inbox": [
		{"sender": "Person 1", "subject": "test subject", "date": "12-12-2025", "from": "Person One <person1@gmail.com>",  "to": "player@gmail.com", "message": "This is a test email to see if my container is actually scrollable. If it is not scrollable I will be very sad. It takes so long to create UI that doesn't look like utter dog shit in Godot that I am getting a little frustrated. Maybe I should start working on the assets and logic instead to take a break."},
		{"sender": "Person 2", "subject": "sup bitch", "date": "12-13-2025","from": "Person Two <person2@gmail.com>", "to": "player@gmail.com", "message": "Whats up little bitch! Need you to find some info about this person for me... 500 $$$"}
	],
	"deleted": [
		{"sender": "the killer", "subject": "so...", "date": "12-13-2025","from": "the killer <thekiller@gmail.com>", "to": "player@gmail.com", "message": "Dear Player,\n I'm gonna have to kill you dude. Nothing personal..."}
	]
}

var mugshots = {
	1: {"name": "bob livingston", "dob": "10-18-1954", "crime": "shoplifting"},
	2: {}
}

func find_person(first_name: String, last_name: String):
	var target_people = []
	for person in people:
		var first = first_name.to_lower() == "" or first_name.to_lower() == person["first"]
		var last = last_name.to_lower() == "" or last_name.to_lower() == person["last"]
		
		if first and last:
			target_people.append(person)
	
	return target_people

func get_inbox_emails():
	print(emails["inbox"])
	return emails["inbox"]

func get_deleted_emails():
	print(emails["deleted"])
	return emails["deleted"]
