extends Panel

var default_tex = preload("res://assets/ui/inventory/inventory_slot_filled.png")
var empty_tex = preload("res://assets/ui/inventory/inventory_slot_empty.png")
var selected_tex = preload("res://assets/ui/inventory/inventory_slot_selected.png")

var default_style: StyleBoxTexture = null
var empty_style: StyleBoxTexture = null
var selected_style: StyleBoxTexture = null

var ItemClass = preload("res://ui/inventory/InventoryItem.tscn")
var item = null

func _ready():
	default_style = StyleBoxTexture.new()
	empty_style = StyleBoxTexture.new()
	selected_style = StyleBoxTexture.new()
	default_style.texture = default_tex
	empty_style.texture = empty_tex
	selected_style.texture = selected_tex
	if randi() % 2 == 0:
		item = ItemClass.instance()
		add_child(item)
	refresh_style()

func refresh_style():
	if item == null:
		set('custom_styles/panel', empty_style)
	else:
		set('custom_styles/panel', default_style)
	
func pickFromSlot():
	remove_child(item)
	print(find_parent("Interface"))
	find_parent("Interface").add_child(item)
	item = null
	refresh_style()
	
func putIntoSlot(new_item):
	item = new_item
	find_parent("Interface").remove_child(item)
	add_child(item)
	refresh_style()
