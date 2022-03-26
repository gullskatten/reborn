extends Node

var target : TargetInfo = target setget set_target
var targets : Array = []
signal cancel_target
signal target_changed(val)
signal multi_target_changed(dict)

func has_worker_targets() -> bool:
	if has_targets():
		if target != null:
			return target.type == "Worker"
		else:
			for tar in targets:
				if tar.type == "Worker":
					return true
			return false
			
	else:
		return false

func has_targets() -> bool:
	return (!targets.empty()) or (target != null);
	
func set_multi_target(selection: Array):
	var targetsDict = {}
	for s in selection:
		if s is TargetInfo:
			
			targets.append(s)
			
			if targetsDict.has(s.type):
				var last_value = targetsDict.get(s.type)
				if last_value is Array:
					# remember, these arrays are by reference!
					last_value.append(s)
			else:
				targetsDict[s.type] = [s]
	
	if !targetsDict.empty():
		target = null
		emit_signal("multi_target_changed", targetsDict)

func cancel_targets():
	targets = []
	target = null
	emit_signal("cancel_target")
	
func set_target(val: TargetInfo):
	if val == null && target != null:
		emit_signal("cancel_target")
		target = null
	elif val != null:
		print("Current target: " + val.display_name)
		
		target = val
		emit_signal("target_changed", val)
