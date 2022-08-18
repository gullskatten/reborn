extends Item
class_name SellableItem

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var sell_price := 1

# Called when the node enters the scene tree for the first time.
func _ready():
	sellable = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
