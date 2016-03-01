require_relative "./_configure"

require_relative "./_configure"

DB.define_table("users")
DB.define_column("users", "name", "string")
DB.define_column("users", "email", "string")
DB.define_column("users", "password", "string")
DB.define_column("users", "created_by", "integer")
DB.define_column("users", "updated_by", "integer")


DB.define_table("buildings")
DB.define_column("buildings", "address", "string")
DB.define_column("buildings", "user_id", "integer")
DB.define_column("buildings", "landlord_name", "string")
DB.define_column("buildings", "building_image", "string")
DB.define_column("buildings", "move_in", "date")
DB.define_column("buildings", "move_out", "date")
DB.define_column("buildings", "created_by", "integer")
DB.define_column("buildings", "updated_by", "integer")

DB.define_table("rooms")
DB.define_column("rooms", "title", "string")
DB.define_column("rooms", "room_image", "string")
DB.define_column("rooms", "building_id", "integer")
DB.define_column("rooms", "created_by", "integer")
DB.define_column("rooms", "updated_by", "integer")

DB.define_table("items")
DB.define_column("items", "title", "string")
DB.define_column("items", "description", "string")
DB.define_column("items", "room_id", "integer")
DB.define_column("items", "created_by", "integer")
DB.define_column("items", "updated_by", "integer") 

DB.define_table("photos")
DB.define_column("photos", "item_id", "string")
DB.define_column("photos", "image", "string")
DB.define_column("photos", "created_by", "integer")
DB.define_column("photos", "updated_by", "integer")