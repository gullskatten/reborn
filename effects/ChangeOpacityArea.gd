extends Area2D

export var opacity: float = 0.5
export var maxOpacity: float = 1.0


func _on_ChangeOpacityArea_body_entered(body):
	get_parent().modulate.a = opacity


func _on_ChangeOpacityArea_body_exited(body):
	get_parent().modulate.a = maxOpacity
