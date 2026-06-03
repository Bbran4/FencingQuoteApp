extends Window

signal customer_saved

var editing_id: int = -1

func _ready():

	clear_form()

	$MarginContainer/MainLayout/ButtonRow/SaveButton.pressed.connect(_on_save_button_pressed)
	$MarginContainer/MainLayout/ButtonRow/CancelButton.pressed.connect(_on_cancel_button_pressed)

func open_add():
	editing_id = -1
	$MarginContainer/MainLayout/TitleLabel.text = "Add Customer"
	clear_form()
	popup_centered()

func open_edit(customer: Dictionary):
	editing_id = customer["id"]

	$MarginContainer/MainLayout/TitleLabel.text = "Edit Customer"

	$MarginContainer/MainLayout/CompanyInput.text = customer["company_name"]
	$MarginContainer/MainLayout/ContactInput.text = customer["contact_person"]
	$MarginContainer/MainLayout/PhoneInput.text = customer["phone"]
	$MarginContainer/MainLayout/EmailInput.text = customer["email"]
	$MarginContainer/MainLayout/AddressInput.text = customer["address"]

	popup_centered()

func clear_form():

	$MarginContainer/MainLayout/CompanyInput.text = ""
	$MarginContainer/MainLayout/ContactInput.text = ""
	$MarginContainer/MainLayout/PhoneInput.text = ""
	$MarginContainer/MainLayout/EmailInput.text = ""
	$MarginContainer/MainLayout/AddressInput.text = ""

func _on_save_button_pressed():

	var data = {
		"company_name": $MarginContainer/MainLayout/CompanyInput.text,
		"contact_person": $MarginContainer/MainLayout/ContactInput.text,
		"phone": $MarginContainer/MainLayout/PhoneInput.text,
		"email": $MarginContainer/MainLayout/EmailInput.text,
		"address": $MarginContainer/MainLayout/AddressInput.text
	}

	if editing_id == -1:
		CustomerService.add_customer(data)
	else:
		CustomerService.update_customer(editing_id, data)

	emit_signal("customer_saved")
	hide()

func _on_cancel_button_pressed():
	hide()
