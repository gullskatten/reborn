extends Control

signal collect_tree
signal collect_stone
signal collect_till
signal unassign

func _on_CollectTree_pressed():
	emit_signal("collect_tree")

func _on_CollectStone_pressed():
	emit_signal("collect_stone")

func _on_CollectTill_pressed():
	emit_signal("collect_till")

func _on_Unassign_pressed():
	emit_signal("unassign")
