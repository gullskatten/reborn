class_name WorkerLoadCapacity

extends Node

onready var timer = $Timer

var currentLoad := 0
var resource_type : String = "" setget set_resource_type
var load_items : Dictionary = {}
export var maxResourceLoad := 100
export var intervalSeconds := 2.5
export var loadIncrement := 10 setget set_load_increment

signal is_full(val)
signal load_changed(val, increment)

func is_full() -> bool:
	return currentLoad == maxResourceLoad

func set_load_increment(val):
	loadIncrement = val

func set_resource_type(type):
	resource_type = type

func start_loading():
	timer.start(intervalSeconds)

func stop_loading():
	timer.stop()

func reset_load():
	currentLoad = 0
	load_items = {}
	
func get_load() -> Dictionary:
	return load_items

func _on_Timer_timeout():
	var nextIncrement = currentLoad + loadIncrement
	currentLoad = min(nextIncrement, maxResourceLoad)
	
	if currentLoad == maxResourceLoad:
		emit_signal("load_changed", currentLoad, loadIncrement)
		emit_signal("is_full", currentLoad)
		stop_loading()
	else:
		emit_signal("load_changed", currentLoad, loadIncrement)
	
	if load_items.has(resource_type):
		load_items[resource_type] = load_items[resource_type] + loadIncrement
	else:
		load_items[resource_type] = loadIncrement
