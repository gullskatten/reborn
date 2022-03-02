extends Node

var target : TargetInfo = target setget set_target

signal cancel_target
signal target_changed(val)

func add_target(val: TargetInfo):
	print("Adding target!")
	pass
func set_target(val: TargetInfo):
	if val == null && target != null:
		emit_signal("cancel_target")
	elif val != null:
		print("Current target: " + val.display_name)
		
		target = val
		emit_signal("target_changed", val)
