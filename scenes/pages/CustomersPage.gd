extends Control

@onready var customer_tree: Tree = $MarginContainer/MainLayout/CustomerTree
@onready var search_input: LineEdit = $MarginContainer/MainLayout/SearchInput

@onready var add_button: Button = $MarginContainer/MainLayout/TopBar/TopBarContent/ActionButtons/AddCustomerButton
@onready var edit_button: Button = $MarginContainer/MainLayout/TopBar/TopBarContent/ActionButtons/EditButton
@onready var delete_button: Button = $MarginContainer/MainLayout/TopBar/TopBarContent/ActionButtons/DeleteButton
@onready var back_button: Button = $MarginContainer/MainLayout/TopBar/TopBarContent/BackButton

@onready var dialog = preload("res://scenes/dialogs/CustomerDialog.tscn").instantiate()

var selected_customer_id: int = -1

func _ready():
	add_child(dialog)
	setup_tree()
	connect_signals()
	load_customers()
	
func setup_tree():
	customer_tree.columns = 4
	customer_tree.hide_root = true

	customer_tree.set_column_title(0, "ID")
	customer_tree.set_column_title(1, "Contact")
	customer_tree.set_column_title(2, "Phone")
	customer_tree.set_column_title(3, "Email")

func load_customers():

	customer_tree.clear()

	var root = customer_tree.create_item()

	var customers = CustomerService.get_customers()

	for c in customers:

		var item = customer_tree.create_item(root)

		item.set_text(0, str(c["id"]))
		item.set_text(1, c["contact_person"])
		item.set_text(2, c["phone"])
		item.set_text(3, c["email"])

		item.set_metadata(0, c["id"])

func connect_signals():

	add_button.pressed.connect(_on_add_pressed)
	edit_button.pressed.connect(_on_edit_pressed)
	delete_button.pressed.connect(_on_delete_pressed)
	back_button.pressed.connect(_on_back_pressed)
	
	customer_tree.item_selected.connect(_on_item_selected)
	dialog.customer_saved.connect(load_customers)
	search_input.text_changed.connect(_on_search_changed)

func _on_item_selected():

	var item = customer_tree.get_selected()

	if item:
		selected_customer_id = item.get_metadata(0)

func _on_add_pressed():
	dialog.open_add()

func _on_delete_pressed():

	if selected_customer_id == -1:
		return

	CustomerService.delete_customer(selected_customer_id)

	selected_customer_id = -1

	load_customers()

func _on_edit_pressed():

	if selected_customer_id == -1:
		return

	var customers = CustomerService.get_customers()

	for c in customers:
		if c["id"] == selected_customer_id:
			dialog.open_edit(c)
			break

func _on_back_pressed():

	get_tree().change_scene_to_file("res://scenes/pages/Dashboard.tscn")

func _on_search_changed(text: String):

	if text.strip_edges() == "":
		load_customers()
		return

	load_filtered_customers(text)

func load_filtered_customers(search_text: String):

	customer_tree.clear()

	var root = customer_tree.create_item()

	var customers = CustomerService.search_customers(search_text)

	for c in customers:

		var item = customer_tree.create_item(root)

		item.set_text(0, str(c["id"]))
		item.set_text(1, c["company_name"] + " (" + c["contact_person"] + ")")
		item.set_text(2, c["phone"])
		item.set_text(3, c["email"])

		item.set_metadata(0, c["id"])
