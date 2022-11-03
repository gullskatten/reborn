# This node is responsible for handling cut scene triggers
extends Node

signal trigger(triggerId)

func _ready():
	pass # Replace with function body.

func attemptTrigger(triggerId : String):
	emit_signal("trigger", triggerId)
