extends Control

onready var fps_label = $Effects/FPS

func _physics_process(delta):
	fps_label.text = "FPS: " + str(Engine.get_frames_per_second())
