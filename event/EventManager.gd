extends Node

enum EventType { 
	CREATURE_KILLED, 
	ZONE_ENTERED, 
	ZONE_EXITED, 
	ITEM_LOOTED,
	NPC_INTERACTED,
	WORLD_OBJECT_INTERACTED
}

signal on_creature_killed(id)
signal on_zone_entered(id)
signal on_zone_exited(id)
signal on_item_looted(id)
signal on_npc_interacted(id)
signal on_world_object_interacted(id)

func send_event(event_type, id: String) -> void:
	match typeof(event_type):
		EventType.CREATURE_KILLED:
			emit_signal("on_creature_killed", id)
		EventType.ZONE_ENTERED:
			emit_signal("on_zone_entered", id)
		EventType.ZONE_EXITED:
			emit_signal("on_zone_exited", id)
		EventType.ITEM_LOOTED:
			emit_signal("on_item_looted", id)
		EventType.NPC_INTERACTED:
			emit_signal("on_npc_interacted", id)
		EventType.WORLD_OBJECT_INTERACTED:
			emit_signal("on_world_object_interacted", id)

func _ready():
	pass 
