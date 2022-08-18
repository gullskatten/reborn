extends Node

const SlotClass = preload("res://ui/inventory/Slot.gd")
const ItemClass = preload("res://ui/inventory/InventoryItem.gd")
const NUM_INVENTORY_SLOTS = 36

var active_item_slot = 0

var inventory = {

}

func add_item(new_item, item_quantity) -> bool:
	if new_item == null:
		return false
	
	var slot_indices: Array = inventory.keys()
	slot_indices.sort()
	
	var has_added_to_quantity = false
	
	for index in slot_indices:
		if inventory[index][0]["id"] == new_item.id:
			var stack_size = int(inventory[index][0]["stacksize"])
			var able_to_add = stack_size - inventory[index][1]
			if able_to_add >= item_quantity:
				inventory[index][1] += item_quantity
				update_slot_visual(index, inventory[index][0], inventory[index][1])
				has_added_to_quantity = true
				break
			else:
				inventory[index][1] += able_to_add
				update_slot_visual(index, inventory[index][0], inventory[index][1])
				item_quantity = item_quantity - able_to_add
				
	if !has_added_to_quantity:
		if inventory.keys().size() == NUM_INVENTORY_SLOTS:
			Logger.error("My bag is full!")
			return false
			
		# item doesn't exist in inventory yet, so add it to an empty slot
		for i in range(NUM_INVENTORY_SLOTS):
			if inventory.has(i) == false:
				inventory[i] = [new_item, item_quantity]
				update_slot_visual(i, inventory[i][0], inventory[i][1])
				return true

	return has_added_to_quantity || false

func update_slot_visual(slot_index, item, new_quantity): 
	var slot = get_node("/root/World/Main/GUI/Interface/Inventory/MarginContainer/CenterContainer/GridContainer/Slot" + str(slot_index + 1))
	if slot.item != null:
		# Updates the internal item in the item class
		slot.item.set_item(item, new_quantity)
	else:
		# Initializes a new instance of item class (visual)
		slot.initialize_item(item, new_quantity)

func remove_item(slot: SlotClass):
	match slot.slotType:
		SlotClass.SlotType.INVENTORY:
			inventory.erase(slot.slot_index)
		_:
			print("Unable to remove item!")

func add_item_to_empty_slot(item: ItemClass, slot: SlotClass):
	match slot.slotType:
		SlotClass.SlotType.INVENTORY:
			inventory[slot.slot_index] = [item.item, item.item_quantity]
		_:
			print("Unable to add item to empty slot!")

func add_item_quantity(slot: SlotClass, quantity_to_add: int):
	match slot.slotType:
		SlotClass.SlotType.INVENTORY:
			inventory[slot.slot_index][1] += quantity_to_add
		_:
			print("Unable to add item quantity!")
