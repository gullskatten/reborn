extends Control

onready var fps_label = $Effects/FPS
onready var time_label = $Effects/Time

func _ready():
	Time.connect("current_minute_changed", self, "_update_time_text")


func _physics_process(delta):
	fps_label.text = "FPS: " + str(Engine.get_frames_per_second()).pad_zeros(4)

func _update_time_text():
	time_label.text = Time.current_cycle_to_string() + " " + Time.current_time_string()
