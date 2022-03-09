extends Node2D

export var level = 1

signal deep_water_collision_off
signal deep_water_collision_on

func _ready():
	$TargetButton/TargetInfo.level = level

	


func _on_PlayerZone_body_entered(body):
	print("Entered!")
	emit_signal("deep_water_collision_off")


func _on_PlayerZone_body_exited(body):
	print("Left!")
	emit_signal("deep_water_collision_on")
