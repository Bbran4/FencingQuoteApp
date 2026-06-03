extends Control


func _ready():

	var updated_data = {
		"company_name": "Updated Fence Company",
		"contact_person": "Brenden Updated",
		"phone": "0839999999",
		"email": "updated@email.com",
		"address": "Cape Town"
	}

	CustomerService.update_customer(2, updated_data)

	var customers = CustomerService.get_customers()

	print(customers)
