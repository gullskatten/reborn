extends CanvasLayer

onready var inventory = $Inventory
onready var character = $CharacterInspect

var holding_item = null

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		inventory.visible = false
		character.visible = false
		CurrentTarget.cancel_targets()
		GlobalCameraSettings.set_world_gui_input_disabled(false)
	if event.is_action_pressed("inventory"):
		inventory.visible = !inventory.visible
		GlobalCameraSettings.set_world_gui_input_disabled(inventory.visible)
	if event.is_action_pressed("character"):
		character.visible = !character.visible
		GlobalCameraSettings.set_world_gui_input_disabled(character.visible)
	
	
