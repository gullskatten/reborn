class_name CollectableResource
extends Node2D

onready var resourceCollectArea := $ResourceCollectArea
onready var stats = $ResourceStats
onready var labelController = $LabelController
var default = preload("res://assets/ui/cursors/cursor.png")

export var onMouseHoverCursor: Texture = load("res://assets/ui/cursors/cursor_collect_tree.png")
export var isTargetable: bool = true
const DeathEffect = preload("res://structures/effects/GrassEffect.tscn")
const IncreaseLabel = preload("res://ui/SmallLabel.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TargetButton_mouse_entered():
	if CurrentTarget.has_worker_targets():
		Input.set_custom_mouse_cursor(onMouseHoverCursor, 0, Vector2(0,0))


func _on_TargetButton_mouse_exited():
	Input.set_custom_mouse_cursor(default, 0, Vector2(0,0))


func _on_TargetButton_pressed():
	if isTargetable and not CurrentTarget.has_targets():
		CurrentTarget.set_target($TargetButton/TargetInfo)


func _on_ResourceStats_no_resource_left():
	queue_free()
	var d = DeathEffect.instance()
	get_parent().add_child(d)
	d.global_position = global_position + Vector2(0, -20)


func _on_ResourceStats_resource_changed(valueChanged):
	if stats != null:
			var increaseLabel = IncreaseLabel.instance()
			increaseLabel.text = "+" + str(valueChanged)
			increaseLabel.visible = true
			increaseLabel.add_color_override("font_color", Color.mediumseagreen)
			labelController.add_child(increaseLabel)
			var tween = get_node("Tween")
			tween.interpolate_property(increaseLabel, "rect_position",
				Vector2(0, floor(rand_range(10, 20))), Vector2(floor(rand_range(-10, 10)), 0), 1.2,
				Tween.TRANS_LINEAR, 0)
			tween.start()
			tween.connect("tween_all_completed", increaseLabel, "queue_free")
