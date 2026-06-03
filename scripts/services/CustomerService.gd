extends Node


func add_customer(data: Dictionary) -> bool:

	var query = """
    INSERT INTO customers
    (
        company_name,
        contact_person,
        phone,
        email,
        address,
        created_at
    )
    VALUES
    (
        ?,
        ?,
        ?,
        ?,
        ?,
        datetime('now')
    );
    """

	var success = DatabaseManager.db.query_with_bindings(query, [
		data.company_name,
		data.contact_person,
		data.phone,
		data.email,
		data.address
	])

	return success

func get_customers() -> Array:

	var query = """
    SELECT * FROM customers
    ORDER BY company_name ASC;
    """

	DatabaseManager.db.query(query)

	return DatabaseManager.db.query_result

func delete_customer(customer_id: int) -> bool:

	var query = """
    DELETE FROM customers
    WHERE id = ?;
    """

	var success = DatabaseManager.db.query_with_bindings(query, [
		customer_id
	])

	return success

func update_customer(customer_id: int, data: Dictionary) -> bool:

	var query = """
    UPDATE customers
    SET
        company_name = ?,
        contact_person = ?,
        phone = ?,
        email = ?,
        address = ?
    WHERE id = ?;
    """

	var success = DatabaseManager.db.query_with_bindings(query, [
		data.company_name,
		data.contact_person,
		data.phone,
		data.email,
		data.address,
		customer_id
	])

	return success
