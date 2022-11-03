extends Area2D

export var triggerId := '1.1';

func _on_CutsceneTriggerArea_body_entered(body):
	CutSceneManager.attemptTrigger(triggerId)
