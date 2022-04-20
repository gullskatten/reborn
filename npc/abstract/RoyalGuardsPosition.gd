extends Position2D

onready var ysort = $YSort


func _ready():
	pass # Replace with function body.


func animate_moving_guards_start(direction : Vector2):
	for guard in ysort.get_children():
		if guard is Human:
			guard.animate_move(direction)
	
func animate_moving_guards_end(direction : Vector2):
	for guard in ysort.get_children():
		if guard is Human:
			guard.animate_idle(direction)
