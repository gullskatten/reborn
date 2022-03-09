extends Button
onready var targetInfo = $TargetInfo

func _on_TargetButton_pressed():
		CurrentTarget.set_target(targetInfo)
