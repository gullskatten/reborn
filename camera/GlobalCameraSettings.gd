extends Node

const DEFAULT_ZOOM = Vector2(0.4, 0.4)
const MAX_ZOOM = Vector2(2.0, 2.0)
const MIN_ZOOM = Vector2(0.2, 0.2)
const ZOOM_FACTOR = Vector2(0.4, 0.4)
const ZOOM_LEVEL_INSIDE = Vector2(0.2, 0.2)

var zoom_level : Vector2 = DEFAULT_ZOOM setget set_zoom_level
var camera_position : Vector2 = Vector2(0,0) setget set_camera_position
var is_inside := false setget set_is_inside
var is_locked := false

signal zoom_level_changed(val)
signal camera_position_changed(pos)
signal max_zoom_level_changed(is_max)
signal forced_camera_position_changed(pos)
signal disable_movement()
signal enable_movement()
signal cutscene_start()
signal cutscene_end()
signal loading_transition_start()
signal loading_transition_end()

func zoom_out():
	if is_locked: return
	
	var next_zoom = zoom_level
	
	if next_zoom < MAX_ZOOM:
		if zoom_level == MIN_ZOOM:
			next_zoom = ZOOM_FACTOR
				
		elif zoom_level <= MAX_ZOOM:
			next_zoom += ZOOM_FACTOR

		if next_zoom == MAX_ZOOM:
			print("Max zoom reached")
			emit_signal("max_zoom_level_changed", true)
		set_zoom_level(next_zoom)
	
func zoom_in():
	if is_locked: return
	var next_zoom = zoom_level
	
	if zoom_level >= MIN_ZOOM:
		if zoom_level == MAX_ZOOM:
			emit_signal("max_zoom_level_changed", false)
			next_zoom -= ZOOM_FACTOR
			set_zoom_level(next_zoom)
		else: 
			next_zoom -= ZOOM_FACTOR
			if is_zero_approx(next_zoom.x) || next_zoom < Vector2.ZERO:
				set_zoom_level(MIN_ZOOM)
				print("Min zoom reached")
			else: 
				set_zoom_level(next_zoom)
	else:
		set_zoom_level(MIN_ZOOM)

func set_is_inside(inside: bool):
	is_inside = inside
	is_locked = inside
	
	if is_inside:
		zoom_level = ZOOM_LEVEL_INSIDE
		emit_signal("zoom_level_changed", zoom_level)
	
func set_zoom_level(zoom : Vector2):
	if zoom > Vector2.ZERO && !is_zero_approx(zoom.x) && zoom <= MAX_ZOOM && zoom != zoom_level:
		zoom_level = zoom
		emit_signal("zoom_level_changed", zoom)
		
func set_camera_position(pos):
	camera_position = pos
	emit_signal("camera_position_changed", pos)

func force_camera_position(pos):
	emit_signal("forced_camera_position_changed", pos)

func start_cutscene():
	emit_signal("cutscene_start")
	emit_signal("disable_movement")
	
func end_cutscene():
	emit_signal("cutscene_end")
	emit_signal("enable_movement")

func start_loading_transition():
	emit_signal("loading_transition_start")
	emit_signal("disable_movement")
	
func end_loading_transition():
	emit_signal("loading_transition_end")
	emit_signal("enable_movement")
