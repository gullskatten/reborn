extends Node2D

onready var sprite = $Straw
onready var wildSwayShader = preload("res://assets/shaders/SwayWild.shader")

func _ready():
	var rand_sprite_frame = rand_range(0, sprite.vframes * sprite.hframes)
	sprite.frame = rand_sprite_frame
	$Shadow.frame = rand_sprite_frame
	
func reset_shader():
	sprite.material.set_shader_param("speed", 1.0)
	sprite.material.set_shader_param("maxStrength", 0.100)

func _on_Bush1_finished():
	reset_shader()

func _on_Bush2_finished():
	reset_shader()

func _on_SoftCollisions_body_entered(_body):
	sprite.material.set_shader_param("speed", 12.5)
	sprite.material.set_shader_param("maxStrength", 0.172)
	
	if randi() % 2 == 0:
		$Bush1.play()
	else:
		$Bush2.play()
