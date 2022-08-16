extends VisibilityNotifier2D

func _on_HideOffScreen_screen_entered():
	get_parent().show()


func _on_HideOffScreen_screen_exited():
	get_parent().hide()
