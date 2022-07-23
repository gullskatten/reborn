extends Node2D

var AnimatedLoot = preload("res://player_items/AnimatedItemDrop.tscn")
const item = preload("res://data/Item.gd")

export(Array, String) var chest_item_ids = []
export(Array, int) var chest_item_quantities = []

onready var animationPlayer = $AnimationPlayer
var is_opened := false


func _on_PlayerEnterActionArea_action_pressed():
	if !is_opened:
		animationPlayer.play("Open")
		is_opened = true
		
		var chest_items = [
		"1", "3", "5", "9",
		"2", "6", "10", "9",
		"9", "2", "9", "9",
		"9", "3", "1", "9",
		"5", "9", "4", "4",
		"7", "7", "9", "9",
		"7", "6", "9", "9"]
		
		for item in chest_items:
			var loot = AnimatedLoot.instance()
			add_child(loot)
			loot.drop(item)

func _on_PlayerHintArea_body_entered(body):
	if !is_opened:
		animationPlayer.play("Unlock")
		
func _on_PlayerHintArea_body_exited(body):
	if !is_opened:
		animationPlayer.play("Lock")
