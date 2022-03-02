extends Node

class_name TargetInfo, "res://target/icon.svg"

export var display_name = "Name"
export var portrait: Texture = null
export var type = ""
export var level = 0
export var description = ""

# Constructor
func _init():
	print("Constructed!")
