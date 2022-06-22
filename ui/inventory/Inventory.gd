extends Control

const SlotClass = preload("res://ui/inventory/Slot.gd")
onready var inventory_slots = $MarginContainer/CenterContainer/GridContainer


func _ready():
	for inv_slot in inventory_slots.get_children():
		inv_slot.connect("gui_input", self, "slot_gui_input", [inv_slot])

func slot_gui_input(event: InputEvent, slot: SlotClass):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.pressed:
			var item = find_parent("Interface").holding_item
			if item != null:
				if !slot.item:
					slot.putIntoSlot(item)
					find_parent("Interface").holding_item = null
			else:
				var temp_item = slot.item
				slot.pickFromSlot()
				temp_item.global_position = event.global_position
				slot.putIntoSlot(item)
				find_parent("Interface").holding_item = temp_item

func _input(event):
	var item = find_parent("Interface").holding_item
	if item:
		item.global_position = get_global_mouse_position()
		

