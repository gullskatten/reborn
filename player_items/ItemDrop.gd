extends Node2D

export(String) var item_id := "0" setget set_item_id
export(int) var quantity := 1 setget set_quantity

var item : Item = null
var player = null
var being_picked_up = false
const ACCELERATION = 460
const MAX_SPEED = 225
var velocity = Vector2.ZERO
onready var animationPlayer = $AnimationPlayer

func set_item_id(id):
	item_id = id
	update_icon(id)

func set_quantity(q):
	quantity = q
	update_text()

func update_text():
	if quantity > 1:
		$Label.visible = true
		$Label.text = str(quantity)
	else:
		$Label.visible = false

func update_icon(id):
	item = ItemsDataCache.get_item(id)
	$Sprite.texture = load("res://assets/icons/inventory/" + item.icon)

func _ready():
	$AudioStreamPlayer.pitch_scale = rand_range(0.9,1.6)
	$Sprite.rotation = rand_range(0.0, 0.2)
	set_item_id(item_id)

func pick_up_item():
	var has_space = PlayerInventory.add_item(self.item, quantity)
	
	if has_space:
		$AudioStreamPlayer.play()
		animationPlayer.play("Picked_up")
	else:
		$PlayerEnterActionArea.on_retry()
		animationPlayer.play("Invalid")
	
func _on_PlayerEnterActionArea_action_pressed():
	pick_up_item()

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Picked_up":
		queue_free()
	if anim_name == "Invalid":
		animationPlayer.play("Hover")
