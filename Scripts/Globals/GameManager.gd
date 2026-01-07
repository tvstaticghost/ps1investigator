extends Node

var amount_of_money: float = 0.0

func add_money(amount: float):
	amount_of_money += amount
	
func spend_money(amount: float):
	if amount > amount_of_money:
		print("not enough money for purchase")
		return
	else:
		amount_of_money -= amount

func receive_email(sender: String, subject: String, date: String, from: String, to: String, message: String):
	Databases.emails["inbox"].append({"sender": sender, "subject": subject, "date": date, "from": from, "to": to, "message": message})
