extends Control

onready var fps_label = $Effects/FPS
onready var time_label = $Effects/Time

func _ready():
	InTime.connect("current_minute_changed", self, "_update_time_text")

func _physics_process(_delta):
	fps_label.text = "FPS: " + str(Engine.get_frames_per_second()).pad_zeros(4)

func _update_time_text():
	time_label.text = InTime.current_cycle_to_string() + " " + InTime.current_time_string()
