extends Node2D

export(bool) var light_south = true
export(bool) var light_west = true
export(bool) var light_east = true

onready var wall_light_s := $WallLightS
onready var wall_light_w := $WallLightW
onready var wall_light_e := $WallLightE

func _ready():
	wall_light_s.set_disabled(!light_south)
	wall_light_w.set_disabled(!light_west)
	wall_light_e.set_disabled(!light_east)


func _on_VisibilityNotifier2D_screen_entered():
	visible = true


func _on_VisibilityNotifier2D_screen_exited():
	visible = false
