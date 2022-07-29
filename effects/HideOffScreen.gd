extends VisibilityNotifier2D

func _on_HideOffScreen_screen_entered():
	print("Showing $", get_parent().name)
	get_parent().show()


func _on_HideOffScreen_screen_exited():
	print("Hiding $", get_parent().name)
	get_parent().hide()
