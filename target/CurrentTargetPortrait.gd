extends Control

const CelestialActions = preload("res://ui/target/actions/celestial/AssignActions.tscn")

onready var displayName = $SingleTargetContainer/VBoxContainer/HBoxContainer/TargetInfo/DisplayName;
onready var type = $SingleTargetContainer/VBoxContainer/HBoxContainer/TargetInfo/Type
onready var level = $SingleTargetContainer/VBoxContainer/HBoxContainer/TargetInfo/LevelIndicator/Level
onready var levelLabel = $SingleTargetContainer/VBoxContainer/HBoxContainer/TargetInfo/LevelIndicator/LevelLabel
onready var portrait = $SingleTargetContainer/VBoxContainer/HBoxContainer/CenterContainer/PortraitTemplate/Portrait
onready var singleTargetContainer = $SingleTargetContainer
onready var multiTargetContainer = $MultiTargetContainer
onready var tabs = $MultiTargetContainer/VBoxContainer/TabContainer

static func delete_children(node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()

func _ready():	
	CurrentTarget.connect("multi_target_changed", self, "update_multi_target")
	CurrentTarget.connect("target_changed", self, "update_target")
	CurrentTarget.connect("cancel_target", self, "hide")
	
	visible = !(CurrentTarget.target == null)

func update_multi_target(targets: Dictionary):
	delete_children(tabs)
	
	for key in targets.keys():
		var node = Control.new()
		node.name = key + " (" +str(targets[key].size()) + ")"
		
		if key == "Celestial":
			var actionsPanel = CelestialActions.instance()
			node.add_child(actionsPanel)
		tabs.add_child(node)
		
	visible = true
	singleTargetContainer.visible = false
	multiTargetContainer.visible = true
	
	var tween = get_node("Tween")
	tween.interpolate_property(multiTargetContainer, "rect_position",
		multiTargetContainer.rect_global_position-Vector2(0, -50), multiTargetContainer.rect_global_position, 0.15,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	

func update_target(new_target):
	displayName.text = new_target.display_name
	type.text = new_target.type
	
	if(new_target.level != 0):
		level.text = str(new_target.level)
	else:
		levelLabel.visible = false
		level.visible = false
	
	if(new_target.portrait != null):
		portrait.texture = new_target.portrait
	
	visible = true
	singleTargetContainer.visible = true
	multiTargetContainer.visible = false
	var tween = get_node("Tween")
	tween.interpolate_property(singleTargetContainer, "rect_position",
		singleTargetContainer.rect_global_position-Vector2(0, -50), singleTargetContainer.rect_global_position, 0.15,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

func hide():
	visible = false

