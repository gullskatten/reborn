class_name IslandTree
extends Node2D

onready var sprite = $Sprite

const DeathEffect = preload("res://structures/effects/GrassEffect.tscn")
const autumn_texture = preload("res://assets/props/trees/birch_trees_autumn.png")
const bare_texture = preload("res://assets/props/trees/birch_trees_bare.png")
const summer_texture = preload("res://assets/props/trees/birch_trees_summer.png")

func _ready():
	randomize()
	var rand = floor(rand_range(0, 5))
	var texture_list = [autumn_texture, bare_texture, summer_texture, summer_texture]
	sprite.set_frame(rand)
	texture_list.shuffle()
	sprite.texture = texture_list.pop_front()

func _on_CollectableResource_tree_exiting():
	queue_free()
	var d = DeathEffect.instance()
	d.global_position = self.global_position + Vector2(0, -20)
	get_parent().call_deferred("add_child", d)
