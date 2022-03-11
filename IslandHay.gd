extends Node

const DeathEffect = preload("res://structures/effects/GrassEffect.tscn")

func _on_CollectableResource_tree_exiting():
	queue_free()
	var d = DeathEffect.instance()
	d.global_position = self.global_position + Vector2(0, -20)
	get_parent().call_deferred("add_child", d)
