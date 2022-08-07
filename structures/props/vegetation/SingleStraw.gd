extends Node2D

onready var sprite = $Straw
onready var wildSwayShader = preload("res://assets/shaders/SwayWild.shader")

func _ready():
	var rand_sprite_frame = rand_range(0, sprite.vframes * sprite.hframes-1)
	sprite.frame = rand_sprite_frame
	$Shadow.frame = rand_sprite_frame
	
func reset_shader():
	sprite.material.set_shader_param("speed", 1)
	sprite.material.set_shader_param("max_strength", 0.100)

func _on_Bush1_finished():
	reset_shader()

func _on_Bush2_finished():
	reset_shader()

func _on_SoftCollisions_body_entered(_body):
	print(_body)
	sprite.material.set_shader_param("speed", 20)
	sprite.material.set_shader_param("max_strength", 0.572)
	
	if randi() % 2 == 0:
		$Bush1.play()
	else:
		$Bush2.play()
