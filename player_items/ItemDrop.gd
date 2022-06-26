extends Node2D

export(String) var item_id := "0"
export var quantity := 1

var item : Item = null
var player = null
var being_picked_up = false
const ACCELERATION = 460
const MAX_SPEED = 225
var velocity = Vector2.ZERO
onready var animationPlayer = $AnimationPlayer

func _ready():
	$Sprite.rotation = rand_range(0.0, 0.2)
	item = ItemsDataCache.get_item(item_id)
	$Sprite.texture = load("res://assets/icons/inventory/" + item.icon)

func pick_up_item():
	PlayerInventory.add_item(self.item, quantity)
	animationPlayer.play("Picked_up") 
	
func _on_PlayerEnterActionArea_action_pressed():
	pick_up_item()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Picked_up":
		queue_free()
