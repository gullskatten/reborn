extends Node2D

onready var sprite = $Sprite
const MAX_SWAY = 0.3
const MIN_SWAY = 0.1
const MIN_SPEED = 1.0
const MAX_SPEED = 1.2

func _ready():
	var rand_sprite_frame = rand_range(0, sprite.vframes * sprite.hframes)
	sprite.frame = rand_sprite_frame
	$Shadow.frame = rand_sprite_frame

func _on_SoftCollision_body_entered(_body):
	sprite.get_material().set_shader_param("speed", 1.5)
	sprite.get_material().set_shader_param("maxStrength", 0.372)
	
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.set_parallel(true)
	tween.tween_property(sprite.get_material(), "shader_param/speed", -0.5, 0.4).from_current().as_relative()
	tween.tween_property(sprite.get_material(), "shader_param/maxStrength", -0.272, 0.4).from_current().as_relative()
	
	if randi() % 2 == 0:
		$Bush1.play()
	else:
		$Bush2.play()

