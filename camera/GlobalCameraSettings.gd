extends Node

const DEFAULT_ZOOM = Vector2(0.4, 0.4)
const MAX_ZOOM = Vector2(3.4, 3.4)
const MIN_ZOOM = Vector2(0.2, 0.2)
const DISABLED_ZOOM = Vector2(1.2, 1.2)
const ZOOM_FACTOR = Vector2(0.4, 0.4)
const MIN_ZOOM_FACTOR = Vector2(0.2, 0.2)

var zoom_level : Vector2 = DEFAULT_ZOOM setget set_zoom_level
var camera_position : Vector2 = Vector2(0,0) setget set_camera_position

signal zoom_level_changed(val)
signal camera_position_changed(pos)
signal max_zoom_level_changed(is_max)

func zoom_out():
	var next_zoom = zoom_level
	if zoom_level == MIN_ZOOM:
		next_zoom = ZOOM_FACTOR
			
	elif zoom_level <= MAX_ZOOM:
		next_zoom += ZOOM_FACTOR
		# Removes jitter in tiles
	if zoom_level == DISABLED_ZOOM:
		next_zoom = Vector2(1.6, 1.6)
	
	if next_zoom != zoom_level && int(next_zoom.length()) == int(MAX_ZOOM.length() - ZOOM_FACTOR.length()):
		emit_signal("max_zoom_level_changed", true)
		
	set_zoom_level(next_zoom)
func zoom_in():
	var next_zoom = zoom_level
	if zoom_level >= MIN_ZOOM:
		if zoom_level == MIN_ZOOM:
			next_zoom = ZOOM_FACTOR
		
		if int(zoom_level.length()) == int(MAX_ZOOM.length()):
			emit_signal("max_zoom_level_changed", false)
			next_zoom -= ZOOM_FACTOR
		else: 
			if zoom_level == ZOOM_FACTOR:
				next_zoom -= MIN_ZOOM_FACTOR
			else:
				next_zoom -= ZOOM_FACTOR
	
	# Removes jitter in tiles
	if zoom_level == DISABLED_ZOOM:
		next_zoom = Vector2(0.8, 0.8)
		
	set_zoom_level(next_zoom)

func set_zoom_level(zoom):
	if zoom != zoom_level && zoom.length() >= MIN_ZOOM.length() && (zoom.length() <= MAX_ZOOM.length()):	
		zoom_level = zoom
		emit_signal("zoom_level_changed", zoom)
		
		
	
func set_camera_position(pos):
	camera_position = pos
	emit_signal("camera_position_changed", pos)
