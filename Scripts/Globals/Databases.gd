extends Node

var people = [
	{"first": "bob", "last": "livingston", "crime": "shoplifting"},
	{"first": "karen", "last": "lawrence", "crime": "shoplifting"},
	{"first": "bob", "last": "saffron", "crime": "arsen"},
]

func find_person(first_name: String, last_name: String):
	var target_people = []
	for person in people:
		var first = first_name.to_lower() == "" or first_name.to_lower() == person["first"]
		var last = last_name.to_lower() == "" or last_name.to_lower() == person["last"]
		
		if first and last:
			target_people.append(person)
	
	return target_people
