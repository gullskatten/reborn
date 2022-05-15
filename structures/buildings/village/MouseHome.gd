class_name MouseHome
extends Node2D

var housed_mice : Array = []
onready var unload_point = $UnloadPoint
onready var mouse_head_timer = $MouseHeadTimer
var can_load_mouse = true

func _on_MouseDetection_body_entered(body):
	if body is Critter and can_load_mouse:
		body.visible = false
		housed_mice.append(body)
		blink()
	
func blink():
	if !housed_mice.empty():
		var t = rand_range(2,8)
		yield(get_tree().create_timer(t*6),"timeout")
		if !housed_mice.empty():
			$MouseHeadInEntrance.visible = true
			mouse_head_timer.wait_time = t
			mouse_head_timer.start()
		else:
			$MouseHeadInEntrance.visible = false
			mouse_head_timer.stop()
func _on_MouseHeadTimer_timeout():
	$MouseHeadInEntrance.visible = false
	blink()


func _on_MouseBounceTimer_timeout():
	if !housed_mice.empty():
		var new_mouse = housed_mice.pop_back()
		new_mouse.visible = true
		new_mouse.wanderController.target_position = unload_point.position
		new_mouse.state_machine.transition_to("Wander")
		can_load_mouse = false
		yield(get_tree().create_timer(2),"timeout")
		can_load_mouse = true
		if housed_mice.empty():
			$MouseHeadInEntrance.visible = false
			mouse_head_timer.stop()
