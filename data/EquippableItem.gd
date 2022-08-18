extends SellableItem
class_name EquippableItem

export var item_level := 1
export var req_level := 1
export(Resource) var stats = EquipmentItemStats.new()
export(Texture) var equipment_texture : Texture

func _ready():
	pass # Replace with function body.
