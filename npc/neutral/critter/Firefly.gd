extends Node2D

func _ready():
	InTime.connect("current_cycle_changed", self, "set_visible")
	set_visible(InTime.current_cycle)
func set_visible(next_cycle):
	if next_cycle == InTime.CycleState.DUSK or next_cycle == InTime.CycleState.NIGHT:
		show()
	else:
		hide()
