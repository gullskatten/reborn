class_name WorkerLoadCapacity

extends Node

onready var timer = $Timer

var currentLoad := 0
export var maxResourceLoad := 100
export var intervalSeconds := 2.5
export var loadIncrement := 10 setget set_load_increment

signal is_full(val)
signal load_changed(val, increment)

func is_full() -> bool:
	return currentLoad == maxResourceLoad

func set_load_increment(val):
	loadIncrement = val
	
func start_loading():
	timer.start(intervalSeconds)

func stop_loading():
	timer.stop()

func reset_load():
	currentLoad = 0

func _on_Timer_timeout():
	var nextIncrement = currentLoad + loadIncrement
	currentLoad = min(nextIncrement, maxResourceLoad)
	
	if currentLoad == maxResourceLoad:
		emit_signal("load_changed", currentLoad, loadIncrement)
		emit_signal("is_full", currentLoad)
		stop_loading()
	else:
		emit_signal("load_changed", currentLoad, loadIncrement)
	
