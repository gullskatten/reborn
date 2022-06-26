extends Panel

var default_tex = preload("res://assets/ui/inventory/inventory_slot_filled.png")
var empty_tex = preload("res://assets/ui/inventory/inventory_slot_empty.png")
var selected_tex = preload("res://assets/ui/inventory/inventory_slot_selected.png")

var default_style: StyleBoxTexture = null
var empty_style: StyleBoxTexture = null
var selected_style: StyleBoxTexture = null

var ItemClass = preload("res://ui/inventory/InventoryItem.tscn")
var item = null

var slot_index

enum SlotType {
	HOTBAR = 0,
	INVENTORY,
	HEAD,
	NECK,
	BACK,
	SHOULDER,
	CHEST,
	HANDS,
	BELT,
	LEGS,
	FEET,
	RING,
	MAIN_HAND,
	OFF_HAND
}

var slotType = null
var root_interface_node = null

func _ready():
	default_style = StyleBoxTexture.new()
	empty_style = StyleBoxTexture.new()
	selected_style = StyleBoxTexture.new()
	default_style.texture = default_tex
	empty_style.texture = empty_tex
	selected_style.texture = selected_tex

	refresh_style()
	root_interface_node = get_tree().root.get_node("/root/World/Main/GUI/Interface")

func refresh_style():
	if slotType == SlotType.HOTBAR and PlayerInventory.active_item_slot == slot_index:
		set('custom_styles/panel', selected_style)
	elif item == null:
		set('custom_styles/panel', empty_style)
	else:
		set('custom_styles/panel', default_style)
	
func pickFromSlot():
	remove_child(item)
	root_interface_node.add_child(item)
	item = null
	refresh_style()
	
func putIntoSlot(new_item):
	item = new_item
	item.position = Vector2(0, 0)
	root_interface_node.remove_child(item)
	add_child(item)
	refresh_style()
	
func initialize_item(new_item, item_quantity):
	item = ItemClass.instance()
	add_child(item)
	item.set_item(new_item, item_quantity)
	refresh_style()
