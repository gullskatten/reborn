extends Node2D

export var resourceColor: Color = Color.mediumseagreen

const IncreaseLabel = preload("res://ui/SmallLabel.tscn")

onready var labelController = $LabelController

func _on_ResourceDepositArea_area_entered(area):
	var body = area.get_parent()
	if body is Worker && body.has_node("WorkerLoadCapacity"):
		var loadCapacity = body.get_node("WorkerLoadCapacity")
			
		if loadCapacity is WorkerLoadCapacity:
			var resourcesDict = loadCapacity.get_load()
			if resourcesDict is Dictionary:
				for key in resourcesDict.keys():
					var increaseLabel = IncreaseLabel.instance()
					increaseLabel.text = "+" + str(resourcesDict[key]) +" ("+ key + ")" 
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

