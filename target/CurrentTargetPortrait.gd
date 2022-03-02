extends Control

onready var displayName = $PanelContainer/VBoxContainer/HBoxContainer/TargetInfo/DisplayName;
onready var type = $PanelContainer/VBoxContainer/HBoxContainer/TargetInfo/Type
onready var level = $PanelContainer/VBoxContainer/HBoxContainer/TargetInfo/LevelIndicator/Level
onready var portrait = $PanelContainer/VBoxContainer/HBoxContainer/CenterContainer/PortraitTemplate/Portrait

func _ready():
	print("Setting up connections..")
	CurrentTarget.connect("target_changed", self, "update_target")
	CurrentTarget.connect("cancel_target", self, "hide")
	
	visible = !(CurrentTarget.target == null)

func update_target(new_target):
	print("Updating target info!")
	displayName.text = new_target.display_name
	type.text = new_target.type
	
	if(new_target.level != 0):
		level.text = str(new_target.level)
	else:
		level.text = "Destructible"
	
	if(new_target.portrait != null):
		portrait.texture = new_target.portrait
	
	visible = true
	var tween = get_node("Tween")
	tween.interpolate_property($PanelContainer, "rect_position",
		$PanelContainer.rect_global_position-Vector2(0, -50), $PanelContainer.rect_global_position, 0.15,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

func hide():
	visible = false

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
