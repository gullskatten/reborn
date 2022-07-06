extends Node2D

export(bool) var emitting := true



func _ready():
	$Particles2D.visible = emitting
	$Particles2D.emitting = emitting
	$Particles2D2.visible = emitting
	$Particles2D2.emitting = emitting
