extends Node2D

onready var sprite = $Sprite

# Spawn a random flower in set 1
export(bool) var is_random_flower := true

# Set this if is_random_flower is false to change flower type
export(int) var flower_idx := 0

func _ready():
	var max_frames = sprite.vframes * sprite.hframes-1
	if is_random_flower:
		var rand_sprite_frame = rand_range(0, max_frames)
		sprite.frame = rand_sprite_frame
		$Shadow.frame = rand_sprite_frame
	elif flower_idx > 0:
		sprite.frame = min(flower_idx, max_frames)
		$Shadow.frame = min(flower_idx, max_frames)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
