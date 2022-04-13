extends Node2D

export(bool) var light_south = true
export(bool) var light_west = true
export(bool) var light_east = true

onready var wall_light_s := $WallLightS/Light2D
onready var wall_light_w := $WallLightW/Light2D
onready var wall_light_e := $WallLightE/Light2D

func _ready():
	wall_light_s.enabled = light_south
	wall_light_w.enabled = light_west
	wall_light_e.enabled = light_east
