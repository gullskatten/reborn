extends Sprite

onready var wildSwayShader = preload("res://assets/shaders/SwayWild.shader")

func _ready():
	frame = rand_range(0,vframes * hframes-1)

func reset_shader():
	material.set_shader_param("speed", 1)
	material.set_shader_param("max_strength", 0.100)

func _on_Bush1_finished():
	reset_shader()

func _on_Bush2_finished():
	reset_shader()

func _on_SoftCollisions_body_entered(_body):
	print("something hit!")
	print(_body)
	material.set_shader_param("speed", 20)
	material.set_shader_param("max_strength", 0.272)
	
	if randi() % 2 == 0:
		$Bush1.play()
	else:
		$Bush2.play()
