extends YSort


func _ready():
	for child in get_children():
		if child is YSort:
			print(child.name)
			for gravestone in child.get_children():
				print(gravestone.name)
				if gravestone is Sprite:
					print(gravestone.name)
					var rand_frame = floor(rand_range(0, gravestone.vframes - 1))
					gravestone.frame = rand_frame
					gravestone.get_child(0).frame = rand_frame
