extends Node2D

onready var sprite = $Sprite
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	sprite.set_frame(floor(rand_range(0, 5)))
	
