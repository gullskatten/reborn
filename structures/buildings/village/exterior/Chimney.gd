extends Node2D

export(bool) var emitting := true



func _ready():
	$Smoke/Particles2D.visible = emitting
	$Smoke/Particles2D.emitting = emitting
	$Smoke/Particles2D2.visible = emitting
	$Smoke/Particles2D2.emitting = emitting
