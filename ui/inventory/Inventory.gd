extends Control

const SlotClass = preload("res://ui/inventory/Slot.gd")
onready var inventory_slots = $MarginContainer/CenterContainer/GridContainer

var root_interface_node = null

func _ready():
	root_interface_node = get_tree().root.get_node("/root/World/Main/GUI/Interface")
	var slots = inventory_slots.get_children()
	for i in range(slots.size()):
		slots[i].connect("gui_input", self, "slot_gui_input", [slots[i]])
		slots[i].slot_index = i
		slots[i].slotType = SlotClass.SlotType.INVENTORY
	initialize_inventory()
	

func initialize_inventory():
	var slots = inventory_slots.get_children()
	for i in range(slots.size()):
		if PlayerInventory.inventory.has(i):
			slots[i].initialize_item(PlayerInventory.inventory[i][0], PlayerInventory.inventory[i][1])

func slot_gui_input(event: InputEvent, slot: SlotClass):
		if event is InputEventMouseButton:
			if event.button_index == BUTTON_LEFT && event.pressed:
				print("Wowow")
				get_tree().set_input_as_handled()
				var holding_item = root_interface_node.holding_item
				if holding_item != null:
					if !slot.item:
						left_click_empty_slot(slot)
					else:
						if holding_item.item.id != slot.item.item.id:
							left_click_different_item(event, slot)
						else:
							left_click_same_item(slot)
				elif slot.item:
					left_click_not_holding(slot)

func _input(event):
	var holding_item = root_interface_node.holding_item
	if holding_item:
		holding_item.global_position = get_global_mouse_position()
		
func left_click_empty_slot(slot: SlotClass):
	var holding_item = root_interface_node.holding_item
	PlayerInventory.add_item_to_empty_slot(holding_item, slot)
	slot.putIntoSlot(holding_item)
	root_interface_node.holding_item = null

func left_click_different_item(event: InputEvent, slot: SlotClass):
		var holding_item = root_interface_node.holding_item
		PlayerInventory.remove_item(slot)
		PlayerInventory.add_item_to_empty_slot(holding_item, slot)
		var temp_item = slot.item
		slot.pickFromSlot()
		temp_item.global_position = event.global_position
		slot.putIntoSlot(holding_item)
		root_interface_node.holding_item = temp_item

func left_click_same_item(slot: SlotClass):
		var stack_size = int(slot.item.item["stacksize"])
		var able_to_add = stack_size - slot.item.item_quantity
		var holding_item = root_interface_node.holding_item
		if able_to_add >= holding_item.item_quantity:
			PlayerInventory.add_item_quantity(slot, holding_item.item_quantity)
			slot.item.add_item_quantity(holding_item.item_quantity)
			root_interface_node.holding_item.queue_free()
			root_interface_node.holding_item = null
		else:
			PlayerInventory.add_item_quantity(slot, able_to_add)
			slot.item.add_item_quantity(able_to_add)
			root_interface_node.holding_item.decrease_item_quantity(able_to_add)
		
func left_click_not_holding(slot: SlotClass):
	PlayerInventory.remove_item(slot)
	root_interface_node.holding_item = slot.item
	slot.pickFromSlot()
	root_interface_node.holding_item.global_position = get_global_mouse_position()

