extends Node2D

onready var sprite = $Sprite
onready var stats = $ResourceStats
onready var labelController = $LabelController

const DeathEffect = preload("res://structures/effects/GrassEffect.tscn")
const IncreaseLabel = preload("res://ui/SmallLabel.tscn")

func _ready():
	randomize()
	sprite.set_frame(floor(rand_range(0, 5)))

func _on_TargetButton_mouse_entered():
	
	if CurrentTarget.has_worker_targets():
		var collect_tree = load("res://assets/ui/cursors/cursor_collect_tree.png")
		Input.set_custom_mouse_cursor(collect_tree, 0, Vector2(0,0))

func _on_TargetButton_mouse_exited():
	var default = load("res://assets/ui/cursors/cursor.png")
	Input.set_custom_mouse_cursor(default, 0, Vector2(0,0))

func _on_TargetButton_pressed():
	stats.decrease_resource(25)
	if not CurrentTarget.has_targets():
		CurrentTarget.set_target($TargetButton/TargetInfo)


func _on_ResourceStats_resource_changed(valueChanged, resourceLeft):
		print(valueChanged)
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
		
func _on_ResourceStats_no_resource_left():
	queue_free()
	var d = DeathEffect.instance()
	get_parent().add_child(d)
	d.global_position = global_position + Vector2(0, -20)
