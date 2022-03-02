extends Button
onready var targetInfo = $TargetInfo

func _on_TargetButton_pressed():
	if Input.is_action_just_pressed("combine"):
		CurrentTarget.add_target(targetInfo)
	else:
		CurrentTarget.set_target(targetInfo)
