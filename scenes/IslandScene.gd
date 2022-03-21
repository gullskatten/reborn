extends Node2D

onready var deepWaterCollision = $Poly/DeepWaterCollision 

func _ready():
	for dock in get_tree().get_nodes_in_group("Dock"):
		dock.connect("deep_water_collision_off", self, "deep_water_collision_off")
		dock.connect("deep_water_collision_on", self, "deep_water_collision_on")
		
func deep_water_collision_off():
	deepWaterCollision.set_collision_layer_bit(0, false)
	deepWaterCollision.set_collision_mask_bit(0, false)
	
func deep_water_collision_on():
	deepWaterCollision.set_collision_layer_bit(0, true)
	deepWaterCollision.set_collision_mask_bit(0, true)
