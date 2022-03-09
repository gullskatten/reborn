class_name ResourceStats

extends Node

export(int) var max_resource = 100 setget set_max_resource
var resource = max_resource setget set_resource

signal no_resource_left
signal resource_changed(decrement, resourceLeft)
signal max_resource_changed(value)

func set_max_resource(value):
	max_resource = value
	self.resource = min(resource, max_resource)
	emit_signal("max_resource_changed", value)

func decrease_resource(val):
	if resource - val <= 0:
		resource = 0
		emit_signal("resource_changed", val, resource)
		emit_signal("no_resource_left")
	else:
		resource -= val
		emit_signal("resource_changed", val, resource)

func set_resource(val):
	resource = val
	emit_signal("resource_changed", val, resource)
	if resource <= 0:
		emit_signal("no_resource_left")

func _ready():
	self.resource = max_resource
