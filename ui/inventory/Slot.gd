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

func _ready():
	default_style = StyleBoxTexture.new()
	empty_style = StyleBoxTexture.new()
	selected_style = StyleBoxTexture.new()
	default_style.texture = default_tex
	empty_style.texture = empty_tex
	selected_style.texture = selected_tex

	refresh_style()
	
	PlayerInventory.connect("item_placed", self, "check_item_placement")
	

func check_item_placement(idx, internal_item, quantity):
	if slot_index != idx: return
	
	if item != null:
		# Updates the internal item in the item class
		item.set_item(internal_item, quantity)
	else:
		# Initializes a new instance of item class (visual)
		initialize_item(internal_item, quantity)
	
	
func refresh_style():
	if slotType == SlotType.HOTBAR and PlayerInventory.active_item_slot == slot_index:
		set('custom_styles/panel', selected_style)
	elif item == null:
		set('custom_styles/panel', empty_style)
	else:
		set('custom_styles/panel', default_style)
	
func pickFromSlot():
	remove_child(item)
	PlayerInventory.set_holding_item(item)
	item = null
	refresh_style()
	
func putIntoSlot(new_item):
	item = new_item
	item.position = Vector2(0, 0)
	PlayerInventory.set_holding_item(null)
	add_child(item)
	refresh_style()
	
func initialize_item(new_item, item_quantity):
	item = ItemClass.instance()
	add_child(item)
	item.set_item(new_item, item_quantity)
	refresh_style()
