class_name CollectableResource
extends Node2D

export(String, "Wood", "Hay", "Stone") var resourceType = "Wood"

onready var resourceCollectArea := $ResourceCollectArea
onready var stats = $ResourceStats
onready var labelController = $LabelController
var default = preload("res://assets/ui/cursors/cursor.png")

export var onMouseHoverCursor: Texture = load("res://assets/ui/cursors/cursor_collect_tree.png")
export var resourceColor: Color = Color.mediumseagreen
export var isTargetable: bool = true
const IncreaseLabel = preload("res://ui/SmallLabel.tscn")

func _ready():
	pass # Replace with function body.

func _on_TargetButton_mouse_entered():
	if CurrentTarget.has_worker_targets():
		Input.set_custom_mouse_cursor(onMouseHoverCursor, 0, Vector2(0,0))


func _on_TargetButton_mouse_exited():
	Input.set_custom_mouse_cursor(default, 0, Vector2(0,0))


func _on_TargetButton_pressed():
	if isTargetable and not CurrentTarget.has_targets():
		CurrentTarget.set_target($TargetButton/TargetInfo)


func _on_ResourceStats_no_resource_left():
	print("Out of resources!")
	queue_free()


func _on_ResourceStats_resource_changed(valueChanged, _remaining):
	if stats != null:
		var increaseLabel = IncreaseLabel.instance()
		increaseLabel.text = "+" + str(valueChanged)
		increaseLabel.visible = true
		increaseLabel.add_color_override("font_color", resourceColor)
		increaseLabel.modulate = Color(0,0,0,0)
		labelController.add_child(increaseLabel)
		var tween = get_node("Tween")
		tween.interpolate_property(increaseLabel, "modulate",
			Color(resourceColor.r,resourceColor.g,resourceColor.b, 1), Color(resourceColor.r,resourceColor.g,resourceColor.b, 0), 1.0,
			Tween.TRANS_LINEAR, Tween.EASE_OUT)
		tween.interpolate_property(increaseLabel, "rect_position",
			Vector2(0, floor(rand_range(10, 20))), Vector2(floor(rand_range(-10, 10)), 0), 1.2,
			Tween.TRANS_LINEAR, 0)
		tween.start()
		
		tween.connect("tween_all_completed", increaseLabel, "queue_free")
