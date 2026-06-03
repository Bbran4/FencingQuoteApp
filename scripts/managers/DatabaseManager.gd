extends Node

var db : SQLite


func _ready():
	initialize_database()


func initialize_database():
	db = SQLite.new()

	db.path = "user://fenceflow.db"

	var opened = db.open_db()

	if opened:
		print("Database opened successfully.")
		create_tables()
	else:
		push_error("Failed to open database.")

func create_tables():

	var customers_table = """
    CREATE TABLE IF NOT EXISTS customers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        company_name TEXT NOT NULL,
        contact_person TEXT,
        phone TEXT,
        email TEXT,
        address TEXT,
        created_at TEXT
    );
    """

	db.query(customers_table)

	print("Customers table created.")
