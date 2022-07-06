extends Node2D

var max_jump_height := 48
var jump_decrease := 0.6
var max_jumps := 4
var jump_time := 0.5
var end_pos
var i

onready var starting_pos: Vector2 = global_position
onready var tween = $Tween
var ItemDrop = preload("res://player_items/ItemDrop.tscn")

func _ready():
	randomize()
	max_jump_height = int(rand_range(20, 50))
	jump_decrease = rand_range(0.3, 0.7)
	max_jumps = int(rand_range(1, 3))
	jump_time = rand_range(0.2, 0.6)
	end_pos = starting_pos + Vector2(rand_range(-20, 20), rand_range(-20, 20))	

func drop(item_id):
	global_position = starting_pos
	show()
	i = 0
	_bounce()
	var item = ItemDrop.instance()
	item.set_item_id(item_id)
	add_child(item)
	
func _bounce():
	var cur_jump_height = max_jump_height * pow(jump_decrease, i)
	var start_y = global_position.y
	var jump_time_up = jump_time*cur_jump_height/(end_pos.y-start_y+cur_jump_height*2)
	var jump_time_down = jump_time - jump_time_up
	
	tween.interpolate_property(self, "global_position:x", global_position.x, \
		end_pos.x, jump_time)
	tween.interpolate_property(self, "global_position:y", start_y, \
		end_pos.y-cur_jump_height, jump_time_up, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.interpolate_property(self, "global_position:y", \
		end_pos.y-cur_jump_height, end_pos.y, jump_time_down, \
		Tween.TRANS_QUAD, Tween.EASE_IN, jump_time_up)
	tween.start()
	i += 1

func _on_Tween_tween_all_completed():
	if i < max_jumps:
		_bounce()
