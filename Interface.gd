extends CanvasLayer

onready var inventory = $Inventory
onready var character = $CharacterInspect

var holding_item : InventoryItem

func _ready():
	PlayerInventory.connect("updated_holding_item", self, "set_holding_item")

func set_holding_item(item):
	print(item)
	if !holding_item:
		holding_item = item
	if item == null:
		holding_item.queue_free()
		holding_item = null
	
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		inventory.visible = false
		character.visible = false
		CurrentTarget.cancel_targets()

	if event.is_action_pressed("inventory"):
		inventory.visible = !inventory.visible
	if event.is_action_pressed("character"):
		character.visible = !character.visible
