extends Control

export var keyHint : String = "E"
onready var label = $PanelContainer/CenterContainer/Label
onready var panel = $PanelContainer

func _ready():
	label.text = keyHint
	var n = 30 + 10 * label.text.length()
	panel.rect_size = Vector2(float(n), 15.0)

