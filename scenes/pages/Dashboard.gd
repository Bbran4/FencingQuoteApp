extends Control

@onready var customers_button = $MarginContainer/MainLayout/ModuleGrid/CustomersButton
@onready var products_button = $MarginContainer/MainLayout/ModuleGrid/ProductsButton
@onready var quotations_button = $MarginContainer/MainLayout/ModuleGrid/QuotationsButton
@onready var templates_button = $MarginContainer/MainLayout/ModuleGrid/TemplatesButton

func _ready():

	customers_button.pressed.connect(_on_customers_pressed)
	products_button.pressed.connect(_on_products_pressed)
	quotations_button.pressed.connect(_on_quotations_pressed)
	templates_button.pressed.connect(_on_templates_pressed)

func _on_customers_pressed():
	get_tree().change_scene_to_file("res://scenes/pages/CustomersPage.tscn")

func _on_products_pressed():
	print("Products module not built yet")

func _on_quotations_pressed():
	print("Quotations module not built yet")

func _on_templates_pressed():
	print("Templates module not built yet")
