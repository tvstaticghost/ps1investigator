extends Node

func receive_email(sender: String, subject: String, date: String, from: String, to: String, message: String):
	Databases.emails["inbox"].append({"sender": sender, "subject": subject, "date": date, "from": from, "to": to, "message": message})
