class_name EnemyStats

extends Node

export(int) var max_health = 10 setget set_max_health
var health = max_health setget set_health

signal no_health_left
signal health_changed(decrement, healthLeft)
signal max_health_changed(value)

func set_max_health(value):
	max_health = value
	self.health = min(health, max_health)
	emit_signal("max_health_changed", value)

func decrease_health(val):
	if health - val <= 0:
		health = 0
		emit_signal("health_changed", val, health)
		emit_signal("no_health_left")
	else:
		health -= val
		emit_signal("health_changed", val, health)

func set_health(val):
	health = val
	emit_signal("health_changed", val, health)
	if health <= 0:
		emit_signal("no_health_left")

func _ready():
	self.health = max_health
