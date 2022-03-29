extends Control

export var keyHint : String = "E"
onready var label = $PanelContainer/CenterContainer/TinyLabel
onready var panel = $PanelContainer

func _ready():
	label.text = keyHint
	var n = 15 + 5 * label.text.length()
	panel.rect_size = Vector2(float(n), 12.0)

