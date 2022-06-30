extends Node2D


onready var wildSwayShader = preload("res://assets/shaders/SwayWild.shader")

func _ready():
	$Sprite.frame = rand_range(0,$Sprite.vframes * $Sprite.hframes-1)

func _on_Player_body_entered(_body):
	$Sprite.material.set_shader_param("speed", 20)
	$Sprite.material.set_shader_param("max_strength", 0.272)
	if randi() % 2 == 0:
		$Bush1.play()
	else:
		$Bush2.play()
	
func reset_shader():
	$Sprite.material.set_shader_param("speed", 1)
	$Sprite.material.set_shader_param("max_strength", 0.100)

func _on_Bush1_finished():
	reset_shader()


func _on_Bush2_finished():
	reset_shader()


