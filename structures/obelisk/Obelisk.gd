extends Node2D

onready var animationPlayer = $AnimationPlayer
onready var dot = $Dot
var new_dialog = null
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	dot.visible = false
	pass # Replace with function body.
	
func opened_finish():
	dot.visible = true
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Area2D_area_entered(area):
	animationPlayer.play("Open")


func _on_Area2D_area_exited(area):
	animationPlayer.play("Close")


func _on_Area2D_body_entered(body):
	animationPlayer.play("Open")
	
	new_dialog = Dialogic.start('Default_With_Intro') 
	new_dialog.connect("dialogic_signal", self, "dialog_listener")
	add_child(new_dialog)
	
func _on_Area2D_body_exited(body):
	dot.visible = false
	animationPlayer.play("Close")
	
	call_deferred("remove_child", new_dialog)
	self.new_dialog = null

func dialog_listener(string): 
	match string: 
		"new_worker_dialog": 
			print("New Worker Dialog")
		"new_building_dialog":
			print("New Building Dialog")
			

