extends Node2D

func _ready():
	rotation = rand_range(0.1, 0.2)
	if randi() % 4 == 0:
		$TextureRect.texture = load("res://assets/icons/inventory/shield_1_icon.png")
	elif randi() % 4 == 2:
		$TextureRect.texture = load("res://assets/icons/inventory/head_1_icon.png")
	elif randi() % 4 == 1:
		$TextureRect.texture = load("res://assets/icons/inventory/polearm_1_icon.png")
	else:
		$TextureRect.texture = load("res://assets/icons/inventory/chest_1_icon.png")
